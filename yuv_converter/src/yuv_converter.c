/**
 * yuv_converter.c
 * * YUV to RGB conversion library with ARM NEON and multi-threading optimizations.
 * Supports I420 (planar), NV12, and NV21 (bi-planar) formats.
 * * Features:
 * - ARM NEON SIMD instructions for high-performance conversion.
 * - Multi-threading to leverage multi-core CPUs.
 * - Dynamic thread count based on available CPU cores.
 * - Safe edge handling for image widths not divisible by 8.
 * - C fallback implementation for non-NEON platforms.
 */

 #include "yuv_converter.h"
 #include <stdlib.h> // For malloc, free
 #include <stdio.h>  // For printf
 
 #if defined(__ARM_NEON) || defined(__ARM_NEON__)
 #include <arm_neon.h>
 #endif
 
 // Platform-specific includes for threading and core count
 #if _WIN32
 #include <windows.h>
 #else
 #include <pthread.h>
 #include <unistd.h>
 #endif
 
 // Helper function to get the number of available CPU cores
 static int get_cpu_cores() {
 #if _WIN32
     SYSTEM_INFO sysinfo;
     GetSystemInfo(&sysinfo);
     return sysinfo.dwNumberOfProcessors > 0 ? sysinfo.dwNumberOfProcessors : 1;
 #elif defined(_SC_NPROCESSORS_ONLN)
     long cores = sysconf(_SC_NPROCESSORS_ONLN);
     return cores > 0 ? (int)cores : 1;
 #else
     // Fallback for unknown platforms
     return 2;
 #endif
 }
 
 #if defined(__ARM_NEON) || defined(__ARM_NEON__)
 
 // Arguments for the planar conversion thread
 typedef struct {
     const uint8_t* y_plane;
     const uint8_t* u_plane;
     const uint8_t* v_plane;
     int y_stride;
     int u_stride;
     int v_stride;
     int width;
     uint8_t* rgb_data;
     int start_row;
     int end_row;
 } ThreadArgsPlanar;
 
 // Arguments for the bi-planar conversion thread
 typedef struct {
     const uint8_t* y_plane;
     const uint8_t* uv_plane;
     int y_stride;
     int uv_stride;
     int width;
     uint8_t* rgb_data;
     int start_row;
     int end_row;
     BiplanarFormat format;
 } ThreadArgsBiplanar;
 
 // Worker function for planar (I420) conversion with NEON
 void* convert_planar_worker(void* args) {
     ThreadArgsPlanar* thread_args = (ThreadArgsPlanar*)args;
     
     const uint8_t* y_plane = thread_args->y_plane;
     const uint8_t* u_plane = thread_args->u_plane;
     const uint8_t* v_plane = thread_args->v_plane;
     int y_stride = thread_args->y_stride;
     int u_stride = thread_args->u_stride;
     int v_stride = thread_args->v_stride;
     int width = thread_args->width;
     uint8_t* rgb_data = thread_args->rgb_data;
     int start_y = thread_args->start_row;
     int end_y = thread_args->end_row;
 
     const int16x8_t const_16 = vdupq_n_s16(16);
     const int16x8_t const_128 = vdupq_n_s16(128);
 
     for (int y = start_y; y < end_y; y += 2) {
         for (int x = 0; x < width; x += 8) {
             int safe_width = (x + 8 <= width) ? 8 : width - x;
 
             const uint8_t* y_ptr_top = y_plane + y * y_stride + x;
             const uint8_t* y_ptr_bottom = y_plane + (y + 1) * y_stride + x;
             const uint8_t* u_ptr = u_plane + (y / 2) * u_stride + (x / 2);
             const uint8_t* v_ptr = v_plane + (y / 2) * v_stride + (x / 2);
             uint8_t* rgb_ptr_top = rgb_data + (y * width + x) * 3;
             uint8_t* rgb_ptr_bottom = rgb_data + ((y + 1) * width + x) * 3;
 
             // Load Y, U, V values
             uint8x8_t y_top_u8, y_bottom_u8;
             uint8x8_t u_u8_4, v_u8_4; // 4 values of U and V
 
             if (safe_width == 8) {
                 y_top_u8 = vld1_u8(y_ptr_top);
                 y_bottom_u8 = vld1_u8(y_ptr_bottom);
                 u_u8_4 = vld1_u8(u_ptr); // Loads u0,u1,u2,u3,...
                 v_u8_4 = vld1_u8(v_ptr); // Loads v0,v1,v2,v3,...
             } else {
                 uint8_t y_top_temp[8] = {0}, y_bottom_temp[8] = {0};
                 uint8_t u_temp[8] = {0}, v_temp[8] = {0};
                 
                 for(int i = 0; i < safe_width; ++i) {
                     y_top_temp[i] = y_ptr_top[i];
                     y_bottom_temp[i] = y_ptr_bottom[i];
                 }
                 for(int i = 0; i < (safe_width + 1) / 2; ++i) {
                     u_temp[i] = u_ptr[i];
                     v_temp[i] = v_ptr[i];
                 }
 
                 y_top_u8 = vld1_u8(y_top_temp);
                 y_bottom_u8 = vld1_u8(y_bottom_temp);
                 u_u8_4 = vld1_u8(u_temp);
                 v_u8_4 = vld1_u8(v_temp);
             }
             
             // Upsample U and V from 4 values to 8: e.g., {u0,u1,u2,u3} -> {u0,u0,u1,u1,u2,u2,u3,u3}
             int16x8_t u_s16 = vmovl_u8(u_u8_4);
             int16x8_t v_s16 = vmovl_u8(v_u8_4);
             u_s16 = vzipq_s16(u_s16, u_s16).val[0];
             v_s16 = vzipq_s16(v_s16, v_s16).val[0];
 
             // Convert Y to signed 16-bit
             int16x8_t y_top_s16 = vmovl_u8(y_top_u8);
             int16x8_t y_bottom_s16 = vmovl_u8(y_bottom_u8);
 
             // Subtract offsets
             int16x8_t c_top_s16 = vsubq_s16(y_top_s16, const_16);
             int16x8_t c_bottom_s16 = vsubq_s16(y_bottom_s16, const_16);
             int16x8_t d_s16 = vsubq_s16(u_s16, const_128);
             int16x8_t e_s16 = vsubq_s16(v_s16, const_128);
 
             // YUV to RGB conversion math
             int16x4_t c_top_lo = vget_low_s16(c_top_s16);
             int16x4_t c_top_hi = vget_high_s16(c_top_s16);
             int16x4_t d_lo = vget_low_s16(d_s16);
             int16x4_t d_hi = vget_high_s16(d_s16);
             int16x4_t e_lo = vget_low_s16(e_s16);
             int16x4_t e_hi = vget_high_s16(e_s16);

             int32x4_t r_top_lo = vaddq_s32(vmull_n_s16(c_top_lo, 298), vmull_n_s16(e_lo, 409));
             int32x4_t r_top_hi = vaddq_s32(vmull_n_s16(c_top_hi, 298), vmull_n_s16(e_hi, 409));
             int32x4_t g_top_lo = vsubq_s32(vsubq_s32(vmull_n_s16(c_top_lo, 298), vmull_n_s16(d_lo, 100)), vmull_n_s16(e_lo, 208));
             int32x4_t g_top_hi = vsubq_s32(vsubq_s32(vmull_n_s16(c_top_hi, 298), vmull_n_s16(d_hi, 100)), vmull_n_s16(e_hi, 208));
             int32x4_t b_top_lo = vaddq_s32(vmull_n_s16(c_top_lo, 298), vmull_n_s16(d_lo, 516));
             int32x4_t b_top_hi = vaddq_s32(vmull_n_s16(c_top_hi, 298), vmull_n_s16(d_hi, 516));

             int16x8_t r_top = vcombine_s16(vrshrn_n_s32(r_top_lo, 8), vrshrn_n_s32(r_top_hi, 8));
             int16x8_t g_top = vcombine_s16(vrshrn_n_s32(g_top_lo, 8), vrshrn_n_s32(g_top_hi, 8));
             int16x8_t b_top = vcombine_s16(vrshrn_n_s32(b_top_lo, 8), vrshrn_n_s32(b_top_hi, 8));
 
             // Bottom row
             int16x4_t c_bottom_lo = vget_low_s16(c_bottom_s16);
             int16x4_t c_bottom_hi = vget_high_s16(c_bottom_s16);
             int32x4_t r_bottom_lo = vaddq_s32(vmull_n_s16(c_bottom_lo, 298), vmull_n_s16(e_lo, 409));
             int32x4_t r_bottom_hi = vaddq_s32(vmull_n_s16(c_bottom_hi, 298), vmull_n_s16(e_hi, 409));
             int32x4_t g_bottom_lo = vsubq_s32(vsubq_s32(vmull_n_s16(c_bottom_lo, 298), vmull_n_s16(d_lo, 100)), vmull_n_s16(e_lo, 208));
             int32x4_t g_bottom_hi = vsubq_s32(vsubq_s32(vmull_n_s16(c_bottom_hi, 298), vmull_n_s16(d_hi, 100)), vmull_n_s16(e_hi, 208));
             int32x4_t b_bottom_lo = vaddq_s32(vmull_n_s16(c_bottom_lo, 298), vmull_n_s16(d_lo, 516));
             int32x4_t b_bottom_hi = vaddq_s32(vmull_n_s16(c_bottom_hi, 298), vmull_n_s16(d_hi, 516));

             int16x8_t r_bottom = vcombine_s16(vrshrn_n_s32(r_bottom_lo, 8), vrshrn_n_s32(r_bottom_hi, 8));
             int16x8_t g_bottom = vcombine_s16(vrshrn_n_s32(g_bottom_lo, 8), vrshrn_n_s32(g_bottom_hi, 8));
             int16x8_t b_bottom = vcombine_s16(vrshrn_n_s32(b_bottom_lo, 8), vrshrn_n_s32(b_bottom_hi, 8));
 
             // Store results
             uint8x8x3_t rgb_top, rgb_bottom;
             rgb_top.val[0] = vqmovun_s16(r_top);
             rgb_top.val[1] = vqmovun_s16(g_top);
             rgb_top.val[2] = vqmovun_s16(b_top);
 
             rgb_bottom.val[0] = vqmovun_s16(r_bottom);
             rgb_bottom.val[1] = vqmovun_s16(g_bottom);
             rgb_bottom.val[2] = vqmovun_s16(b_bottom);
 
             if (safe_width == 8) {
                 vst3_u8(rgb_ptr_top, rgb_top);
                 vst3_u8(rgb_ptr_bottom, rgb_bottom);
             } else {
                 uint8_t temp_top[24], temp_bottom[24];
                 vst3_u8(temp_top, rgb_top);
                 vst3_u8(temp_bottom, rgb_bottom);
                 for (int i = 0; i < safe_width; ++i) {
                     rgb_ptr_top[i * 3 + 0] = temp_top[i * 3 + 0];
                     rgb_ptr_top[i * 3 + 1] = temp_top[i * 3 + 1];
                     rgb_ptr_top[i * 3 + 2] = temp_top[i * 3 + 2];
                     rgb_ptr_bottom[i * 3 + 0] = temp_bottom[i * 3 + 0];
                     rgb_ptr_bottom[i * 3 + 1] = temp_bottom[i * 3 + 1];
                     rgb_ptr_bottom[i * 3 + 2] = temp_bottom[i * 3 + 2];
                 }
             }
         }
     }
     return NULL;
 }
 
 // Worker function for bi-planar (NV12/NV21) conversion with NEON
 void* convert_biplanar_worker(void* args) {
     ThreadArgsBiplanar* thread_args = (ThreadArgsBiplanar*)args;
 
     const uint8_t* y_plane = thread_args->y_plane;
     const uint8_t* uv_plane = thread_args->uv_plane;
     int y_stride = thread_args->y_stride;
     int uv_stride = thread_args->uv_stride;
     int width = thread_args->width;
     uint8_t* rgb_data = thread_args->rgb_data;
     int start_y = thread_args->start_row;
     int end_y = thread_args->end_row;
 
     const int16x8_t const_16 = vdupq_n_s16(16);
     const int16x8_t const_128 = vdupq_n_s16(128);
 
     for (int y = start_y; y < end_y; y += 2) {
         for (int x = 0; x < width; x += 8) {
             int safe_width = (x + 8 <= width) ? 8 : width - x;
 
             const uint8_t* y_ptr_top = y_plane + y * y_stride + x;
             const uint8_t* y_ptr_bottom = y_plane + (y + 1) * y_stride + x;
             const uint8_t* uv_ptr = uv_plane + (y / 2) * uv_stride + x;
             uint8_t* rgb_ptr_top = rgb_data + (y * width + x) * 3;
             uint8_t* rgb_ptr_bottom = rgb_data + ((y + 1) * width + x) * 3;
             
             // Load Y and de-interleaved UV
             uint8x8_t y_top_u8, y_bottom_u8;
             uint8x8x2_t uv_u8_deinterleaved;
 
             if (safe_width == 8) {
                 y_top_u8 = vld1_u8(y_ptr_top);
                 y_bottom_u8 = vld1_u8(y_ptr_bottom);
                 uv_u8_deinterleaved = vld2_u8(uv_ptr); // Loads 8 pairs (16 bytes) of UV
             } else {
                 uint8_t y_top_temp[8] = {0}, y_bottom_temp[8] = {0};
                 uint8_t uv_temp[16] = {0};
                 
                 for (int i = 0; i < safe_width; i++) {
                     y_top_temp[i] = y_ptr_top[i];
                     y_bottom_temp[i] = y_ptr_bottom[i];
                 }
                 // For safe_width Y pixels, we have safe_width/2 UV pairs, which is safe_width bytes.
                 for (int i = 0; i < safe_width; i++) {
                     uv_temp[i] = uv_ptr[i];
                 }
                 
                 y_top_u8 = vld1_u8(y_top_temp);
                 y_bottom_u8 = vld1_u8(y_bottom_temp);
                 uv_u8_deinterleaved = vld2_u8(uv_temp);
             }
 
             uint8x8_t u_vals, v_vals;
             if (thread_args->format == NV21) { // VUVU...
                 u_vals = uv_u8_deinterleaved.val[1];
                 v_vals = uv_u8_deinterleaved.val[0];
             } else { // NV12, UVUV...
                 u_vals = uv_u8_deinterleaved.val[0];
                 v_vals = uv_u8_deinterleaved.val[1];
             }
             
             // Upsample U and V from 4 values to 8
             int16x8_t u_s16 = vmovl_u8(u_vals);
             int16x8_t v_s16 = vmovl_u8(v_vals);
             u_s16 = vzipq_s16(u_s16, u_s16).val[0];
             v_s16 = vzipq_s16(v_s16, v_s16).val[0];
             
             // Convert Y to signed 16-bit
             int16x8_t y_top_s16 = vmovl_u8(y_top_u8);
             int16x8_t y_bottom_s16 = vmovl_u8(y_bottom_u8);
 
             // The rest of the logic is identical to the planar worker
             int16x8_t c_top_s16 = vsubq_s16(y_top_s16, const_16);
             int16x8_t c_bottom_s16 = vsubq_s16(y_bottom_s16, const_16);
             int16x8_t d_s16 = vsubq_s16(u_s16, const_128);
             int16x8_t e_s16 = vsubq_s16(v_s16, const_128);
 
             // YUV to RGB conversion math
             int16x4_t c_top_lo = vget_low_s16(c_top_s16);
             int16x4_t c_top_hi = vget_high_s16(c_top_s16);
             int16x4_t d_lo = vget_low_s16(d_s16);
             int16x4_t d_hi = vget_high_s16(d_s16);
             int16x4_t e_lo = vget_low_s16(e_s16);
             int16x4_t e_hi = vget_high_s16(e_s16);

             int32x4_t r_top_lo = vaddq_s32(vmull_n_s16(c_top_lo, 298), vmull_n_s16(e_lo, 409));
             int32x4_t r_top_hi = vaddq_s32(vmull_n_s16(c_top_hi, 298), vmull_n_s16(e_hi, 409));
             int32x4_t g_top_lo = vsubq_s32(vsubq_s32(vmull_n_s16(c_top_lo, 298), vmull_n_s16(d_lo, 100)), vmull_n_s16(e_lo, 208));
             int32x4_t g_top_hi = vsubq_s32(vsubq_s32(vmull_n_s16(c_top_hi, 298), vmull_n_s16(d_hi, 100)), vmull_n_s16(e_hi, 208));
             int32x4_t b_top_lo = vaddq_s32(vmull_n_s16(c_top_lo, 298), vmull_n_s16(d_lo, 516));
             int32x4_t b_top_hi = vaddq_s32(vmull_n_s16(c_top_hi, 298), vmull_n_s16(d_hi, 516));

             int16x8_t r_top = vcombine_s16(vrshrn_n_s32(r_top_lo, 8), vrshrn_n_s32(r_top_hi, 8));
             int16x8_t g_top = vcombine_s16(vrshrn_n_s32(g_top_lo, 8), vrshrn_n_s32(g_top_hi, 8));
             int16x8_t b_top = vcombine_s16(vrshrn_n_s32(b_top_lo, 8), vrshrn_n_s32(b_top_hi, 8));
 
             // Bottom row
             int16x4_t c_bottom_lo = vget_low_s16(c_bottom_s16);
             int16x4_t c_bottom_hi = vget_high_s16(c_bottom_s16);
             int32x4_t r_bottom_lo = vaddq_s32(vmull_n_s16(c_bottom_lo, 298), vmull_n_s16(e_lo, 409));
             int32x4_t r_bottom_hi = vaddq_s32(vmull_n_s16(c_bottom_hi, 298), vmull_n_s16(e_hi, 409));
             int32x4_t g_bottom_lo = vsubq_s32(vsubq_s32(vmull_n_s16(c_bottom_lo, 298), vmull_n_s16(d_lo, 100)), vmull_n_s16(e_lo, 208));
             int32x4_t g_bottom_hi = vsubq_s32(vsubq_s32(vmull_n_s16(c_bottom_hi, 298), vmull_n_s16(d_hi, 100)), vmull_n_s16(e_hi, 208));
             int32x4_t b_bottom_lo = vaddq_s32(vmull_n_s16(c_bottom_lo, 298), vmull_n_s16(d_lo, 516));
             int32x4_t b_bottom_hi = vaddq_s32(vmull_n_s16(c_bottom_hi, 298), vmull_n_s16(d_hi, 516));

             int16x8_t r_bottom = vcombine_s16(vrshrn_n_s32(r_bottom_lo, 8), vrshrn_n_s32(r_bottom_hi, 8));
             int16x8_t g_bottom = vcombine_s16(vrshrn_n_s32(g_bottom_lo, 8), vrshrn_n_s32(g_bottom_hi, 8));
             int16x8_t b_bottom = vcombine_s16(vrshrn_n_s32(b_bottom_lo, 8), vrshrn_n_s32(b_bottom_hi, 8));
 
             // Store results
             uint8x8x3_t rgb_top, rgb_bottom;
             rgb_top.val[0] = vqmovun_s16(r_top);
             rgb_top.val[1] = vqmovun_s16(g_top);
             rgb_top.val[2] = vqmovun_s16(b_top);
 
             rgb_bottom.val[0] = vqmovun_s16(r_bottom);
             rgb_bottom.val[1] = vqmovun_s16(g_bottom);
             rgb_bottom.val[2] = vqmovun_s16(b_bottom);
             
             if (safe_width == 8) {
                 vst3_u8(rgb_ptr_top, rgb_top);
                 vst3_u8(rgb_ptr_bottom, rgb_bottom);
             } else {
                 uint8_t temp_top[24], temp_bottom[24];
                 vst3_u8(temp_top, rgb_top);
                 vst3_u8(temp_bottom, rgb_bottom);
                 for (int i = 0; i < safe_width; ++i) {
                     rgb_ptr_top[i * 3 + 0] = temp_top[i * 3 + 0];
                     rgb_ptr_top[i * 3 + 1] = temp_top[i * 3 + 1];
                     rgb_ptr_top[i * 3 + 2] = temp_top[i * 3 + 2];
                     rgb_ptr_bottom[i * 3 + 0] = temp_bottom[i * 3 + 0];
                     rgb_ptr_bottom[i * 3 + 1] = temp_bottom[i * 3 + 1];
                     rgb_ptr_bottom[i * 3 + 2] = temp_bottom[i * 3 + 2];
                 }
             }
         }
     }
     return NULL;
 }
 
 #endif
 
 // Helper function to clamp a value between a min and max.
 static inline int clamp(int value, int min_val, int max_val) {
     return value < min_val ? min_val : (value > max_val ? max_val : value);
 }
 
 // Helper function to convert a single YUV pixel to RGB, using integer arithmetic.
 static void yuv_to_rgb_c(uint8_t y, uint8_t u, uint8_t v, uint8_t* r, uint8_t* g, uint8_t* b) {
     int c = y - 16;
     int d = u - 128;
     int e = v - 128;
 
     *r = clamp((298 * c + 409 * e + 128) >> 8, 0, 255);
     *g = clamp((298 * c - 100 * d - 208 * e + 128) >> 8, 0, 255);
     *b = clamp((298 * c + 516 * d + 128) >> 8, 0, 255);
 }
 
 FFI_PLUGIN_EXPORT RgbImage* convert_yuv_to_rgb_planar(
     uint8_t* y_plane,
     uint8_t* u_plane,
     uint8_t* v_plane,
     int y_stride,
     int u_stride,
     int v_stride,
     int width,
     int height
 ) {
 #if defined(__ARM_NEON) || defined(__ARM_NEON__)
     static int neon_log_printed = 0;
     if (!neon_log_printed) {
         printf("DEBUG: Using NEON optimized, multi-threaded path for planar conversion.\n");
         neon_log_printed = 1;
     }
 
     if (!y_plane || !u_plane || !v_plane) return NULL;
 
     int rgb_size = width * height * 3;
     uint8_t* rgb_data = (uint8_t*)malloc(rgb_size);
     if (!rgb_data) return NULL;
 
     const int num_threads = get_cpu_cores();
     pthread_t* threads = (pthread_t*)malloc(num_threads * sizeof(pthread_t));
     ThreadArgsPlanar* thread_args = (ThreadArgsPlanar*)malloc(num_threads * sizeof(ThreadArgsPlanar));
     if (!threads || !thread_args) {
         free(rgb_data);
         free(threads);
         free(thread_args);
         return NULL;
     }
     
     int rows_per_thread = (height + num_threads - 1) / num_threads;
     if (rows_per_thread % 2 != 0) {
         rows_per_thread++;
     }
 
     int active_threads = 0;
     for (int i = 0; i < num_threads; i++) {
         int start_row = i * rows_per_thread;
         int end_row = start_row + rows_per_thread;
         if (end_row > height) end_row = height;
 
         if (start_row < end_row) {
             thread_args[i] = (ThreadArgsPlanar){y_plane, u_plane, v_plane, y_stride, u_stride, v_stride, width, rgb_data, start_row, end_row};
             pthread_create(&threads[i], NULL, convert_planar_worker, &thread_args[i]);
             active_threads++;
         } else {
             threads[i] = 0; // Mark as inactive
         }
     }
 
     for (int i = 0; i < num_threads; i++) {
         if (threads[i] != 0) {
             pthread_join(threads[i], NULL);
         }
     }
 
     free(threads);
     free(thread_args);
 
     RgbImage* result = (RgbImage*)malloc(sizeof(RgbImage));
     if (!result) {
         free(rgb_data);
         return NULL;
     }
     result->data = rgb_data;
     result->width = width;
     result->height = height;
 
     return result;
 
 #else
     // C Fallback implementation
     static int c_log_printed = 0;
     if (!c_log_printed) {
         printf("DEBUG: Using C fallback path for planar conversion.\n");
         c_log_printed = 1;
     }
     if (!y_plane || !u_plane || !v_plane) return NULL;
 
     int rgb_size = width * height * 3;
     uint8_t* rgb_data = (uint8_t*)malloc(rgb_size);
     if (!rgb_data) return NULL;
     
     for (int y = 0; y < height; y++) {
         for (int x = 0; x < width; x++) {
             int y_index = y * y_stride + x;
             int uv_index = (y / 2) * u_stride + (x / 2); // Assuming U and V have same stride
             int v_uv_index = (y / 2) * v_stride + (x / 2);
 
             uint8_t y_val = y_plane[y_index];
             uint8_t u_val = u_plane[uv_index];
             uint8_t v_val = v_plane[v_uv_index];
 
             int rgb_index = (y * width + x) * 3;
             yuv_to_rgb_c(y_val, u_val, v_val, &rgb_data[rgb_index], &rgb_data[rgb_index + 1], &rgb_data[rgb_index + 2]);
         }
     }
 
     RgbImage* result = (RgbImage*)malloc(sizeof(RgbImage));
     if (!result) {
         free(rgb_data);
         return NULL;
     }
     result->data = rgb_data;
     result->width = width;
     result->height = height;
 
     return result;
 #endif
 }
 
 FFI_PLUGIN_EXPORT RgbImage* convert_yuv_to_rgb_biplanar(
     uint8_t* y_plane,
     uint8_t* uv_plane,
     int y_stride,
     int uv_stride,
     int uv_pixel_stride,
     int width,
     int height,
     BiplanarFormat format
 ) {
 #if defined(__ARM_NEON) || defined(__ARM_NEON__)
     static int neon_log_printed = 0;
     if (!neon_log_printed) {
         printf("DEBUG: Using NEON optimized, multi-threaded path for bi-planar conversion.\n");
         neon_log_printed = 1;
     }
     
     if (!y_plane || !uv_plane) return NULL;
 
     int rgb_size = width * height * 3;
     uint8_t* rgb_data = (uint8_t*)malloc(rgb_size);
     if (!rgb_data) return NULL;
     
     const int num_threads = get_cpu_cores();
     pthread_t* threads = (pthread_t*)malloc(num_threads * sizeof(pthread_t));
     ThreadArgsBiplanar* thread_args = (ThreadArgsBiplanar*)malloc(num_threads * sizeof(ThreadArgsBiplanar));
     if (!threads || !thread_args) {
         free(rgb_data);
         free(threads);
         free(thread_args);
         return NULL;
     }
 
     int rows_per_thread = (height + num_threads - 1) / num_threads;
     if (rows_per_thread % 2 != 0) {
         rows_per_thread++;
     }
 
     for (int i = 0; i < num_threads; i++) {
         int start_row = i * rows_per_thread;
         int end_row = start_row + rows_per_thread;
         if (end_row > height) end_row = height;
 
         if (start_row < end_row) {
             thread_args[i] = (ThreadArgsBiplanar){y_plane, uv_plane, y_stride, uv_stride, width, rgb_data, start_row, end_row, format};
             pthread_create(&threads[i], NULL, convert_biplanar_worker, &thread_args[i]);
         } else {
             threads[i] = 0;
         }
     }
 
     for (int i = 0; i < num_threads; i++) {
         if(threads[i] != 0) {
             pthread_join(threads[i], NULL);
         }
     }
     
     free(threads);
     free(thread_args);
 
     RgbImage* result = (RgbImage*)malloc(sizeof(RgbImage));
     if (!result) {
         free(rgb_data);
         return NULL;
     }
     result->data = rgb_data;
     result->width = width;
     result->height = height;
 
     return result;
 
 #else
     // C Fallback implementation
     static int c_log_printed = 0;
     if (!c_log_printed) {
         printf("DEBUG: Using C fallback path for bi-planar conversion.\n");
         c_log_printed = 1;
     }
     if (!y_plane || !uv_plane) return NULL;
 
     int rgb_size = width * height * 3;
     uint8_t* rgb_data = (uint8_t*)malloc(rgb_size);
     if (!rgb_data) return NULL;
     
     for (int y = 0; y < height; y++) {
         for (int x = 0; x < width; x++) {
             int y_index = y * y_stride + x;
             int uv_index = (y / 2) * uv_stride + (x / 2) * uv_pixel_stride;
             
             uint8_t y_val = y_plane[y_index];
             uint8_t u_val, v_val;
 
             if (format == NV21) { // VUVU...
                 v_val = uv_plane[uv_index];
                 u_val = uv_plane[uv_index + 1];
             } else { // NV12, UVUV...
                 u_val = uv_plane[uv_index];
                 v_val = uv_plane[uv_index + 1];
             }
 
             int rgb_index = (y * width + x) * 3;
             yuv_to_rgb_c(y_val, u_val, v_val, &rgb_data[rgb_index], &rgb_data[rgb_index + 1], &rgb_data[rgb_index + 2]);
         }
     }
     
     RgbImage* result = (RgbImage*)malloc(sizeof(RgbImage));
     if (!result) {
         free(rgb_data);
         return NULL;
     }
     result->data = rgb_data;
     result->width = width;
     result->height = height;
 
     return result;
 #endif
 }
 
 FFI_PLUGIN_EXPORT void free_image_memory(RgbImage* image) {
     if (image) {
         if (image->data) {
             free(image->data);
             image->data = NULL;
         }
         free(image);
     }
 }
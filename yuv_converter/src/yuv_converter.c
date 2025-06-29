#include "yuv_converter.h"
#include <stdlib.h> // For malloc, free
#include <stdio.h> // For printf

#if defined(__ARM_NEON) || defined(__ARM_NEON__)
#include <arm_neon.h>
#endif

// Helper function to clamp a value between a min and max.
int clamp(int value, int min_val, int max_val) {
    if (value < min_val) return min_val;
    if (value > max_val) return max_val;
    return value;
}

// Helper function to convert a single YUV pixel to RGB, written in pure C.
void yuv_to_rgb(uint8_t y, uint8_t u, uint8_t v, uint8_t* r, uint8_t* g, uint8_t* b) {
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
    int uv_stride,
    int width,
    int height
) {
#if defined(__ARM_NEON) || defined(__ARM_NEON__)
    static int neon_log_printed = 0;
    if (!neon_log_printed) {
        printf("DEBUG: Using NEON optimized path for convert_yuv_to_rgb_planar.\n");
        neon_log_printed = 1;
    }
    // NEON-optimized implementation for I420
    if (!y_plane || !u_plane || !v_plane) {
        return NULL;
    }

    int rgb_size = width * height * 3;
    uint8_t* rgb_data = (uint8_t*)malloc(rgb_size * sizeof(uint8_t));
    if (!rgb_data) {
        return NULL;
    }

    const int16x8_t const_16 = vdupq_n_s16(16);
    const int16x8_t const_128 = vdupq_n_s16(128);

    for (int y = 0; y < height; y += 2) {
        for (int x = 0; x < width; x += 8) {
            uint8_t* y_ptr_top = y_plane + y * y_stride + x;
            uint8_t* y_ptr_bottom = y_plane + (y + 1) * y_stride + x;
            uint8_t* u_ptr = u_plane + (y / 2) * (uv_stride) + (x / 2);
            uint8_t* v_ptr = v_plane + (y / 2) * (uv_stride) + (x / 2);
            uint8_t* rgb_ptr_top = rgb_data + (y * width + x) * 3;
            uint8_t* rgb_ptr_bottom = rgb_data + ((y + 1) * width + x) * 3;

            // Load Y, U, V
            uint8x8_t y_top_u8 = vld1_u8(y_ptr_top);
            uint8x8_t y_bottom_u8 = vld1_u8(y_ptr_bottom);
            uint8x8_t u_u8_half = vreinterpret_u8_u32(vld1_dup_u32((uint32_t*)u_ptr)); // Loads 4 bytes {u0,u1,u2,u3}
            uint8x8_t v_u8_half = vreinterpret_u8_u32(vld1_dup_u32((uint32_t*)v_ptr)); // Loads 4 bytes {v0,v1,v2,v3}

            // Upsample U and V from 4 values to 8 values for the 8 pixels. {u0,u0,u1,u1,u2,u2,u3,u3}
            uint8x8x2_t u_u8_zip = vzip_u8(u_u8_half, u_u8_half);
            uint8x8x2_t v_u8_zip = vzip_u8(v_u8_half, v_u8_half);
            uint8x8_t u_u8 = u_u8_zip.val[0];
            uint8x8_t v_u8 = v_u8_zip.val[0];
            
            // Convert to signed 16-bit
            int16x8_t y_top_s16 = vreinterpretq_s16_u16(vmovl_u8(y_top_u8));
            int16x8_t y_bottom_s16 = vreinterpretq_s16_u16(vmovl_u8(y_bottom_u8));
            int16x8_t u_s16 = vreinterpretq_s16_u16(vmovl_u8(u_u8));
            int16x8_t v_s16 = vreinterpretq_s16_u16(vmovl_u8(v_u8));

            // Subtract offsets
            int16x8_t c_top_s16 = vsubq_s16(y_top_s16, const_16);
            int16x8_t c_bottom_s16 = vsubq_s16(y_bottom_s16, const_16);
            int16x8_t d_s16 = vsubq_s16(u_s16, const_128);
            int16x8_t e_s16 = vsubq_s16(v_s16, const_128);

            // Calculate R, G, B components
            // Split into low and high parts to handle widening multiplication
            int16x4_t c_top_lo = vget_low_s16(c_top_s16);
            int16x4_t c_top_hi = vget_high_s16(c_top_s16);
            int16x4_t c_bottom_lo = vget_low_s16(c_bottom_s16);
            int16x4_t c_bottom_hi = vget_high_s16(c_bottom_s16);
            int16x4_t d_lo = vget_low_s16(d_s16);
            int16x4_t d_hi = vget_high_s16(d_s16);
            int16x4_t e_lo = vget_low_s16(e_s16);
            int16x4_t e_hi = vget_high_s16(e_s16);

            // Top row
            int32x4_t r_top_lo_tmp = vaddq_s32(vmull_n_s16(c_top_lo, 298), vmull_n_s16(e_lo, 409));
            int32x4_t r_top_hi_tmp = vaddq_s32(vmull_n_s16(c_top_hi, 298), vmull_n_s16(e_hi, 409));
            int32x4_t g_top_lo_tmp = vsubq_s32(vsubq_s32(vmull_n_s16(c_top_lo, 298), vmull_n_s16(d_lo, 100)), vmull_n_s16(e_lo, 208));
            int32x4_t g_top_hi_tmp = vsubq_s32(vsubq_s32(vmull_n_s16(c_top_hi, 298), vmull_n_s16(d_hi, 100)), vmull_n_s16(e_hi, 208));
            int32x4_t b_top_lo_tmp = vaddq_s32(vmull_n_s16(c_top_lo, 298), vmull_n_s16(d_lo, 516));
            int32x4_t b_top_hi_tmp = vaddq_s32(vmull_n_s16(c_top_hi, 298), vmull_n_s16(d_hi, 516));

            int16x8_t r_top = vcombine_s16(vrshrn_n_s32(r_top_lo_tmp, 8), vrshrn_n_s32(r_top_hi_tmp, 8));
            int16x8_t g_top = vcombine_s16(vrshrn_n_s32(g_top_lo_tmp, 8), vrshrn_n_s32(g_top_hi_tmp, 8));
            int16x8_t b_top = vcombine_s16(vrshrn_n_s32(b_top_lo_tmp, 8), vrshrn_n_s32(b_top_hi_tmp, 8));
            
            // Bottom row
            int32x4_t r_bottom_lo_tmp = vaddq_s32(vmull_n_s16(c_bottom_lo, 298), vmull_n_s16(e_lo, 409));
            int32x4_t r_bottom_hi_tmp = vaddq_s32(vmull_n_s16(c_bottom_hi, 298), vmull_n_s16(e_hi, 409));
            int32x4_t g_bottom_lo_tmp = vsubq_s32(vsubq_s32(vmull_n_s16(c_bottom_lo, 298), vmull_n_s16(d_lo, 100)), vmull_n_s16(e_lo, 208));
            int32x4_t g_bottom_hi_tmp = vsubq_s32(vsubq_s32(vmull_n_s16(c_bottom_hi, 298), vmull_n_s16(d_hi, 100)), vmull_n_s16(e_hi, 208));
            int32x4_t b_bottom_lo_tmp = vaddq_s32(vmull_n_s16(c_bottom_lo, 298), vmull_n_s16(d_lo, 516));
            int32x4_t b_bottom_hi_tmp = vaddq_s32(vmull_n_s16(c_bottom_hi, 298), vmull_n_s16(d_hi, 516));

            int16x8_t r_bottom = vcombine_s16(vrshrn_n_s32(r_bottom_lo_tmp, 8), vrshrn_n_s32(r_bottom_hi_tmp, 8));
            int16x8_t g_bottom = vcombine_s16(vrshrn_n_s32(g_bottom_lo_tmp, 8), vrshrn_n_s32(g_bottom_hi_tmp, 8));
            int16x8_t b_bottom = vcombine_s16(vrshrn_n_s32(b_bottom_lo_tmp, 8), vrshrn_n_s32(b_bottom_hi_tmp, 8));

            // Store results
            uint8x8x3_t rgb_top, rgb_bottom;
            rgb_top.val[0] = vqmovun_s16(r_top);
            rgb_top.val[1] = vqmovun_s16(g_top);
            rgb_top.val[2] = vqmovun_s16(b_top);

            rgb_bottom.val[0] = vqmovun_s16(r_bottom);
            rgb_bottom.val[1] = vqmovun_s16(g_bottom);
            rgb_bottom.val[2] = vqmovun_s16(b_bottom);

            vst3_u8(rgb_ptr_top, rgb_top);
            vst3_u8(rgb_ptr_bottom, rgb_bottom);
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

#else
    static int c_log_printed = 0;
    if (!c_log_printed) {
        printf("DEBUG: Using C fallback path for convert_yuv_to_rgb_planar.\n");
        c_log_printed = 1;
    }
    // Fallback to original C implementation on non-NEON platforms
    if (!y_plane || !u_plane || !v_plane) {
        return NULL;
    }

    int rgb_size = width * height * 3;
    uint8_t* rgb_data = (uint8_t*)malloc(rgb_size * sizeof(uint8_t));
    if (!rgb_data) {
        return NULL;
    }
    
    for (int y_coord = 0; y_coord < height; y_coord++) {
        for (int x_coord = 0; x_coord < width; x_coord++) {
            int y_index = y_coord * y_stride + x_coord;
            int uv_index = (y_coord / 2) * uv_stride + (x_coord / 2);

            uint8_t y = y_plane[y_index];
            uint8_t u = u_plane[uv_index];
            uint8_t v = v_plane[uv_index];

            int rgb_index = (y_coord * width + x_coord) * 3;
            yuv_to_rgb(y, u, v, &rgb_data[rgb_index], &rgb_data[rgb_index + 1], &rgb_data[rgb_index + 2]);
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
    int height
) {
#if defined(__ARM_NEON) || defined(__ARM_NEON__)
    static int neon_log_printed = 0;
    if (!neon_log_printed) {
        printf("DEBUG: Using NEON optimized path for convert_yuv_to_rgb_biplanar.\n");
        neon_log_printed = 1;
    }
    // NEON-optimized implementation for NV12/NV21
    if (!y_plane || !uv_plane) {
        return NULL;
    }

    int rgb_size = width * height * 3;
    uint8_t* rgb_data = (uint8_t*)malloc(rgb_size * sizeof(uint8_t));
    if (!rgb_data) {
        return NULL;
    }
    
    const int16x8_t const_16 = vdupq_n_s16(16);
    const int16x8_t const_128 = vdupq_n_s16(128);

    for (int y = 0; y < height; y += 2) {
        for (int x = 0; x < width; x += 8) {
            uint8_t* y_ptr_top = y_plane + y * y_stride + x;
            uint8_t* y_ptr_bottom = y_plane + (y + 1) * y_stride + x;
            uint8_t* uv_ptr = uv_plane + (y / 2) * uv_stride + x;
            uint8_t* rgb_ptr_top = rgb_data + (y * width + x) * 3;
            uint8_t* rgb_ptr_bottom = rgb_data + ((y + 1) * width + x) * 3;

            // Load Y and de-interleaved UV
            uint8x8_t y_top_u8 = vld1_u8(y_ptr_top);
            uint8x8_t y_bottom_u8 = vld1_u8(y_ptr_bottom);
            uint8x8x2_t uv_u8 = vld2_u8(uv_ptr); // Loads {U0,V0,U1,V1...} into two vectors {U0,U1...} and {V0,V1...}
            uint8x8_t u_u8 = uv_u8.val[0];
            uint8x8_t v_u8 = uv_u8.val[1];
            
            // Convert to signed 16-bit
            int16x8_t y_top_s16 = vreinterpretq_s16_u16(vmovl_u8(y_top_u8));
            int16x8_t y_bottom_s16 = vreinterpretq_s16_u16(vmovl_u8(y_bottom_u8));
            int16x8_t u_s16 = vreinterpretq_s16_u16(vmovl_u8(u_u8));
            int16x8_t v_s16 = vreinterpretq_s16_u16(vmovl_u8(v_u8));

            // Subtract offsets
            int16x8_t c_top_s16 = vsubq_s16(y_top_s16, const_16);
            int16x8_t c_bottom_s16 = vsubq_s16(y_bottom_s16, const_16);
            int16x8_t d_s16 = vsubq_s16(u_s16, const_128);
            int16x8_t e_s16 = vsubq_s16(v_s16, const_128);

            // Calculate R, G, B components for top row
            // Using 4 lanes at a time for 32-bit intermediate results
            int32x4_t c_top_lo = vmull_n_s16(vget_low_s16(c_top_s16), 298);
            int32x4_t c_top_hi = vmull_n_s16(vget_high_s16(c_top_s16), 298);
            int32x4_t d_lo = vmull_n_s16(vget_low_s16(d_s16), 100);
            int32x4_t d_hi = vmull_n_s16(vget_high_s16(d_s16), 100);
            int32x4_t d_b_lo = vmull_n_s16(vget_low_s16(d_s16), 516);
            int32x4_t d_b_hi = vmull_n_s16(vget_high_s16(d_s16), 516);
            int32x4_t e_r_lo = vmull_n_s16(vget_low_s16(e_s16), 409);
            int32x4_t e_r_hi = vmull_n_s16(vget_high_s16(e_s16), 409);
            int32x4_t e_g_lo = vmull_n_s16(vget_low_s16(e_s16), 208);
            int32x4_t e_g_hi = vmull_n_s16(vget_high_s16(e_s16), 208);
            
            int16x8_t r_top = vcombine_s16(vrshrn_n_s32(vaddq_s32(c_top_lo, e_r_lo), 8), vrshrn_n_s32(vaddq_s32(c_top_hi, e_r_hi), 8));
            int16x8_t g_top = vcombine_s16(vrshrn_n_s32(vsubq_s32(vsubq_s32(c_top_lo, d_lo), e_g_lo), 8), vrshrn_n_s32(vsubq_s32(vsubq_s32(c_top_hi, d_hi), e_g_hi), 8));
            int16x8_t b_top = vcombine_s16(vrshrn_n_s32(vaddq_s32(c_top_lo, d_b_lo), 8), vrshrn_n_s32(vaddq_s32(c_top_hi, d_b_hi), 8));

            // Calculate R, G, B components for bottom row
            int32x4_t c_bottom_lo = vmull_n_s16(vget_low_s16(c_bottom_s16), 298);
            int32x4_t c_bottom_hi = vmull_n_s16(vget_high_s16(c_bottom_s16), 298);

            int16x8_t r_bottom = vcombine_s16(vrshrn_n_s32(vaddq_s32(c_bottom_lo, e_r_lo), 8), vrshrn_n_s32(vaddq_s32(c_bottom_hi, e_r_hi), 8));
            int16x8_t g_bottom = vcombine_s16(vrshrn_n_s32(vsubq_s32(vsubq_s32(c_bottom_lo, d_lo), e_g_lo), 8), vrshrn_n_s32(vsubq_s32(vsubq_s32(c_bottom_hi, d_hi), e_g_hi), 8));
            int16x8_t b_bottom = vcombine_s16(vrshrn_n_s32(vaddq_s32(c_bottom_lo, d_b_lo), 8), vrshrn_n_s32(vaddq_s32(c_bottom_hi, d_b_hi), 8));
            
            // Store results
            uint8x8x3_t rgb_top, rgb_bottom;
            rgb_top.val[0] = vqmovun_s16(r_top);
            rgb_top.val[1] = vqmovun_s16(g_top);
            rgb_top.val[2] = vqmovun_s16(b_top);

            rgb_bottom.val[0] = vqmovun_s16(r_bottom);
            rgb_bottom.val[1] = vqmovun_s16(g_bottom);
            rgb_bottom.val[2] = vqmovun_s16(b_bottom);
            
            vst3_u8(rgb_ptr_top, rgb_top);
            vst3_u8(rgb_ptr_bottom, rgb_bottom);
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

#else
    static int c_log_printed = 0;
    if (!c_log_printed) {
        printf("DEBUG: Using C fallback path for convert_yuv_to_rgb_biplanar.\n");
        c_log_printed = 1;
    }
    // Fallback to original C implementation on non-NEON platforms
    if (!y_plane || !uv_plane) {
        return NULL;
    }

    int rgb_size = width * height * 3;
    uint8_t* rgb_data = (uint8_t*)malloc(rgb_size * sizeof(uint8_t));
    if (!rgb_data) {
        return NULL;
    }
    
    for (int y_coord = 0; y_coord < height; y_coord++) {
        for (int x_coord = 0; x_coord < width; x_coord++) {
            int y_index = y_coord * y_stride + x_coord;
            int uv_index = (y_coord / 2) * uv_stride + (x_coord / 2) * uv_pixel_stride;
            
            uint8_t y = y_plane[y_index];
            uint8_t u = uv_plane[uv_index];
            uint8_t v = uv_plane[uv_index + 1];

            int rgb_index = (y_coord * width + x_coord) * 3;
            yuv_to_rgb(y, u, v, &rgb_data[rgb_index], &rgb_data[rgb_index + 1], &rgb_data[rgb_index + 2]);
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
        }
        free(image);
    }
}

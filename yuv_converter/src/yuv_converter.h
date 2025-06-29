#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#if _WIN32
#include <windows.h>
#else
#include <pthread.h>
#include <unistd.h>
#endif

#if _WIN32
#define FFI_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT
#endif

// Represents an RGB image buffer
typedef struct {
    uint8_t* data;
    int width;
    int height;
} RgbImage;

// For 3-plane YUV (I420 format)
FFI_PLUGIN_EXPORT RgbImage* convert_yuv_to_rgb_planar(
    uint8_t* y_plane,
    uint8_t* u_plane,
    uint8_t* v_plane,
    int y_stride,
    int uv_stride,
    int width,
    int height
);

// For 2-plane YUV (NV12 format)
FFI_PLUGIN_EXPORT RgbImage* convert_yuv_to_rgb_biplanar(
    uint8_t* y_plane,
    uint8_t* uv_plane,
    int y_stride,
    int uv_stride,
    int uv_pixel_stride,
    int width,
    int height
);

FFI_PLUGIN_EXPORT void free_image_memory(RgbImage* image);

#ifndef YUV_CONVERTER_H
#define YUV_CONVERTER_H

#include <stdint.h>

#if defined(_WIN32)
#define FFI_EXPORT __declspec(dllexport)
#else
#define FFI_EXPORT __attribute__((visibility("default"))) __attribute__((used))
#endif

extern "C"
{
    FFI_EXPORT uint32_t *convert_yuv_to_rgb(
        uint8_t *y_plane,
        uint8_t *u_plane,
        uint8_t *v_plane,
        int y_stride,
        int uv_stride,
        int uv_pixel_stride,
        int width,
        int height);

    FFI_EXPORT void free_image_memory(uint32_t *image_buffer);
}

#endif // YUV_CONVERTER_H

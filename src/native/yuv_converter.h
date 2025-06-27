#ifndef YUV_CONVERTER_H
#define YUV_CONVERTER_H

#include <stdint.h>

#if defined(__cplusplus)
extern "C" {
#endif

// Define visibility attribute for C symbols to ensure they are exported
#if defined(_WIN32)
    #ifdef YUV_CONVERTER_EXPORTS
        #define YUV_CONVERTER_API __declspec(dllexport)
    #else
        #define YUV_CONVERTER_API __declspec(dllimport)
    #endif
#else
    #define YUV_CONVERTER_API __attribute__((visibility("default")))
#endif


YUV_CONVERTER_API uint8_t* convert_yuv_to_rgb(
    uint8_t* y_plane,
    uint8_t* u_plane,
    uint8_t* v_plane,
    int width,
    int height,
    int y_stride,
    int uv_stride,
    int uv_pixel_stride
);

YUV_CONVERTER_API void free_image_memory(uint8_t* image_data);


#if defined(__cplusplus)
}
#endif

#endif // YUV_CONVERTER_H

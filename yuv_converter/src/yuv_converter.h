#ifndef YUV_CONVERTER_H
#define YUV_CONVERTER_H

#include <stdint.h>

#if defined(_WIN32)
    #define FFI_PLUGIN_EXPORT __declspec(dllexport)
#else
    #define FFI_PLUGIN_EXPORT
#endif

/**
 * @brief Represents an RGB image buffer with its dimensions.
 */
typedef struct {
    uint8_t* data;
    int width;
    int height;
} RgbImage;

/**
 * @brief Enum to specify the bi-planar YUV format (NV12 or NV21).
 */
typedef enum {
    NV12, // Chroma plane is UVUV...
    NV21  // Chroma plane is VUVU...
} BiplanarFormat;

/**
 * @brief Converts a 3-plane YUV (I420/YUV420p) image to RGB.
 * @param y_plane Pointer to the start of the Y plane.
 * @param u_plane Pointer to the start of the U plane.
 * @param v_plane Pointer to the start of the V plane.
 * @param y_stride Stride (bytes per row) of the Y plane.
 * @param u_stride Stride of the U plane.
 * @param v_stride Stride of the V plane.
 * @param width Image width in pixels.
 * @param height Image height in pixels.
 * @return A pointer to an RgbImage struct containing the converted data, or NULL on failure.
 * The caller is responsible for freeing the memory using free_image_memory().
 */
FFI_PLUGIN_EXPORT RgbImage* convert_yuv_to_rgb_planar(
    uint8_t* y_plane,
    uint8_t* u_plane,
    uint8_t* v_plane,
    int y_stride,
    int u_stride,
    int v_stride,
    int width,
    int height
);

/**
 * @brief Converts a 2-plane YUV (NV12/NV21) image to RGB.
 * @param y_plane Pointer to the start of the Y plane.
 * @param uv_plane Pointer to the start of the interleaved UV plane.
 * @param y_stride Stride (bytes per row) of the Y plane.
 * @param uv_stride Stride of the UV plane.
 * @param uv_pixel_stride Pixel stride of the UV plane (usually 2 for NV12/NV21).
 * @param width Image width in pixels.
 * @param height Image height in pixels.
 * @param format The specific bi-planar format (NV12 or NV21).
 * @return A pointer to an RgbImage struct containing the converted data, or NULL on failure.
 * The caller is responsible for freeing the memory using free_image_memory().
 */
FFI_PLUGIN_EXPORT RgbImage* convert_yuv_to_rgb_biplanar(
    uint8_t* y_plane,
    uint8_t* uv_plane,
    int y_stride,
    int uv_stride,
    int uv_pixel_stride,
    int width,
    int height,
    BiplanarFormat format
);

/**
 * @brief Frees the memory allocated for an RgbImage struct and its data.
 * @param image A pointer to the RgbImage to be freed.
 */
FFI_PLUGIN_EXPORT void free_image_memory(RgbImage* image);

#endif // YUV_CONVERTER_H
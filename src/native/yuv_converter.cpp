#include "yuv_converter.h"
#include <cstdlib>

// Helper function to clamp values between 0 and 255
inline int clamp(int value)
{
    if (value < 0)
        return 0;
    if (value > 255)
        return 255;
    return value;
}

// Convert a single YUV pixel to a 32-bit ARGB value.
inline uint32_t yuv_to_rgb_pixel(int y, int u, int v)
{
    int r = static_cast<int>(y + 1.402 * (v - 128));
    int g = static_cast<int>(y - 0.344136 * (u - 128) - 0.714136 * (v - 128));
    int b = static_cast<int>(y + 1.772 * (u - 128));

    // Combine into a 32-bit ARGB format (alpha is set to 255)
    return (255 << 24) | (clamp(r) << 16) | (clamp(g) << 8) | clamp(b);
}

FFI_EXPORT uint32_t *convert_yuv_to_rgb(
    uint8_t *y_plane,
    uint8_t *u_plane,
    uint8_t *v_plane,
    int y_stride,
    int uv_stride,
    int uv_pixel_stride,
    int width,
    int height)
{
    // Allocate memory for the output RGB buffer.
    // The format will be ARGB, 4 bytes per pixel.
    uint32_t *rgb_buffer = (uint32_t *)malloc(width * height * sizeof(uint32_t));
    if (rgb_buffer == nullptr)
    {
        return nullptr;
    }

    for (int y = 0; y < height; ++y)
    {
        for (int x = 0; x < width; ++x)
        {
            int y_index = y * y_stride + x;
            int uv_index_offset = (y / 2) * uv_stride + (x / 2) * uv_pixel_stride;

            int y_val = y_plane[y_index];
            int u_val = u_plane[uv_index_offset];
            // For NV12 format (2 planes), V is immediately after U in the same plane.
            // For I420 format (3 planes), V is in a separate plane.
            int v_val = (v_plane == nullptr) ? u_plane[uv_index_offset + 1] : v_plane[uv_index_offset];

            rgb_buffer[y * width + x] = yuv_to_rgb_pixel(y_val, u_val, v_val);
        }
    }

    return rgb_buffer;
}

FFI_EXPORT void free_image_memory(uint32_t *image_buffer)
{
    if (image_buffer != nullptr)
    {
        free(image_buffer);
    }
}

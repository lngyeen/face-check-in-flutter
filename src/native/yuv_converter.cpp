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

    const uint8_t* y_row = y_plane;
    const uint8_t* u_row = u_plane;
    const uint8_t* v_row = v_plane;

    for (int y_coord = 0; y_coord < height; ++y_coord)
    {
        uint32_t* rgb_pixel = rgb_buffer + y_coord * width;
        for (int x_coord = 0; x_coord < width; ++x_coord)
        {
            const int uv_x = x_coord / 2;
            const int y_index = x_coord;
            const int u_index = uv_x * uv_pixel_stride;
            const int v_index = uv_x * uv_pixel_stride;

            const int y_val = y_row[y_index];
            const int u_val = u_row[u_index];
            const int v_val = v_row[v_index];

            *rgb_pixel++ = yuv_to_rgb_pixel(y_val, u_val, v_val);
        }

        y_row += y_stride;
        if (y_coord % 2 == 1)
        {
            u_row += uv_stride;
            v_row += uv_stride;
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

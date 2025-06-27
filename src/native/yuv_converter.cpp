#include "yuv_converter.h"
#include <cstdlib>
#include <new>
#include <stdexcept>

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

YUV_CONVERTER_API uint8_t* convert_yuv_to_rgb_planar(
    uint8_t* y_plane,
    uint8_t* u_plane,
    uint8_t* v_plane,
    int y_stride,
    int uv_stride,
    int width,
    int height
)
{
    uint32_t* rgb_buffer = new (std::nothrow) uint32_t[width * height];
    if (rgb_buffer == nullptr) {
        return nullptr;
    }

    for (int y_coord = 0; y_coord < height; ++y_coord) {
        const int uv_y = y_coord / 2;
        const uint8_t* y_row = y_plane + y_coord * y_stride;
        const uint8_t* u_row = u_plane + uv_y * uv_stride;
        const uint8_t* v_row = v_plane + uv_y * uv_stride;
        
        uint32_t* rgb_pixel = rgb_buffer + y_coord * width;

        for (int x_coord = 0; x_coord < width; ++x_coord) {
            const int uv_x = x_coord / 2;
            const int y_val = y_row[x_coord];
            const int u_val = u_row[uv_x];
            const int v_val = v_row[uv_x];

            *rgb_pixel++ = yuv_to_rgb_pixel(y_val, u_val, v_val);
        }
    }

    return reinterpret_cast<uint8_t*>(rgb_buffer);
}

YUV_CONVERTER_API uint8_t* convert_yuv_to_rgb_biplanar(
    uint8_t* y_plane,
    uint8_t* uv_plane,
    int y_stride,
    int uv_stride,
    int uv_pixel_stride,
    int width,
    int height
)
{
    uint32_t* rgb_buffer = new (std::nothrow) uint32_t[width * height];
    if (rgb_buffer == nullptr) {
        return nullptr;
    }

    for (int y_coord = 0; y_coord < height; ++y_coord) {
        const int uv_y = y_coord / 2;
        const uint8_t* y_row = y_plane + y_coord * y_stride;
        const uint8_t* uv_row = uv_plane + uv_y * uv_stride;
        
        uint32_t* rgb_pixel = rgb_buffer + y_coord * width;

        for (int x_coord = 0; x_coord < width; ++x_coord) {
            const int uv_x = x_coord / 2;
            const int uv_index = uv_x * uv_pixel_stride;

            const int y_val = y_row[x_coord];
            const int u_val = uv_row[uv_index];
            const int v_val = uv_row[uv_index + 1];

            *rgb_pixel++ = yuv_to_rgb_pixel(y_val, u_val, v_val);
        }
    }

    return reinterpret_cast<uint8_t*>(rgb_buffer);
}

YUV_CONVERTER_API void free_image_memory(uint8_t* image_data) {
    if (image_data != nullptr) {
        delete[] reinterpret_cast<uint32_t*>(image_data);
    }
}

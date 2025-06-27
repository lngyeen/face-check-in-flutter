#include "yuv_converter.h"
#include <cstdlib>
#include <new>       // Required for std::nothrow
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

YUV_CONVERTER_API uint8_t* convert_yuv_to_rgb(
    uint8_t* y_plane,
    uint8_t* u_plane,
    uint8_t* v_plane,
    int width,
    int height,
    int y_stride,
    int uv_stride,
    int uv_pixel_stride
)
{
    // Allocate memory for the output RGB buffer.
    // The format will be ARGB, 4 bytes per pixel.
    uint32_t* rgb_buffer = new (std::nothrow) uint32_t[width * height];
    if (rgb_buffer == nullptr) {
        return nullptr;
    }

    for (int y_coord = 0; y_coord < height; ++y_coord) {
        for (int x_coord = 0; x_coord < width; ++x_coord) {
            int y_index = y_coord * y_stride + x_coord;
            int uv_index_offset = (y_coord / 2) * uv_stride + (x_coord / 2) * uv_pixel_stride;

            int y_val = y_plane[y_index];
            int u_val = u_plane[uv_index_offset];
            int v_val = v_plane[uv_index_offset];

            rgb_buffer[y_coord * width + x_coord] = yuv_to_rgb_pixel(y_val, u_val, v_val);
        }
    }

    return reinterpret_cast<uint8_t*>(rgb_buffer);
}

YUV_CONVERTER_API void free_image_memory(uint8_t* image_data) {
    if (image_data != nullptr) {
        delete[] reinterpret_cast<uint32_t*>(image_data);
    }
}

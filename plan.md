# **Plan: Optimize YUV to RGB Conversion with C++ FFI**

## **Objective**

Replace the current Dart-based YUV-to-RGB conversion logic in `image_converter.dart` with a high-performance C++ implementation using Dart's FFI (Foreign Function Interface) to improve performance and reduce CPU usage.

## **Execution Status**

-   [x] **Step 1: Create Project Structure for Native Code**
-   [x] **Step 2: Implement C++ YUV-to-RGB Converter**
-   [x] **Step 3: Configure Android Build (CMake)**
-   [x] **Step 4: Configure iOS Build**
-   [x] **Step 5: Create Dart FFI Bridge**
-   [x] **Step 6: Integrate FFI Bridge into `ImageConverter`**
-   [x] **Step 7: Clean Up and Final Review**

---

## **Step 1: Create Project Structure for Native Code**

*   **Goal:** Set up the necessary directories and empty files for the native C++ code.
*   **Actions:**
    *   [x] Create directory: `src/native/` at the project root.
    *   [x] Create file: `src/native/CMakeLists.txt`
    *   [x] Create file: `src/native/yuv_converter.h`
    *   [x] Create file: `src/native/yuv_converter.cpp`
*   **Verification:** The specified directory and files exist at the correct paths.

## **Step 2: Implement C++ YUV-to-RGB Converter**

*   **Goal:** Write the C++ functions for converting YUV image data to RGB format and for memory management.
*   **Actions:**
    *   [x] Define the function signatures in `src/native/yuv_converter.h`. This will include `convert_yuv_to_rgb` and `free_image_memory`.
    *   [x] Implement the logic for these functions in `src/native/yuv_converter.cpp`. The conversion logic will handle both 3-plane (I420) and 2-plane (NV12) YUV formats.
*   **Verification:** The C++ code compiles without errors (will be fully verified in the next steps) and the logic correctly implements the YUV to RGB conversion formulas.

## **Step 3: Configure Android Build (CMake)**

*   **Goal:** Integrate the C++ code into the Android build process.
*   **Actions:**
    *   [x] Populate `src/native/CMakeLists.txt` to define the native library (`yuv_converter`) and link the source files.
    *   [x] Modify `android/app/build.gradle.kts` to point `externalNativeBuild` to the new `CMakeLists.txt` file.
*   **Verification:** The Android project builds successfully without errors related to the native code.

## **Step 4: Configure iOS Build**

*   **Goal:** Integrate the C++ code into the iOS build process.
*   **Actions:**
    *   [x] Create a `YUVConverter.podspec` file in the `ios` directory to define a local pod for the native code.
    *   [x] Update `ios/Podfile` to include the local `YUVConverter` pod.
*   **Verification:** The iOS project builds successfully on a simulator or device without linkage errors.

## **Step 5: Create Dart FFI Bridge**

*   **Goal:** Write the Dart code that loads and communicates with the native C++ library.
*   **Actions:**
    *   [x] Create a new directory: `lib/core/services/ffi/`.
    *   [x] Create a new file: `lib/core/services/ffi/yuv_converter_ffi.dart`.
    *   [x] In this file, implement a class (`YuvConverterFfi`) that:
        *   [x] Loads the dynamic library (`libyuv_converter.so` on Android, or uses `DynamicLibrary.process()` for iOS).
        *   [x] Defines `typedef`s for the C function signatures.
        *   [x] Looks up the C functions (`convert_yuv_to_rgb`, `free_image_memory`).
        *   [x] Provides high-level Dart methods that handle memory allocation (`package:ffi`), data marshalling, calling the C functions, and freeing memory.
*   **Verification:** The Dart FFI bridge class can be instantiated, and it successfully looks up the native functions without throwing exceptions.

## **Step 6: Integrate FFI Bridge into `ImageConverter`**

*   **Goal:** Replace the old Dart conversion logic with calls to the new FFI bridge.
*   **Actions:**
    *   [x] In `lib/core/services/image_converter.dart`, import the new FFI bridge.
    *   [x] Instantiate the `YuvConverterFfi` class.
    *   [x] In the `convertYUV420` method, replace the calls to `_convertFrom2Planes` and `_convertFrom3Planes` with a call to the appropriate method in the FFI bridge.
    *   [x] Ensure the returned data from the FFI call is correctly processed into an `img.Image` object.
*   **Verification:** The application runs, the camera stream is processed, and the image conversion happens correctly via the FFI bridge without crashes or visual artifacts.

## **Step 7: Clean Up and Final Review**

*   **Goal:** Remove obsolete code and ensure the new implementation is clean.
*   **Actions:**
    *   [x] Remove the old private methods (`_convertFrom3Planes`, `_convertFrom2Planes`, `_yuvToRgb`) from `image_converter.dart`.
    *   [x] Review all new code for clarity, comments, and adherence to project standards.
    *   [x] Ensure all temporary files or test code have been removed.
*   **Verification:** The final code is clean, well-documented, and the old, unused conversion methods are gone. 
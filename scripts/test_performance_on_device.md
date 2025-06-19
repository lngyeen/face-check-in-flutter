# Frame Capture Performance Testing on Real Devices

## Prerequisites

### Hardware Requirements
- **iOS Device**: iPhone 11 or newer (A12 chip minimum)
- **Android Device**: Device with API level 21+ and decent CPU (Snapdragon 660+ or equivalent)
- **USB Cable**: For device connection
- **Development Machine**: macOS/Windows/Linux with Flutter SDK

### Software Setup
1. Enable Developer Options on Android / Trust computer on iOS
2. Ensure Flutter debug build is installed
3. Enable USB debugging
4. Connect device via USB (not wireless for accurate performance measurement)

## Performance Testing Procedure

### Step 1: Build and Deploy Debug Version
```bash
# For Android
flutter run --debug --target-platform android

# For iOS  
flutter run --debug --target-platform ios
```

### Step 2: Access Performance Monitor
1. Launch the app on your device
2. Navigate to the Check-In screen
3. The Performance Debug Widget should appear at the bottom (debug builds only)
4. If not visible, look for a performance indicator overlay

### Step 3: Start Frame Capture Testing
1. Tap "Start" in the Performance Monitor widget
2. Begin camera frame capture
3. Monitor real-time metrics:
   - **FPS**: Should show 25-30 FPS (green = good, orange/red = poor)
   - **Processing Time**: Should be ≤50ms (ideally ≤33ms for 30 FPS)
   - **Success Rate**: Should be ≥90%
   - **Memory Usage**: Monitor for memory leaks

### Step 4: Run Comprehensive Performance Test
1. Tap "Test" button in Performance Monitor
2. Wait for the 2-minute automated test to complete
3. Review the detailed performance report
4. Copy the report for analysis

### Step 5: Device-Specific Testing

#### Test Scenarios
1. **Normal Conditions**: Good lighting, stable device position
2. **Low Light**: Test frame processing under poor lighting
3. **Movement**: Test while moving device/changing angles
4. **Background Apps**: Test with other apps running
5. **Thermal Stress**: Test after device has been running for 15+ minutes

#### Expected Performance Targets
- **Target FPS**: 30 FPS
- **Minimum Acceptable FPS**: 25 FPS
- **Target Processing Time**: ≤33ms per frame
- **Maximum Acceptable Processing Time**: ≤50ms per frame
- **Success Rate**: ≥95% (excellent), ≥90% (acceptable)
- **Memory Usage**: Stable, no significant leaks

## Real Device Testing Checklist

### Android Devices
- [ ] Test on mid-range device (Snapdragon 660 equivalent)
- [ ] Test on high-end device (Snapdragon 855+ equivalent)
- [ ] Verify different camera formats (YUV420, NV21)
- [ ] Test in both portrait and landscape orientations
- [ ] Monitor CPU usage via Android Studio Profiler
- [ ] Check thermal throttling behavior

### iOS Devices
- [ ] Test on iPhone 11/12/13 series
- [ ] Verify BGRA8888 format handling
- [ ] Test with different camera resolutions
- [ ] Monitor performance via Xcode Instruments
- [ ] Check Metal performance shaders impact

### Performance Validation Commands

#### Monitor Real-Time Performance (via ADB for Android)
```bash
# CPU usage
adb shell dumpsys cpuinfo | grep your.package.name

# Memory usage
adb shell dumpsys meminfo your.package.name

# GPU usage (if available)
adb shell dumpsys gfxinfo your.package.name
```

#### iOS Performance Monitoring
```bash
# Use Xcode Instruments for detailed profiling
# Or check device logs via Console.app
```

## Troubleshooting Common Issues

### Low FPS (< 25 FPS)
**Possible Causes:**
- Image processing too complex for device CPU
- Memory pressure causing garbage collection pauses
- Thermal throttling on older devices

**Solutions:**
- Reduce target frame resolution in FrameProcessor
- Implement adaptive quality scaling
- Add frame skipping under high load

### High Processing Time (> 50ms)
**Possible Causes:**
- Inefficient YUV to RGB conversion
- UI thread blocking
- Synchronous operations in async context

**Solutions:**
- Profile conversion algorithms
- Move processing to isolate if needed
- Optimize memory allocations

### Memory Leaks
**Possible Causes:**
- Stream subscriptions not cancelled
- Image objects not disposed
- Timer references held

**Solutions:**
- Review dispose() methods
- Use weak references where appropriate
- Monitor with memory profiler

## Performance Report Analysis

### Excellent Performance (Ready for Production)
- Average FPS: ≥28
- Processing Time: ≤30ms average
- Success Rate: ≥95%
- Memory: Stable, no leaks

### Good Performance (Minor Optimizations Needed)
- Average FPS: 25-27
- Processing Time: 30-40ms average
- Success Rate: 90-95%
- Memory: Mostly stable

### Poor Performance (Major Optimizations Required)
- Average FPS: <25
- Processing Time: >40ms average
- Success Rate: <90%
- Memory: Increasing over time

## Device-Specific Optimization Recommendations

### Lower-End Devices
- Reduce target frame resolution to 480x360
- Implement more aggressive frame dropping
- Lower JPEG quality to 0.6
- Add device capability detection

### High-End Devices  
- Maintain 640x480 or higher resolution
- Target full 30 FPS
- Use maximum quality settings
- Enable advanced processing features

## Documentation Requirements

After testing, document:
1. **Device Models Tested**: List all devices with OS versions
2. **Performance Results**: Summary of key metrics per device
3. **Issues Found**: Any device-specific problems
4. **Optimizations Applied**: Changes made based on results
5. **Production Readiness**: Final recommendation per device class

## Next Steps After Performance Validation

1. **Optimize Based on Results**: Address any performance issues found
2. **Update Device Requirements**: Document minimum device specifications
3. **Implement Adaptive Quality**: Based on device capabilities
4. **Create Device Profiles**: Different settings for different device classes
5. **Performance Regression Testing**: Add automated performance tests 
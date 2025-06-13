# Manual Deployment Guide - MVP Distribution

**Project**: FaceCheckIn Employee  
**Deployment Strategy**: Manual Build & Distribute  
**Target**: MVP Release Process  
**Document Version**: 1.0

## 📋 **Overview**

This guide outlines the manual build and distribution process for the FaceCheckIn Employee MVP. As specified in the architecture document, the MVP uses a "Manual Build & Distribute" approach with Firebase App Distribution for testing.

## 🏗️ **Build Prerequisites**

### **Development Environment Setup**
```bash
# Verify Flutter installation
flutter --version
flutter doctor -v

# Required Flutter version: ^3.22.0
# Required Dart version: ^3.4.0
```

### **Environment Configuration**
```bash
# 1. Ensure backend environment variables are set
export BACKEND_WEBSOCKET_URL="ws://your-backend-url/ws"
export API_VERSION="v1"
export ENVIRONMENT="production"

# 2. Verify certificates and network access
ping your-backend-domain.com
```

### **Code Preparation**
```bash
# 1. Ensure all dependencies are installed
flutter pub get

# 2. Run code generation (if using freezed)
flutter pub run build_runner build --delete-conflicting-outputs

# 3. Run full test suite
flutter test

# 4. Verify linting
flutter analyze
```

## 📱 **Android Build Process**

### **Debug Build (Development Testing)**
```bash
# Build debug APK
flutter build apk --debug

# Output location
# build/app/outputs/flutter-apk/app-debug.apk
```

### **Release Build (MVP Distribution)**
```bash
# Build release APK
flutter build apk --release

# Build App Bundle (recommended for Play Store - post-MVP)
flutter build appbundle --release

# Output locations:
# build/app/outputs/flutter-apk/app-release.apk
# build/app/outputs/bundle/release/app-release.aab
```

### **Android Build Verification**
```bash
# Check APK size
ls -lh build/app/outputs/flutter-apk/app-release.apk

# Install and test on connected device
adb install build/app/outputs/flutter-apk/app-release.apk

# Verify app functionality
# 1. Test camera permissions
# 2. Test WebSocket connection  
# 3. Test basic check-in flow
```

## 🍎 **iOS Build Process**

### **Debug Build (Development Testing)**
```bash
# Build debug iOS app
flutter build ios --debug

# Output: ios/Runner.app (in Xcode derived data)
```

### **Release Build (MVP Distribution)**
```bash
# Build release iOS app
flutter build ios --release

# Create IPA file using Xcode or command line
# Option 1: Using Xcode
# - Open ios/Runner.xcworkspace
# - Product → Archive
# - Distribute App → Ad Hoc/Enterprise

# Option 2: Using command line (requires proper certificates)
flutter build ipa --release
```

### **iOS Build Verification**
```bash
# Install on connected iOS device
flutter install --device-id [DEVICE_ID]

# Verify app functionality
# 1. Test camera permissions
# 2. Test WebSocket connection
# 3. Test basic check-in flow
```

## 🚀 **Distribution Process**

### **Firebase App Distribution Setup**

#### **Initial Setup (One-time)**
```bash
# 1. Install Firebase CLI
npm install -g firebase-tools

# 2. Login to Firebase
firebase login

# 3. Initialize Firebase in project
firebase init

# 4. Configure app distribution
firebase appdistribution:configure
```

#### **Upload Build to Firebase**
```bash
# Android APK Distribution
firebase appdistribution:distribute \
  build/app/outputs/flutter-apk/app-release.apk \
  --app YOUR_ANDROID_APP_ID \
  --groups "testers" \
  --release-notes "MVP Release - Version 1.0.0"

# iOS IPA Distribution  
firebase appdistribution:distribute \
  build/ios/ipa/face_check_in_flutter.ipa \
  --app YOUR_IOS_APP_ID \
  --groups "testers" \
  --release-notes "MVP Release - Version 1.0.0"
```

### **Alternative Distribution Methods**

#### **Direct File Transfer**
```bash
# Create distribution package
mkdir face-checkin-mvp-v1.0.0
cp build/app/outputs/flutter-apk/app-release.apk face-checkin-mvp-v1.0.0/
cp docs/installation-guide.md face-checkin-mvp-v1.0.0/
zip -r face-checkin-mvp-v1.0.0.zip face-checkin-mvp-v1.0.0/
```

#### **Email Distribution**
```markdown
Subject: FaceCheckIn Employee MVP - Ready for Testing

Team,

The FaceCheckIn Employee MVP (v1.0.0) is ready for testing.

**Installation Instructions:**
1. Download the attached APK file
2. Enable "Install from Unknown Sources" on your Android device  
3. Install the APK
4. Grant camera permissions when prompted
5. Test check-in functionality

**Backend Configuration:**
- WebSocket URL: ws://your-backend-url/ws
- Test Environment: Staging

**Known Limitations:**
- Debug view visible in this build
- Limited error handling
- Basic UI styling

Please report any issues to the development team.

Best regards,
Development Team
```

## 📋 **Pre-Distribution Checklist**

### **Build Quality Verification**
- [ ] All tests pass (unit, widget, integration)
- [ ] App builds successfully for both platforms
- [ ] No critical lint errors or warnings
- [ ] Backend connectivity verified
- [ ] Camera functionality tested
- [ ] WebSocket communication working
- [ ] Toast notifications displaying correctly

### **Configuration Verification**
- [ ] Production backend URLs configured
- [ ] Debug flags disabled for release build
- [ ] Proper app signing configured
- [ ] Version numbers updated appropriately
- [ ] Release notes prepared

### **Security Verification**
- [ ] No hardcoded credentials in code
- [ ] Proper certificate validation
- [ ] Network security configuration
- [ ] Permissions properly declared
- [ ] No sensitive data in logs

## 🔄 **Rollback Strategy**

### **Rollback Process**
```bash
# If new version has critical issues:

# 1. Immediately stop distribution
firebase appdistribution:remove \
  --app YOUR_APP_ID \
  --release PROBLEMATIC_RELEASE_ID

# 2. Redistribute last known good version
firebase appdistribution:distribute \
  path/to/previous-working-build.apk \
  --app YOUR_APP_ID \
  --groups "testers" \
  --release-notes "Rollback to stable version"

# 3. Notify team via email/Slack
```

### **Version Management**
```bash
# Tag releases in git for easy rollback
git tag -a v1.0.0 -m "MVP Release v1.0.0"
git push origin v1.0.0

# Keep previous builds for rollback
mkdir -p releases/v1.0.0
cp build/app/outputs/flutter-apk/app-release.apk releases/v1.0.0/
```

## 📊 **Post-Distribution Monitoring**

### **Distribution Metrics**
- **Download Rate**: Track installation completion
- **Crash Reports**: Monitor via Firebase Crashlytics (post-MVP)
- **User Feedback**: Collect via testing team
- **Performance**: Monitor app performance on test devices

### **Issue Tracking Template**
```markdown
**Issue Report Template**

**Build Version**: v1.0.0
**Device**: [Model, OS Version]
**Issue Type**: [Crash/Bug/Performance/UI]
**Reproduction Steps**:
1. Step 1
2. Step 2
3. Step 3

**Expected Behavior**:
[What should happen]

**Actual Behavior**:  
[What actually happened]

**Additional Context**:
[Screenshots, logs, etc.]
```

## 🔮 **Post-MVP CI/CD Planning**

### **Future Automation Goals**
- **Automated Testing**: Full test suite in CI/CD
- **Automated Building**: Triggered builds on merge
- **Automated Distribution**: Automatic distribution to test groups
- **Code Signing**: Automated certificate management
- **Release Management**: Automated version tagging and release notes

### **Recommended Tools for Future**
- **CI/CD**: GitHub Actions, GitLab CI, or Bitrise
- **Code Signing**: Fastlane for iOS, Android signing automation
- **Distribution**: Automated Firebase App Distribution
- **Monitoring**: Firebase Crashlytics, Application Performance Monitoring

## 📞 **Support & Troubleshooting**

### **Common Build Issues**
```bash
# Issue: Flutter version mismatch
flutter clean
flutter pub get
flutter build apk --release

# Issue: Certificate problems
# Check certificate validity and configuration

# Issue: Backend connectivity
# Verify network configuration and backend availability
```

### **Distribution Issues**
```bash
# Issue: Firebase upload fails
firebase login --reauth
firebase projects:list

# Issue: Large file size
# Check for unnecessary assets or debug symbols
flutter build apk --release --shrink
```

---

**This deployment guide provides a systematic approach to manual distribution while planning for future automation. Follow this process for consistent, reliable MVP releases.** 
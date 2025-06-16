# Face Check-In Flutter - Development Guidelines

## 📋 Project Overview

**Project Name**: `face_check_in_flutter`  
**Architecture**: Clean Architecture with BLoC State Management  
**Target Platforms**: Android API 28+, iOS 15+  
**Flutter Version**: ^3.22.0  

## 🏗️ Project Structure

```
lib/
├── app/
│   ├── app.dart                    # Main app widget with BLoC providers
│   └── simple_bloc_observer.dart   # BLoC debugging and logging
├── core/
│   ├── services/
│   │   └── websocket_service.dart  # WebSocket connection service
│   ├── models/                     # Shared data models
│   └── widgets/                    # Common widgets
├── features/
│   └── check_in/
│       ├── bloc/
│       │   ├── check_in_bloc.dart      # Main BLoC implementation
│       │   ├── check_in_event.dart     # Event definitions
│       │   └── check_in_state.dart     # State definitions
│       ├── view/
│       │   └── check_in_screen.dart    # Main check-in screen
│       └── widgets/                    # Feature-specific widgets
└── main.dart                       # App entry point
```

## 🔧 Key Dependencies

### Production Dependencies
- **flutter_bloc**: ^8.1.0 - State management
- **web_socket_channel**: ^2.4.0 - WebSocket communication
- **camera**: ^0.11.0 - Camera integration
- **permission_handler**: ^11.3.0 - Permissions handling
- **freezed_annotation**: ^2.4.0 - Code generation annotations

### Development Dependencies
- **freezed**: ^2.5.0 - Code generation for immutable classes
- **json_serializable**: ^6.8.0 - JSON serialization
- **build_runner**: ^2.4.0 - Code generation runner
- **flutter_lints**: ^5.0.0 - Linting rules

## 🎯 State Management Architecture

### BLoC Pattern Implementation

The app uses BLoC (Business Logic Component) pattern for state management:

#### State Structure (`CheckInState`)
```dart
@freezed
class CheckInState with _$CheckInState {
  const factory CheckInState({
    @Default(CameraStatus.initial) CameraStatus cameraStatus,
    @Default(ConnectionStatus.disconnected) ConnectionStatus connectionStatus,
    @Default(StreamingStatus.idle) StreamingStatus streamingStatus,
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(ToastStatus.none) ToastStatus toastStatus,
    String? toastMessage,
    @Default(false) bool isDebugMode,
    DateTime? lastRecognitionTime,
    @Default(0) int framesProcessed,
  }) = _CheckInState;
}
```

#### Event Structure (`CheckInEvent`)
Events are organized by category:
- **App Lifecycle**: `appStarted`, `appDisposed`
- **Camera Events**: `cameraInitRequested`, `cameraStatusChanged`
- **WebSocket Events**: `connectionRequested`, `connectionStatusChanged`
- **Streaming Events**: `streamingStarted`, `streamingStopped`
- **UI Events**: `errorOccurred`, `toastRequested`
- **Debug Events**: `debugModeToggled`, `statisticsReset`

## 🌐 Backend Integration

### WebSocket Configuration
- **Default URL**: `ws://192.168.1.234:3009`
- **Protocol**: Raw base64 image frames
- **Response Format**: JSON with frameResult type and faces array
- **Retry Logic**: 3 attempts with 3-second delays

### WebSocket Service Features
- Connection testing utilities
- Automatic reconnection with retry logic
- Environment configuration support (dev/staging/production)
- Stream-based status monitoring
- Comprehensive error handling

## 🔨 Development Workflow

### Code Generation
When modifying state or event classes, run:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/websocket_test.dart

# Run with coverage
flutter test --coverage
```

### Linting
```bash
flutter analyze
```

### Building
```bash
# Debug build
flutter build apk --debug

# Release build
flutter build apk --release
```

## 🎨 UI/UX Guidelines

### Theme Configuration
- **Primary Color**: Red (#D32F2F) - Company brand
- **Design System**: Material Design 3
- **Typography**: Default Material typography with custom sizing
- **Dark Mode**: Supported via system settings

### Component Standards
- Use `Card` widgets for grouped content
- Consistent padding: 16px for main content, 8px for internal spacing
- Loading states with `CircularProgressIndicator`
- Toast notifications via `SnackBar`
- Debug information toggleable via debug mode

## 🔍 Debugging & Logging

### BLoC Observer
All BLoC state transitions are logged via `SimpleBlocObserver`:
- 🟢 BLoC Created
- 🔄 BLoC Change (state transitions)
- 🚀 BLoC Transition (with events)
- 📨 BLoC Event
- ❌ BLoC Error
- 🔴 BLoC Closed

### Debug Mode
Toggle debug mode in the app to see:
- Frames processed count
- Last recognition timestamp
- Current loading state
- Error messages
- Statistics reset functionality

## 📱 Integration Points for Future Stories

### Story 1.2: Camera Integration
- BLoC events ready: `cameraInitRequested`, `cameraStatusChanged`
- State management: `cameraStatus` enum (initial, ready, error)
- Placeholder handlers implemented in `CheckInBloc`

### Story 2.1: WebSocket Connection
- Service ready: `WebSocketService` with full functionality
- BLoC events ready: `connectionRequested`, `connectionStatusChanged`
- Connection testing utilities available

### Story 2.2: Frame Streaming
- BLoC events ready: `streamingStarted`, `streamingStopped`, `frameProcessed`
- State management: `streamingStatus` enum and `framesProcessed` counter
- WebSocket service ready for `sendImageFrame()` calls

## 🚀 Getting Started for New Developers

1. **Clone and Setup**
   ```bash
   git clone <repository>
   cd face-check-in-flutter
   flutter pub get
   ```

2. **Generate Code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. **Run Tests**
   ```bash
   flutter test
   ```

4. **Start Development**
   ```bash
   flutter run --debug
   ```

5. **Enable Debug Mode**
   - Tap the bug icon in the app bar
   - View debug information and statistics

## 📋 Story Status & Next Steps

### ✅ Completed (Story 1.1)
- Project foundation and folder structure
- Complete BLoC architecture with state management
- WebSocket service with backend integration
- App-level integration with theme and routing
- Unit tests and code generation setup

### 🔄 Next Priority (Story 1.2)
- Camera integration and permissions
- Camera preview implementation
- Real-time frame capture

### 📅 Future Stories
- Story 2.1: WebSocket connection implementation
- Story 2.2: Frame streaming and processing
- Story 3.1: Face recognition integration
- Story 3.2: Employee check-in flow

## 🤝 Team Collaboration

### Code Review Checklist
- [ ] BLoC events and states properly defined
- [ ] Code generation files updated
- [ ] Unit tests added for new functionality
- [ ] Debug logging implemented
- [ ] Error handling comprehensive
- [ ] Documentation updated

### Parallel Development Guidelines
- Each feature should have its own BLoC events and states
- Use the established WebSocket service for backend communication
- Follow the existing folder structure and naming conventions
- Add comprehensive logging for debugging
- Write unit tests for all new services and BLoCs

---

**Last Updated**: 2024-12-19 by David (Flutter Dev #1)  
**Status**: Foundation Complete - Ready for Story 1.2 Development 
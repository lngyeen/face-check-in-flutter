# Check-In Feature Widgets

This directory contains all the refactored widgets for the Face Check-In feature, following Flutter best practices.

## Widget Structure

### Main Screen
- **`CheckInScreen`** (`../screens/check_in_screen.dart`) - Main screen coordinator that orchestrates all components

### Core Components
- **`SystemStatusCard`** - Displays system status (camera, connection, streaming, face detection)
- **`CameraSection`** - Camera preview with consistent height and styling
- **`CheckInListeners`** - Handles all BlocListeners for notifications and error messages

### Debug Components (only visible in debug mode)
- **`DebugToggleButton`** - App bar button for toggling debug mode
- **`DebugControlsCard`** - Debug control buttons (restart camera, websocket, streaming)
- **`DebugInformationCard`** - Debug info display (frame rate, stats, captured frames)

### Utility Components
- **`LoadingSection`** - Loading indicator that shows when system is processing
- **`CameraPreviewWidget`** - Original camera preview widget (unchanged)

### Extensions
- **`status_extensions.dart`** - Status display extensions for consistent UI formatting

## Best Practices Applied

### 1. **Separation of Concerns**
- Each widget has a single, clear responsibility
- Business logic stays in BLoC, UI components are pure presentation
- Listeners separated from display logic

### 2. **Widget Composition**
- Large widgets broken down into smaller, reusable components
- Private widgets (`_RestartCameraButton`, `_StatusRow`) for internal use only
- Consistent naming and documentation

### 3. **Performance Optimizations**
- **Smart BlocBuilder usage**: Each widget only rebuilds when relevant state changes
- **Conditional rendering**: Debug sections only rendered when needed
- **Const constructors**: Used throughout for widgets that don't change

### 4. **Code Organization**
- Related functionality grouped together
- Clear file and class naming conventions
- Comprehensive documentation for each widget's purpose

### 5. **State Management Best Practices**
- `buildWhen` used to prevent unnecessary rebuilds
- State accessed only where needed
- Clean separation between stateful and stateless components

### 6. **UI Consistency**
- Standard spacing (SizedBox(height: 16) between sections)
- Consistent Card styling and padding
- Proper use of CrossAxisAlignment and layout principles

## Widget Hierarchy

```
CheckInScreen
├── CheckInListeners (wrapper)
│   ├── _ToastMessageListener
│   └── _BackendErrorListener
└── SingleChildScrollView
    ├── SystemStatusCard
    │   └── _StatusRow (repeated)
    ├── CameraSection
    │   └── CameraPreviewWidget
    ├── DebugControlsCard (if debug mode)
    │   ├── _RestartCameraButton
    │   ├── _RestartWebSocketButton
    │   └── _StreamingToggleButton
    ├── DebugInformationCard (if debug mode)
    │   ├── _CapturedFramePreview
    │   ├── _FaceDetectionInfo
    │   ├── _ResponseErrorInfo
    │   ├── _StatisticsInfo
    │   └── _ResetStatsButton
    └── LoadingSection
```

## Benefits of This Structure

1. **Maintainability**: Each component can be modified independently
2. **Testability**: Individual widgets can be tested in isolation
3. **Reusability**: Components can be reused in other parts of the app
4. **Performance**: Only necessary parts of the UI rebuild when state changes
5. **Readability**: Code is easier to understand and navigate
6. **Scalability**: New features can be added without modifying existing components

## File Organization
- Main screen: `../screens/check_in_screen.dart`
- All widgets: `./` (current directory)
- Extensions: `./status_extensions.dart`
- BLoC: `../bloc/` 
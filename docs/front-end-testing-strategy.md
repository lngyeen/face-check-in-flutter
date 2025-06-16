# Testing Strategy & Framework Guidelines

**Project**: FaceCheckIn Employee  
**Document Version**: 1.0  
**Created by**: Sarah - Product Owner

## 📋 **Testing Framework Overview**

### **TDD-Enhanced Testing Pyramid for MVP**
```
     /\
    /  \
   / E2E \ (Post-MVP)
  /______\
 /        \
/  Widget  \ (25% of effort)
\  Tests   /
 \________/
/          \
/ Unit     \ (75% of effort - TDD Focus)  
\ Tests    /
\________/
```

## 🔄 **TDD Integration Requirements**

### **Test-First Development Process**
1. **🔴 RED Phase**: Write failing test that describes expected behavior
2. **🟢 GREEN Phase**: Write minimal code to make test pass
3. **🔵 REFACTOR Phase**: Improve code quality while keeping tests green

### **TDD Story Requirements**
- [ ] **Pre-Development**: Test plan created before coding starts
- [ ] **Test-First**: Every new feature starts with a failing test
- [ ] **Incremental**: Small, focused test-code cycles
- [ ] **Comprehensive**: Cover edge cases and error scenarios

## 🧪 **Unit Testing Standards**

### **Coverage Requirements**
- **Business Logic**: 80% minimum coverage
- **BLoC Files**: 85% minimum coverage  
- **Service Classes**: 80% minimum coverage
- **Utilities**: 75% minimum coverage
- **Widgets**: 60% minimum coverage (focus on logic, not UI)

### **Required Unit Tests by Story**

#### **Story 1.1a: Project Foundation**
```dart
// Test Categories Required:
✓ Configuration loading tests
✓ Dependency injection tests  
✓ Environment setup validation
✓ Backend connection parameter tests
```

#### **Story 1.1b: BLoC Foundation**
```dart
// Test Categories Required:
✓ Initial state tests
✓ Event handling tests
✓ State transition tests
✓ Error state management tests
✓ BLoC observer functionality tests
```

#### **Story 1.2a: Camera Permission**
```dart
// Test Categories Required:
✓ Permission request logic tests
✓ Permission status handling tests
✓ Camera initialization tests
✓ Error scenario tests
✓ Platform-specific behavior tests
```

#### **Story 1.2b: Camera Preview Widget**
```dart
// Test Categories Required:
✓ Widget state rendering tests
✓ Camera status integration tests
✓ Layout constraint tests
✓ Error state display tests
```

#### **Story 1.3: Debug View**
```dart
// Test Categories Required:
✓ Message logging tests
✓ Debug service tests
✓ Compile-time flag tests
✓ Memory management tests
```

#### **Story 2.1a: WebSocket Service**
```dart
// Test Categories Required:
✓ Connection management tests
✓ Retry logic tests
✓ Timeout handling tests
✓ Configuration tests
✓ Error recovery tests
```

#### **Story 2.1b: WebSocket BLoC Integration**
```dart
// Test Categories Required:
✓ Service integration tests
✓ Automatic connection tests
✓ Lifecycle management tests
✓ State synchronization tests
```

#### **Story 2.2a: Frame Processing**
```dart
// Test Categories Required:
✓ Image processing tests
✓ Base64 conversion tests
✓ Quality validation tests
✓ Performance tests
✓ Memory management tests
```

#### **Story 2.2b: Frame Streaming**
```dart
// Test Categories Required:
✓ Streaming timer tests
✓ Frame sending tests
✓ Performance monitoring tests
✓ Error handling tests
```

#### **Story 2.3: Response Processing**
```dart
// Test Categories Required:
✓ Message parsing tests
✓ Success/failure detection tests
✓ Toast display logic tests
✓ Error handling tests
```

## 🖼️ **Widget Testing Standards**

### **Widget Test Requirements**
- **State-Dependent Widgets**: Test all major states
- **User Interaction**: Test tap, scroll, input behaviors
- **Layout**: Test responsive behavior
- **Error States**: Test error display and recovery
- **Integration**: Test with mock BLoC states

### **Required Widget Tests by Component**

#### **CheckInScreen Tests**
```dart
testWidgets('displays loading state correctly', (tester) async {
  // Test loading state rendering
});

testWidgets('displays camera preview when ready', (tester) async {
  // Test camera preview integration
});

testWidgets('shows error state appropriately', (tester) async {
  // Test error state handling
});
```

#### **CameraPreviewWidget Tests**
```dart
testWidgets('renders loading indicator during initialization', (tester) async {
  // Test loading state
});

testWidgets('displays camera preview when available', (tester) async {
  // Test preview display
});

testWidgets('handles permission denied state', (tester) async {
  // Test error states
});
```

#### **ToastWidget Tests**
```dart
testWidgets('displays success toast with correct styling', (tester) async {
  // Test success toast
});

testWidgets('displays failure toast with appropriate message', (tester) async {
  // Test failure toast
});

testWidgets('auto-hides after specified duration', (tester) async {
  // Test auto-hide behavior
});
```

## 🔧 **Testing Tools & Configuration**

### **Required Testing Dependencies**
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: ^9.1.0
  mocktail: ^1.0.0
  integration_test:
    sdk: flutter
```

### **Mock Strategy**
```dart
// Service Mocks
class MockWebSocketService extends Mock implements WebSocketService {}
class MockCameraService extends Mock implements CameraService {}
class MockFrameProcessingService extends Mock implements FrameProcessingService {}

// Repository Mocks
class MockDebugLogService extends Mock implements DebugLogService {}

// Platform Mocks
class MockPermissionHandler extends Mock implements PermissionHandler {}
```

### **BLoC Testing Pattern**
```dart
group('CheckInBloc', () {
  late CheckInBloc bloc;
  late MockWebSocketService mockWebSocketService;
  
  setUp(() {
    mockWebSocketService = MockWebSocketService();
    bloc = CheckInBloc(mockWebSocketService);
  });
  
  blocTest<CheckInBloc, CheckInState>(
    'emits correct states when event occurs',
    build: () => bloc,
    act: (bloc) => bloc.add(SomeEvent()),
    expect: () => [ExpectedState()],
    verify: (bloc) {
      // Additional verifications
    },
  );
});
```

## 📱 **Integration Testing Strategy**

### **Critical Integration Flows**
1. **Complete Check-in Flow**: Camera → WebSocket → Response → Toast
2. **Permission Flow**: Permission request → Camera initialization
3. **Connection Flow**: App startup → Camera ready → WebSocket connection
4. **Error Recovery**: Connection lost → Reconnect → Resume streaming

### **Integration Test Scenarios**
```dart
group('Check-in Integration Tests', () {
  testWidgets('complete successful check-in flow', (tester) async {
    // Test end-to-end successful check-in
  });
  
  testWidgets('handles failed recognition gracefully', (tester) async {
    // Test failure scenario handling
  });
  
  testWidgets('recovers from connection loss', (tester) async {
    // Test connection recovery
  });
});
```

## 🎯 **Testing Guidelines by Story**

### **Definition of Done - Testing Criteria**

#### **For Service/Logic Stories**
- [ ] Unit tests cover all public methods
- [ ] Error scenarios are tested
- [ ] Mock dependencies are used appropriately
- [ ] Performance-critical paths are tested
- [ ] Memory leaks are verified not to exist

#### **For UI/Widget Stories**  
- [ ] Widget tests cover major states
- [ ] User interactions are tested
- [ ] Layout constraints are verified
- [ ] Error states are tested
- [ ] Integration with BLoC is tested

#### **For Integration Stories**
- [ ] Service integration is tested
- [ ] Data flow between components is verified
- [ ] Error propagation is tested
- [ ] State synchronization is verified

## 🚀 **Testing Execution Strategy**

### **Development Workflow**
1. **Red-Green-Refactor**: Write failing tests first
2. **Test During Development**: Run tests continuously during coding
3. **CI Integration**: All tests must pass before merge
4. **Code Coverage**: Monitor coverage and maintain targets

### **Test Organization**
```
test/
├── unit/
│   ├── services/
│   ├── blocs/
│   ├── utils/
│   └── models/
├── widget/
│   ├── screens/
│   ├── widgets/
│   └── components/
└── integration/
    ├── flows/
    └── scenarios/
```

### **Test Naming Convention**
```dart
// Unit Tests
test('should return success when valid input provided', () {});
test('should throw exception when invalid input provided', () {});

// Widget Tests  
testWidgets('should display loading indicator when state is loading', (tester) async {});
testWidgets('should show error message when state is error', (tester) async {});

// BLoC Tests
blocTest<CheckInBloc, CheckInState>(
  'should emit [loading, success] when valid event added',
  // ...
);
```

## 📊 **Quality Metrics & Monitoring**

### **Automated Quality Gates**
- **Code Coverage**: Minimum thresholds per component type
- **Test Execution Time**: Maximum 2 minutes for full suite
- **Test Reliability**: 99% pass rate required
- **Performance**: No memory leaks in critical paths

### **Manual Testing Checklist**
- [ ] Test on minimum supported devices (Android API 28, iOS 15)
- [ ] Test on maximum performance devices
- [ ] Test with poor network conditions
- [ ] Test with backend service unavailable
- [ ] Test edge cases and error scenarios

## 🎯 **Story-Specific Testing Requirements**

Each story should include:
- **Unit Test Plan**: Specific test cases for business logic
- **Widget Test Plan**: UI component testing strategy  
- **Integration Test Plan**: Component integration verification
- **Performance Test Plan**: Performance-critical path testing
- **Error Test Plan**: Error scenario and recovery testing

**Minimum Test Coverage per Story**: 
- Unit Tests: 80% minimum
- Critical Path Coverage: 100%
- Error Scenario Coverage: 90%

---

**This testing strategy ensures consistent, high-quality testing across all stories while maintaining focus on MVP delivery timeline.** 
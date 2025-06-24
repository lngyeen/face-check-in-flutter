# ConnectionManager Refactor Tracking

## 📊 Current Status: 8.5/10 ⬆️ **IMPROVED!**
**Last Review Date:** December 2024  
**Reviewer:** Dev Team  
**Previous Rating:** 7.5/10  
**Target Rating:** 9.0/10

**Recent Achievements:**
- ✅ Phase 1: Quick Wins (100% complete)
- ✅ Phase 2: Structure Improvements (100% complete)

---

## 🎯 PHASE 1: Quick Wins (Priority: HIGH)

### 1.1 Exponential Backoff Safety
- [x] **Add max delay cap** to prevent infinite exponential growth ✅ **COMPLETED**
  - ✅ Re-added `maxDelay` field to `ReconnectionConfig`
  - ✅ Updated `_calculateBackoffDelay()` to clamp delays to max 30s
  - ✅ Fixed potential 17+ minute delay issue
  - Files: `connection_manager.dart` lines ~95, ~540

### 1.2 Code Deduplication  
- [x] **Consolidate duplicate retry start logic** ✅ **COMPLETED**
  - ✅ Added `_startFreshRetryPhase()` method to consolidate pattern
  - ✅ Replaced 5 duplicate occurrences across the codebase
  - ✅ Reduced code duplication by ~12 lines
  - Files: `connection_manager.dart` lines 409, 416, 425, 457, 461

### 1.3 Method Naming Clarity
- [x] **Rename confusing method pairs** ✅ **COMPLETED**
  - ✅ `_handleConnectionFailure()` → `_handleConnectionFailureFromWebSocket()`
  - ✅ `_attemptReconnection()` → `_attemptReconnectionWithBackoff()`
  - ✅ Improved method naming clarity and purpose indication
  - Files: `connection_manager.dart` lines 277, 298, 478, 482

### 1.4 Background Monitoring Implementation
- [x] **Implement meaningful background monitoring** ✅ **COMPLETED**
  - ✅ Added `_performBackgroundConnectivityCheck()` with actual logic
  - ✅ Added `_checkServerReachability()` for lightweight server ping
  - ✅ Background monitoring now attempts reconnection when server becomes available
  - ✅ Proper state validation before performing checks
  - Files: `connection_manager.dart` lines 536-570

---

## 🏗️ PHASE 2: Structure Improvements (Priority: MEDIUM)

### 2.1 File Organization
- [x] **Split large file into focused classes** ✅ **COMPLETED**
  - ✅ Reduced main ConnectionManager from 575 → 303 lines (-47%)
  - ✅ Extracted ReconnectionStrategy to dedicated file (242 lines)
  - ✅ Extracted Models & Enums to connection_models.dart (143 lines)
  - ✅ Organized into clean folder structure:
    ```
    lib/core/services/connection/
    ├── connection_manager.dart (303 lines - main orchestrator)
    ├── reconnection_strategy.dart (242 lines - reconnection logic)
    └── connection_models.dart (143 lines - enums, configs)
    ```
  - ✅ Updated all imports and dependency injection
  - ✅ Zero linter errors after refactoring

### 2.2 State Management Unification
- [x] **Address dual state tracking** ✅ **COMPLETED**
  - ✅ Added `ReconnectionDetails` class for detailed reconnection information
  - ✅ Unified state management through `ConnectionSummary.reconnectionDetails`
  - ✅ Clear separation: `ConnectionState` for UI, `ReconnectionState` for retry logic
  - ✅ UI can now display detailed reconnection progress (attempt X/Y)
  - ✅ Added helpful properties like `canManualRetry` for UI interactions

### 2.3 Error Handling Standardization
- [x] **Create consistent error handling strategy** ✅ **COMPLETED & SIMPLIFIED**
  - ✅ ~~Removed over-engineered `ConnectionErrorHandler`~~ 
  - ✅ **Simplified to direct state updates**: `shouldEmitFailedState` parameter
  - ✅ **User-facing errors** → Emit `ConnectionState.failed` for manual retry
  - ✅ **Internal errors** → Log only, no state change
  - ✅ **Clear separation**: Connection failures vs system monitoring errors
  - ✅ **Better UX**: User gets immediate feedback and retry option

### 2.4 Stream Management
- [x] **Review streaming responsibility separation** ✅ **COMPLETED**
  - ✅ Removed streaming method delegation from ConnectionManager
  - ✅ Replaced 6 proxy methods with 2 clean integration points:
    - `canStream` - Connection state check for streaming eligibility
    - `streamService` - Direct access to StreamService for consumers
  - ✅ Updated CheckInBloc to use new streaming approach
  - ✅ Maintained connection state validation while improving separation
  - ✅ Reduced ConnectionManager from 575 → 322 lines (44% reduction)

---

## 🚀 PHASE 3: Advanced Optimizations (Priority: LOW)

### 3.1 Architecture Patterns
- [ ] **Implement Strategy Pattern for reconnection**
  ```dart
  abstract class ReconnectionStrategy {
    Future<bool> execute();
  }
  class FastRetryStrategy extends ReconnectionStrategy { ... }
  class BackgroundMonitoringStrategy extends ReconnectionStrategy { ... }
  ```

### 3.2 Event-Driven Architecture
- [ ] **Consider event-driven approach**
  ```dart
  sealed class ConnectionEvent {}
  class NetworkLostEvent extends ConnectionEvent {}
  class ConnectionSuccessEvent extends ConnectionEvent {}
  ```

### 3.3 Testing Infrastructure
- [ ] **Add comprehensive test coverage**
  - Unit tests for state transitions
  - Integration tests for reconnection scenarios
  - Mock network conditions testing

---

## ⚠️ CRITICAL ISSUES TO MONITOR

### Security & Stability
- [ ] **Race condition prevention**
  - Timer conflicts between `_fastRetryTimer` and `_backgroundMonitoringTimer`
  - Solution: Add mutex or state validation

- [ ] **Memory leak prevention**
  - Ensure StreamControllers are properly disposed
  - Verify timer cleanup in all scenarios

### Performance
- [ ] **Optimize state change frequency**
  - Review if state updates are too frequent for UI
  - Consider debouncing rapid state changes

---

## 📝 IMPLEMENTATION NOTES

### Phase 1 Completion Criteria
- ✅ All exponential backoff delays capped at reasonable limits
- ✅ No duplicate code patterns remain
- ✅ Method names clearly indicate their purpose
- ✅ Background monitoring performs actual connectivity checks

### Phase 2 Completion Criteria  
- ✅ File structure follows single responsibility principle
- ✅ State management has clear, documented patterns
- ✅ Error handling is consistent across all methods
- ✅ Responsibilities are properly separated

### Phase 3 Completion Criteria
- ✅ Code follows SOLID principles
- ✅ Test coverage > 90%
- ✅ Performance meets requirements
- ✅ Architecture supports future extensions

---

## 🎯 SUCCESS METRICS

### Before Improvements
- File size: 575 lines
- Complexity: High (multiple concerns mixed)
- Maintainability: Medium
- Test coverage: Unknown

### After Phase 1 & 2 Improvements ✅
- File size: 303 lines (main manager) - **47% reduction**
- Complexity: Low (clear separation of concerns)
- Maintainability: High (modular architecture)
- Error handling: Simplified and direct (emit failed state for manual retry)
- Architecture: Clean separation with focused responsibilities

### Target After Phase 3
- Test coverage: >90%
- Performance optimization complete
- Full SOLID compliance

---

## 📅 MILESTONE TRACKING

| Phase | Start Date | Target Date | Completion Date | Status |
|-------|------------|-------------|-----------------|--------|
| Phase 1 | Dec 2024 | Dec 2024 | Dec 2024 | ✅ **COMPLETED** |
| Phase 2 | Dec 2024 | Dec 2024 | Dec 2024 | ✅ **COMPLETED** |  
| Phase 3 | TBD | TBD | - | ⏳ Pending |

---

**Next Action:** Start with Phase 1.1 - Add max delay cap for exponential backoff 

# Flutter Face Check-in BLoC Refactor Plan

## Overview
Detailed analysis of `CheckInBloc` and `ConnectionBloc` integration issues found during code review. Issues are prioritized by severity and impact.

---

## 🔴 CRITICAL ISSUES (Priority 1 - Fix Immediately)

### Issue #1: Race Conditions trong khởi tạo
**Location**: `lib/features/check_in/bloc/check_in_bloc.dart:233`
**Problem**: Sau khi camera operational, gọi `_initializeConnectionBloc()` async nhưng không đợi kết quả
```dart
emit(state.copyWith(
  cameraStatus: CameraStatus.operational,
  cameraController: controller,
));
await _initializeConnectionBloc(); // ⚠️ Async nhưng không sync với UI state
```
**Impact**: UI hiển thị camera operational trước khi connection sẵn sàng
**Solution**: Tạo composite initialization state, đợi cả camera + connection ready

### Issue #2: Memory Leak tiềm ẩn với Stream Subscriptions  
**Location**: `lib/features/check_in/bloc/check_in_bloc.dart:41-52`
**Problem**: Cancel subscriptions rồi tạo mới mỗi lần gọi, không có protection
```dart
_connectionStateSubscription?.cancel();
_connectionStateSubscription = _connectionBloc.stream // ⚠️ Có thể leak
```
**Impact**: Multiple subscriptions nếu method được gọi nhiều lần
**Solution**: Add subscription state tracking, implement proper disposal pattern

### Issue #3: Error Handling Gaps trong Connection Attempt
**Location**: `lib/features/connection/bloc/connection_bloc.dart:355`
**Problem**: Catch exception nhưng không emit error state cho UI
```dart
} catch (e) {
  _recordError(emit, WebSocketError(...)); // ⚠️ Chỉ record, không update UI
}
```
**Impact**: UI không biết connection failed
**Solution**: Emit proper error state với user-actionable messages

### Issue #4: Permission Logic Double Request
**Location**: `lib/features/check_in/bloc/check_in_bloc.dart:161-183`
**Problem**: Request permission lại ngay lập tức trong denied handler
```dart
final status = await _permissionService.requestCameraPermission(); // ⚠️ Double request
```
**Impact**: Spam permission dialog, bad UX
**Solution**: Implement proper permission flow state machine

---

## 🟡 LOGIC ISSUES (Priority 2 - Fix Soon)

### Issue #5: Inconsistent Camera Resource Management
**Location**: `lib/features/check_in/bloc/check_in_bloc.dart:101-119`
**Problem**: Chỉ start camera khi connection ready, nhưng không stop khi connection lost
```dart
// Note: We DON'T stop camera when connection lost
```
**Impact**: Battery drain, resource waste
**Solution**: Add smart camera lifecycle management based on connection state

### Issue #6: Frame Processing Race Condition
**Location**: `lib/features/check_in/bloc/check_in_bloc.dart:428-432`
**Problem**: Check `canStream` nhưng không check camera state
```dart
if (_connectionBloc.state.canStream) {
  _connectionBloc.addFrame(event.image); // ⚠️ Không check camera
}
```
**Impact**: Send frames when camera not ready
**Solution**: Add comprehensive state validation

### Issue #7: Circular Dependency Risk
**Location**: Architecture level
**Problem**: CheckInBloc depends on ConnectionBloc, có thể cần reverse dependency
**Impact**: Tight coupling, khó maintain
**Solution**: Introduce mediator pattern hoặc event bus

### Issue #8: State Transition Validation Gaps
**Location**: `lib/features/connection/bloc/connection_bloc.dart:450-480`
**Problem**: `_safeEmit()` validation không cover hết edge cases
**Impact**: Invalid state transitions có thể xảy ra
**Solution**: Complete state machine validation

---

## 🟠 PERFORMANCE ISSUES (Priority 3 - Optimize Later)

### Issue #9: Heavy JSON Parsing in Main Thread
**Location**: `lib/features/check_in/bloc/check_in_bloc.dart:300-340`
**Problem**: Parse WebSocket messages synchronously
```dart
data = json.jsonDecode(event.data as String) as Map<String, dynamic>;
```
**Impact**: UI lag khi parse large responses
**Solution**: Move to background isolate

### Issue #10: Frame Dropping Logic Issues
**Location**: `lib/features/check_in/bloc/check_in_bloc.dart:72`
**Problem**: `droppable()` transformer không có backpressure handling
```dart
on<FrameCaptured>(_onFrameCaptured, transformer: droppable());
```
**Impact**: Drop important frames
**Solution**: Implement priority-based frame queue

### Issue #11: Timer Management Race Conditions
**Location**: `lib/features/connection/bloc/connection_bloc.dart:410-430`
**Problem**: Multiple timers có thể race với nhau
**Impact**: Unexpected retry behaviors
**Solution**: Implement timer state machine

### Issue #12: WebSocket Message Stream Efficiency
**Location**: `lib/features/check_in/bloc/check_in_bloc.dart:48-51`
**Problem**: Listen to all messages, không filter
**Impact**: Process unnecessary messages
**Solution**: Add message filtering at stream level

---

## 🔵 RELIABILITY ISSUES (Priority 4 - Stability Improvements)

### Issue #13: Connection Recovery Logic
**Location**: `lib/features/connection/bloc/connection_bloc.dart:120-140`
**Problem**: Network restored không check ongoing processes
**Impact**: Interrupt current operations
**Solution**: Add operation state tracking

### Issue #14: Camera Disposal Error Handling
**Location**: `lib/features/check_in/bloc/check_in_bloc.dart:135-145`
**Problem**: Silent error handling trong cleanup
```dart
} catch (e) {
  // Silent cleanup ⚠️ Should log
}
```
**Impact**: Hidden errors, debugging difficulty
**Solution**: Add proper error logging và diagnostics

### Issue #15: Resource Lifecycle Management
**Location**: Multiple locations
**Problem**: Không có consistent resource tracking
**Impact**: Resource leaks, performance degradation
**Solution**: Implement resource lifecycle monitoring

### Issue #16: Error State Recovery
**Location**: Both BLoCs
**Problem**: Một số error states không có recovery path
**Impact**: App stuck in error state
**Solution**: Add recovery actions for all error states

---

## 🟣 ARCHITECTURE IMPROVEMENTS (Priority 5 - Long-term)

### Issue #17: Event Transformer Strategy
**Location**: Both BLoCs event registration
**Problem**: Inconsistent transformer usage
**Impact**: Unpredictable event handling
**Solution**: Standardize transformer strategy

### Issue #18: State Composition Complexity
**Location**: `CheckInState` holding `ConnectionState`
**Problem**: Tight coupling between feature states
**Impact**: Difficult to test và maintain
**Solution**: Consider state composition patterns

### Issue #19: Debugging và Monitoring
**Location**: Throughout both BLoCs
**Problem**: Limited debugging support
**Impact**: Hard to troubleshoot issues
**Solution**: Add comprehensive logging và state monitoring

### Issue #20: Testing Strategy Gaps
**Location**: Architecture level
**Problem**: Complex state interactions hard to test
**Impact**: Low test coverage, hidden bugs
**Solution**: Design for testability, add integration tests

---

## Implementation Strategy

### Phase 1: Critical Fixes (Week 1)
- Fix race conditions
- Resolve memory leaks  
- Improve error handling
- Fix permission flow

### Phase 2: Logic Improvements (Week 2)
- Camera resource management
- Frame processing optimization
- State validation
- Dependency decoupling

### Phase 3: Performance (Week 3)  
- Background processing
- Frame queue optimization
- Timer management
- Stream efficiency

### Phase 4: Reliability (Week 4)
- Recovery mechanisms
- Resource monitoring
- Error diagnostics
- Stability testing

### Phase 5: Architecture (Ongoing)
- Event transformer standardization
- State composition refactor
- Monitoring infrastructure
- Test coverage improvement

---

## Notes
- Each issue should be fixed with proper unit tests
- Integration tests needed for multi-BLoC interactions
- Performance benchmarks before/after optimizations
- User testing for UX improvements 
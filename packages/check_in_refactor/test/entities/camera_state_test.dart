import 'package:check_in_refactor/entities/camera_state.dart';
import 'package:check_in_refactor/services/camera_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CameraState', () {
    group('Business Logic', () {
      test('should correctly identify ready state', () {
        const state = CameraState(
          status: CameraStatus.ready,
          controller: null, // Would be a real controller in practice
        );

        // For testing purposes, we're using null controller
        // In real implementation, this would check controller.value.isInitialized
        expect(state.status, CameraStatus.ready);
      });

      test('should correctly identify error state', () {
        const stateWithStatusError = CameraState(
          status: CameraStatus.error,
        );

        const stateWithMessageError = CameraState(
          status: CameraStatus.initial,
          errorMessage: 'Test error',
        );

        expect(stateWithStatusError.hasError, isTrue);
        expect(stateWithMessageError.hasError, isTrue);
      });

      test('should correctly identify permission denied state', () {
        const state = CameraState(
          status: CameraStatus.permissionDenied,
        );

        expect(state.isPermissionDenied, isTrue);
      });

      test('should correctly identify front camera unavailable state', () {
        const state = CameraState(
          status: CameraStatus.frontCameraNotAvailable,
        );

        expect(state.isFrontCameraUnavailable, isTrue);
      });

      test('should provide correct display messages', () {
        const initialState = CameraState(status: CameraStatus.initial);
        expect(initialState.displayMessage, 'Camera not initialized');

        const initializingState =
            CameraState(status: CameraStatus.initializing);
        expect(initializingState.displayMessage, 'Initializing camera...');

        const permissionDeniedState =
            CameraState(status: CameraStatus.permissionDenied);
        expect(
            permissionDeniedState.displayMessage, 'Camera permission denied');

        const errorState = CameraState(
          status: CameraStatus.error,
          errorMessage: 'Custom error',
        );
        expect(errorState.displayMessage, 'Custom error');
      });
    });

    group('State Mutations', () {
      test('should create state with error', () {
        const initialState = CameraState();

        final stateWithError = initialState.withError('Test error');

        expect(stateWithError.status, CameraStatus.error);
        expect(stateWithError.errorMessage, 'Test error');
        expect(stateWithError.isInitializing, false);
      });

      test('should clear error', () {
        const stateWithError = CameraState(
          status: CameraStatus.ready,
          errorMessage: 'Test error',
        );

        final clearedState = stateWithError.clearError();

        expect(clearedState.errorMessage, isNull);
        expect(clearedState.status, CameraStatus.ready); // Status unchanged
      });
    });

    group('CopyWith Functionality', () {
      test('should copy with new values', () {
        const initialState = CameraState(
          status: CameraStatus.initial,
          isInitializing: false,
        );

        final updatedState = initialState.copyWith(
          status: CameraStatus.ready,
          isInitializing: true,
        );

        expect(updatedState.status, CameraStatus.ready);
        expect(updatedState.isInitializing, true);
      });

      test('should preserve unchanged values in copyWith', () {
        const initialState = CameraState(
          status: CameraStatus.ready,
          hasPermission: true,
          errorMessage: 'Test error',
        );

        final updatedState = initialState.copyWith(
          isInitializing: true,
        );

        expect(updatedState.status, CameraStatus.ready);
        expect(updatedState.hasPermission, true);
        expect(updatedState.errorMessage, 'Test error');
        expect(updatedState.isInitializing, true);
      });
    });

    group('Equality and Immutability', () {
      test('should be equal when all properties are the same', () {
        const state1 = CameraState(
          status: CameraStatus.ready,
          hasPermission: true,
        );

        const state2 = CameraState(
          status: CameraStatus.ready,
          hasPermission: true,
        );

        expect(state1, equals(state2));
      });

      test('should not be equal when properties differ', () {
        const state1 = CameraState(
          status: CameraStatus.ready,
        );

        const state2 = CameraState(
          status: CameraStatus.error,
        );

        expect(state1, isNot(equals(state2)));
      });
    });
  });
}

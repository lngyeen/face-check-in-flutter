import 'package:face_check_in_flutter/core/services/validators/index.dart';
import 'package:face_check_in_flutter/domain/entities/processing_mode.dart';

/// Configuration class for ImageStreamService
class ImageStreamConfiguration {
  /// Maximum consecutive no-face frames before reset
  static const int maxNoFaceFramesBeforeReset = 1;

  /// Default processing mode
  static const ProcessingMode defaultProcessingMode = ProcessingMode.hybrid;

  /// Get default validators for liveness detection
  static List<LivenessValidator> getDefaultValidators() {
    return [
      BlinkValidator(),
      QualityValidator(),
      StabilityValidator(),
      TemporalValidator(),
    ];
  }

  /// Get validator by type
  static LivenessValidator? getValidatorByType(String type) {
    final validators = getDefaultValidators();
    switch (type.toLowerCase()) {
      case 'blink':
        return validators.whereType<BlinkValidator>().firstOrNull;
      case 'quality':
        return validators.whereType<QualityValidator>().firstOrNull;
      case 'stability':
        return validators.whereType<StabilityValidator>().firstOrNull;
      case 'temporal':
        return validators.whereType<TemporalValidator>().firstOrNull;
      default:
        return null;
    }
  }

  /// Check if a validator type is enabled
  static bool isValidatorEnabled(String type) {
    return getValidatorByType(type) != null;
  }

  /// Get enabled validator types
  static List<String> getEnabledValidatorTypes() {
    final validators = getDefaultValidators();
    final types = <String>[];

    if (validators.any((v) => v is BlinkValidator)) types.add('blink');
    if (validators.any((v) => v is QualityValidator)) types.add('quality');
    if (validators.any((v) => v is StabilityValidator)) types.add('stability');
    if (validators.any((v) => v is TemporalValidator)) types.add('temporal');

    return types;
  }
}

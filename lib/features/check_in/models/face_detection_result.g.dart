// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_detection_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FaceDetectionResultImpl _$$FaceDetectionResultImplFromJson(
  Map<String, dynamic> json,
) => _$FaceDetectionResultImpl(
  frameId: json['frameId'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  faces:
      (json['faces'] as List<dynamic>)
          .map((e) => DetectedFace.fromJson(e as Map<String, dynamic>))
          .toList(),
  status: $enumDecode(_$FaceDetectionStatusEnumMap, json['status']),
);

Map<String, dynamic> _$$FaceDetectionResultImplToJson(
  _$FaceDetectionResultImpl instance,
) => <String, dynamic>{
  'frameId': instance.frameId,
  'timestamp': instance.timestamp.toIso8601String(),
  'faces': instance.faces,
  'status': _$FaceDetectionStatusEnumMap[instance.status]!,
};

const _$FaceDetectionStatusEnumMap = {
  FaceDetectionStatus.none: 'none',
  FaceDetectionStatus.detecting: 'detecting',
  FaceDetectionStatus.faceFound: 'face_found',
  FaceDetectionStatus.multipleFaces: 'multiple_faces',
  FaceDetectionStatus.noFace: 'no_face',
  FaceDetectionStatus.error: 'error',
};

_$DetectedFaceImpl _$$DetectedFaceImplFromJson(Map<String, dynamic> json) =>
    _$DetectedFaceImpl(
      faceId: json['faceId'] as String,
      box:
          (json['box'] as List<dynamic>)
              .map((e) => (e as num).toDouble())
              .toList(),
      confidence: (json['confidence'] as num).toDouble(),
      isRecognized: json['isRecognized'] as bool,
      personId: json['personId'] as String?,
      employeeName: json['employeeName'] as String?,
    );

Map<String, dynamic> _$$DetectedFaceImplToJson(_$DetectedFaceImpl instance) =>
    <String, dynamic>{
      'faceId': instance.faceId,
      'box': instance.box,
      'confidence': instance.confidence,
      'isRecognized': instance.isRecognized,
      'personId': instance.personId,
      'employeeName': instance.employeeName,
    };

_$RecognitionStatisticsImpl _$$RecognitionStatisticsImplFromJson(
  Map<String, dynamic> json,
) => _$RecognitionStatisticsImpl(
  totalFramesProcessed: (json['totalFramesProcessed'] as num?)?.toInt() ?? 0,
  totalFacesDetected: (json['totalFacesDetected'] as num?)?.toInt() ?? 0,
  successfulRecognitions:
      (json['successfulRecognitions'] as num?)?.toInt() ?? 0,
  failedRecognitions: (json['failedRecognitions'] as num?)?.toInt() ?? 0,
  averageConfidence: (json['averageConfidence'] as num?)?.toDouble() ?? 0.0,
  averageProcessingTimeMs:
      (json['averageProcessingTimeMs'] as num?)?.toDouble() ?? 0.0,
  lastRecognitionTime:
      json['lastRecognitionTime'] == null
          ? null
          : DateTime.parse(json['lastRecognitionTime'] as String),
  sessionStartTime:
      json['sessionStartTime'] == null
          ? null
          : DateTime.parse(json['sessionStartTime'] as String),
);

Map<String, dynamic> _$$RecognitionStatisticsImplToJson(
  _$RecognitionStatisticsImpl instance,
) => <String, dynamic>{
  'totalFramesProcessed': instance.totalFramesProcessed,
  'totalFacesDetected': instance.totalFacesDetected,
  'successfulRecognitions': instance.successfulRecognitions,
  'failedRecognitions': instance.failedRecognitions,
  'averageConfidence': instance.averageConfidence,
  'averageProcessingTimeMs': instance.averageProcessingTimeMs,
  'lastRecognitionTime': instance.lastRecognitionTime?.toIso8601String(),
  'sessionStartTime': instance.sessionStartTime?.toIso8601String(),
};

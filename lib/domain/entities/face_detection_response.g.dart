// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_detection_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FaceDetectionResponseImpl _$$FaceDetectionResponseImplFromJson(
  Map<String, dynamic> json,
) => _$FaceDetectionResponseImpl(
  type: json['type'] as String,
  faces:
      (json['faces'] as List<dynamic>)
          .map((e) => FaceDetectionResult.fromJson(e as Map<String, dynamic>))
          .toList(),
  frameId: json['frameId'] as String?,
  timestamp:
      json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$$FaceDetectionResponseImplToJson(
  _$FaceDetectionResponseImpl instance,
) => <String, dynamic>{
  'type': instance.type,
  'faces': instance.faces,
  'frameId': instance.frameId,
  'timestamp': instance.timestamp?.toIso8601String(),
};

_$FaceDetectionResultImpl _$$FaceDetectionResultImplFromJson(
  Map<String, dynamic> json,
) => _$FaceDetectionResultImpl(
  x: (json['x'] as num).toDouble(),
  y: (json['y'] as num).toDouble(),
  width: (json['width'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
  confidence: (json['confidence'] as num).toDouble(),
  personId: json['personId'] as String?,
  personName: json['personName'] as String?,
);

Map<String, dynamic> _$$FaceDetectionResultImplToJson(
  _$FaceDetectionResultImpl instance,
) => <String, dynamic>{
  'x': instance.x,
  'y': instance.y,
  'width': instance.width,
  'height': instance.height,
  'confidence': instance.confidence,
  'personId': instance.personId,
  'personName': instance.personName,
};

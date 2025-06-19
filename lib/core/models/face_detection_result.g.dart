// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_detection_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FaceDetectionResultImpl _$$FaceDetectionResultImplFromJson(
  Map<String, dynamic> json,
) => _$FaceDetectionResultImpl(
  id: json['id'] as String,
  confidence: (json['confidence'] as num).toDouble(),
  x: (json['x'] as num).toDouble(),
  y: (json['y'] as num).toDouble(),
  width: (json['width'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
  label: json['label'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$FaceDetectionResultImplToJson(
  _$FaceDetectionResultImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'confidence': instance.confidence,
  'x': instance.x,
  'y': instance.y,
  'width': instance.width,
  'height': instance.height,
  'label': instance.label,
  'metadata': instance.metadata,
};

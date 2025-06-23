// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_detection_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FaceDetectionResponseImpl _$$FaceDetectionResponseImplFromJson(
  Map<String, dynamic> json,
) => _$FaceDetectionResponseImpl(
  type: json['type'] as String,
  data: FaceDetectionData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$FaceDetectionResponseImplToJson(
  _$FaceDetectionResponseImpl instance,
) => <String, dynamic>{'type': instance.type, 'data': instance.data};

_$FaceDetectionDataImpl _$$FaceDetectionDataImplFromJson(
  Map<String, dynamic> json,
) => _$FaceDetectionDataImpl(
  faces:
      (json['faces'] as List<dynamic>)
          .map((e) => FaceDetectionResult.fromJson(e as Map<String, dynamic>))
          .toList(),
  faceImagePath: json['faceImagePath'] as String? ?? '',
  cameraId: json['cameraId'] as String? ?? '',
  timestamp: json['timestamp'] as String,
  processingTime: (json['processingTime'] as num?)?.toInt() ?? 0,
  isCheckinSent: json['isCheckinSent'] as bool? ?? false,
  annotatedImage: json['annotatedImage'] as String?,
);

Map<String, dynamic> _$$FaceDetectionDataImplToJson(
  _$FaceDetectionDataImpl instance,
) => <String, dynamic>{
  'faces': instance.faces,
  'faceImagePath': instance.faceImagePath,
  'cameraId': instance.cameraId,
  'timestamp': instance.timestamp,
  'processingTime': instance.processingTime,
  'isCheckinSent': instance.isCheckinSent,
  'annotatedImage': instance.annotatedImage,
};

_$FaceDetectionResultImpl _$$FaceDetectionResultImplFromJson(
  Map<String, dynamic> json,
) => _$FaceDetectionResultImpl(
  faceId: json['faceId'] as String?,
  isRecognized: json['isRecognized'] as bool? ?? false,
  confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
  gender: json['gender'] as String?,
  age: (json['age'] as num?)?.toInt(),
  mask: json['mask'] as bool? ?? false,
  bbox:
      (json['bbox'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
);

Map<String, dynamic> _$$FaceDetectionResultImplToJson(
  _$FaceDetectionResultImpl instance,
) => <String, dynamic>{
  'faceId': instance.faceId,
  'isRecognized': instance.isRecognized,
  'confidence': instance.confidence,
  'gender': instance.gender,
  'age': instance.age,
  'mask': instance.mask,
  'bbox': instance.bbox,
};

_$ImageSizeImpl _$$ImageSizeImplFromJson(Map<String, dynamic> json) =>
    _$ImageSizeImpl(
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
    );

Map<String, dynamic> _$$ImageSizeImplToJson(_$ImageSizeImpl instance) =>
    <String, dynamic>{'width': instance.width, 'height': instance.height};

_$BoundingBoxImpl _$$BoundingBoxImplFromJson(Map<String, dynamic> json) =>
    _$BoundingBoxImpl(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
    );

Map<String, dynamic> _$$BoundingBoxImplToJson(_$BoundingBoxImpl instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
    };

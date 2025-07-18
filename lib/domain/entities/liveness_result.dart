import 'package:freezed_annotation/freezed_annotation.dart';

part 'liveness_result.freezed.dart';

@freezed
class LivenessResult with _$LivenessResult {
  const LivenessResult._();

  // Trạng thái thành công, có thể kèm điểm tin cậy
  const factory LivenessResult.passed({@Default(1.0) double confidence}) =
      Passed;
  // Trạng thái thất bại, BẮT BUỘC phải có lý do
  const factory LivenessResult.failed({required LivenessFailureReason reason}) =
      Failed;

  // Các trạng thái khác
  const factory LivenessResult.error({String? message}) = Error;
  const factory LivenessResult.processing() = Processing;
  const factory LivenessResult.needMoreFrames() = NeedMoreFrames;
  const factory LivenessResult.completed() = Completed;

  bool get isPassed => this is Passed;
  bool get isCompleted => this is Completed;
}

enum EyeState { open, closed, unknown }

// Enum này rất quan trọng cho việc cung cấp feedback
enum LivenessFailureReason {
  waitingForFace('Đang tìm khuôn mặt', 'Vui lòng đưa khuôn mặt vào khung hình'),
  insufficientFrames('Chưa đủ dữ liệu', 'Vui lòng giữ nguyên vị trí'),
  processingError('Lỗi xử lý', 'Vui lòng thử lại'),
  faceTooSmall('Khuôn mặt quá nhỏ', 'Hãy tiến lại gần camera hơn'),
  faceTooLarge('Khuôn mặt quá lớn', 'Hãy lùi ra xa camera hơn'),
  faceNotCentered('Mặt lệch khung hình', 'Hãy di chuyển mặt vào giữa'),
  poorLighting('Thiếu sáng', 'Hãy đến nơi có ánh sáng tốt hơn'),
  tooBlurry('Ảnh bị mờ', 'Vui lòng giữ camera ổn định'),
  headTurnedTooMuch('Nghiêng đầu quá nhiều', 'Vui lòng nhìn thẳng vào camera'),
  noBlinkDetected('Không phát hiện chớp mắt', 'Hãy chớp mắt tự nhiên nhé'),
  unstableMovement('Di chuyển quá nhiều', 'Vui lòng giữ khuôn mặt ổn định'),
  lowQualityFrames(
    'Chất lượng khung hình thấp',
    'Vui lòng kiểm tra lại ánh sáng và camera',
  ),
  temporalInconsistent('Tốc độ khung hình không ổn định', 'Hãy thử lại');

  const LivenessFailureReason(this.title, this.suggestion);
  final String title;
  final String suggestion;
}

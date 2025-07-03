import 'package:freezed_annotation/freezed_annotation.dart';

part 'streaming_error.freezed.dart';

@freezed
abstract class StreamingError with _$StreamingError {
  const factory StreamingError.processingFailed() = _ProcessingFailed;
  const factory StreamingError.webSocketFailed() = _WebSocketFailed;
}

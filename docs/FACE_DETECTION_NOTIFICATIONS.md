# Face Detection Notifications - Snack Bar System

## Tổng quan
Hệ thống thông báo phát hiện khuôn mặt sử dụng snack bar để hiển thị trạng thái và phản hồi của quá trình nhận diện khuôn mặt theo thời gian thực.

## Các loại thông báo

### 1. Thành công (Success)
- **faceDetectedSuccess**: Phát hiện khuôn mặt thành công
- **checkInSuccess**: Check-in thành công
- **Màu sắc**: Xanh lá cây
- **Icon**: 👤 (face), ✅ (check_circle)
- **Thời gian hiển thị**: 2-4 giây

### 2. Cảnh báo (Warning)
- **multipleFacesWarning**: Phát hiện nhiều khuôn mặt
- **Màu sắc**: Cam
- **Icon**: ⚠️ (warning)
- **Thời gian hiển thị**: 3 giây
- **Thông điệp**: "Chỉ một người trong khung hình"

### 3. Thông tin (Info)
- **noFaceDetected**: Không phát hiện khuôn mặt
- **Màu sắc**: Xanh dương
- **Icon**: 🔍 (person_search)
- **Thời gian hiển thị**: 2 giây
- **Thông điệp**: "Hãy di chuyển vào khung hình"

### 4. Lỗi (Error)
- **checkInFailed**: Check-in thất bại
- **connectionError**: Lỗi kết nối
- **processingError**: Lỗi xử lý hình ảnh
- **Màu sắc**: Đỏ
- **Icon**: ❌ (error), 📶 (wifi_off)
- **Thời gian hiển thị**: 3-4 giây

## Cách hoạt động

### 1. Xử lý kết quả từ Backend
```dart
void _processFaceDetectionResult(FaceDetectionResult result) {
  String message;
  FaceDetectionNotificationType notificationType;

  switch (result.status) {
    case FaceDetectionStatus.faceFound:
      notificationType = FaceDetectionNotificationType.faceDetectedSuccess;
      message = '✅ Đã phát hiện khuôn mặt - Đang xử lý...';
      break;
    // ... other cases
  }

  // Show notification
  add(CheckInEvent.showFaceDetectionNotification(
    type: notificationType,
    message: message,
  ));
}
```

### 2. Hiển thị Snack Bar
```dart
BlocListener<CheckInBloc, CheckInState>(
  listenWhen: (previous, current) =>
      previous.shouldShowNotification != current.shouldShowNotification &&
      current.shouldShowNotification == true,
  listener: (context, state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(state.notificationType.icon),
            Text(state.notificationMessage!),
          ],
        ),
        backgroundColor: state.notificationType.backgroundColor,
        duration: state.notificationType.duration,
      ),
    );
  },
)
```

### 3. Tự động xóa thông báo
- Thông báo tự động xóa sau thời gian quy định
- BLoC event `clearFaceDetectionNotification` được gọi sau 3 giây

## Ví dụ các thông báo

### Phát hiện khuôn mặt thành công
```
✅ Phát hiện khuôn mặt thành công!
Màu: Xanh lá | Thời gian: 2s
```

### Nhiều khuôn mặt
```
⚠️ Phát hiện nhiều khuôn mặt - Chỉ một người trong khung hình
Màu: Cam | Thời gian: 3s
```

### Không có khuôn mặt
```
👤 Không phát hiện khuôn mặt - Hãy di chuyển vào khung hình
Màu: Xanh dương | Thời gian: 2s
```

### Check-in thành công
```
🎉 Check-in thành công! Chào [Tên nhân viên]
Màu: Xanh lá | Thời gian: 4s
```

### Khuôn mặt rõ ràng với độ tin cậy cao
```
✅ Khuôn mặt rõ ràng (95.5%) - Đang nhận diện...
Màu: Xanh lá | Thời gian: 2s
```

## Tùy chỉnh thông báo

### Màu sắc theo loại
```dart
extension FaceDetectionNotificationDisplay on FaceDetectionNotificationType {
  Color get backgroundColor {
    switch (this) {
      case FaceDetectionNotificationType.faceDetectedSuccess:
      case FaceDetectionNotificationType.checkInSuccess:
        return Colors.green;
      case FaceDetectionNotificationType.multipleFacesWarning:
        return Colors.orange;
      // ... other cases
    }
  }
}
```

### Thời gian hiển thị theo độ quan trọng
```dart
Duration get duration {
  switch (this) {
    case FaceDetectionNotificationType.checkInSuccess:
    case FaceDetectionNotificationType.checkInFailed:
      return const Duration(seconds: 4); // Quan trọng nhất
    case FaceDetectionNotificationType.multipleFacesWarning:
      return const Duration(seconds: 3); // Cảnh báo
    case FaceDetectionNotificationType.faceDetectedSuccess:
      return const Duration(seconds: 2); // Thông tin
  }
}
```

## Tích hợp với Debug Mode

Khi debug mode được bật, thông tin chi tiết về thông báo được hiển thị:
```
Last Notification: ✅ Phát hiện khuôn mặt thành công!
Notification Type: faceDetectedSuccess
```

## Performance

- **Tần suất**: Thông báo chỉ hiển thị khi có thay đổi trạng thái
- **Tự động cleanup**: Tránh spam thông báo bằng cách tự động xóa
- **Memory efficient**: Sử dụng enum thay vì string constants
- **Responsive**: Snack bar floating với animation mượt mà

## Lưu ý khi sử dụng

1. **Không spam**: Thông báo chỉ hiển thị khi trạng thái thực sự thay đổi
2. **Đa ngôn ngữ**: Messages có thể dễ dàng localize
3. **Accessibility**: Icons và colors hỗ trợ người dùng khiếm thị
4. **Consistent UX**: Tất cả thông báo tuân theo design system chung 
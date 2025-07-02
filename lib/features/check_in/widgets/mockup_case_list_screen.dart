import 'package:face_check_in_flutter/core/theme/app_colors.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/check_in_mockup_screen.dart';
import 'package:flutter/material.dart';

class MockupCaseListScreen extends StatelessWidget {
  const MockupCaseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scenarios = MockupScenario.values;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Mockup Scenarios'),
        backgroundColor: theme.colorScheme.surface,
      ),
      body: ListView.builder(
        itemCount: scenarios.length,
        itemBuilder: (context, index) {
          final scenario = scenarios[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                _getScenarioTitle(scenario),
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              subtitle: Text(
                _getScenarioDescription(scenario),
                style: theme.textTheme.bodyMedium,
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: AppColors.textSecondary,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CheckInMockupScreen(scenario: scenario),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  String _getScenarioTitle(MockupScenario scenario) {
    switch (scenario) {
      case MockupScenario.idle:
        return 'Mặc định (Idle)';
      case MockupScenario.processing:
        return 'Đang xử lý (Processing)';
      case MockupScenario.success:
        return 'Thành công (Success)';
      case MockupScenario.failure:
        return 'Thất bại (Failure)';
      case MockupScenario.connectionLost:
        return 'Mất kết nối (Connection Lost)';
      case MockupScenario.debugIdle:
        return 'Chế độ Debug (Debug Mode)';
      case MockupScenario.initializing:
        return 'Đang khởi tạo (Initializing)';
      case MockupScenario.permissionDenied:
        return 'Từ chối quyền (Permission Denied)';
      case MockupScenario.noFrontCamera:
        return 'Không có Camera trước (No Front Camera)';
      case MockupScenario.cameraError:
        return 'Lỗi Camera (Camera Error)';
      case MockupScenario.unrecognizedFace:
        return 'Không nhận dạng được (Unrecognized)';
      case MockupScenario.multipleFaces:
        return 'Nhiều khuôn mặt (Multiple Faces)';
    }
  }

  String _getScenarioDescription(MockupScenario scenario) {
    switch (scenario) {
      case MockupScenario.idle:
        return 'Trạng thái ban đầu, chờ nhận diện.';
      case MockupScenario.processing:
        return 'Hiển thị khi đang phân tích khuôn mặt.';
      case MockupScenario.success:
        return 'Hiển thị khi check-in thành công.';
      case MockupScenario.failure:
        return 'Hiển thị khi không nhận diện được.';
      case MockupScenario.connectionLost:
        return 'Biểu tượng wifi màu đỏ, báo mất kết nối.';
      case MockupScenario.debugIdle:
        return 'Trạng thái mặc định với bảng debug mở sẵn.';
      case MockupScenario.initializing:
        return 'Trạng thái tải khi camera đang chuẩn bị.';
      case MockupScenario.permissionDenied:
        return 'Màn hình hiển thị khi quyền camera bị từ chối.';
      case MockupScenario.noFrontCamera:
        return 'Màn hình hiển thị khi không có camera trước.';
      case MockupScenario.cameraError:
        return 'Màn hình hiển thị khi có lỗi camera chung.';
      case MockupScenario.unrecognizedFace:
        return 'Snackbar hiển thị khi không nhận dạng được mặt.';
      case MockupScenario.multipleFaces:
        return 'Snackbar hiển thị khi có nhiều mặt trong khung.';
    }
  }
}

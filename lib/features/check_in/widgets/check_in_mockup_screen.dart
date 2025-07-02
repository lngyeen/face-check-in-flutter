import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:face_check_in_flutter/core/theme/app_colors.dart';
import 'package:face_check_in_flutter/core/utils/ui_helper.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/full_screen_info_widget.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/success_info_dialog.dart';

enum MockupScenario {
  idle,
  processing,
  success,
  failure,
  connectionLost,
  debugIdle,
  initializing,
  permissionDenied,
  noFrontCamera,
  cameraError,
  unrecognizedFace,
  multipleFaces,
}

class CheckInMockupScreen extends StatefulWidget {
  final MockupScenario scenario;
  const CheckInMockupScreen({super.key, this.scenario = MockupScenario.idle});

  @override
  State<CheckInMockupScreen> createState() => _CheckInMockupScreenState();
}

class _CheckInMockupScreenState extends State<CheckInMockupScreen> {
  bool _showDebugInfo = false;
  int _logoTapCount = 0;

  @override
  void initState() {
    super.initState();
    if (widget.scenario == MockupScenario.debugIdle) {
      _showDebugInfo = true;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showNotificationForScenario(widget.scenario);
    });
  }

  @override
  void didUpdateWidget(covariant CheckInMockupScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scenario != oldWidget.scenario) {
      if (widget.scenario == MockupScenario.debugIdle) {
        _showDebugInfo = true;
      } else {
        _showDebugInfo = false;
      }
      _logoTapCount = 0;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        _showNotificationForScenario(widget.scenario);
      });
    }
  }

  void _showNotificationForScenario(MockupScenario scenario) {
    if (!mounted) return;

    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      switch (scenario) {
        case MockupScenario.success:
          _showSuccessDialog();
          break;
        case MockupScenario.failure:
          UIHelper.showAppSnackBar(
            context: context,
            title: 'Check-in Thất Bại',
            message: 'Không nhận diện được khuôn mặt của bạn.',
            type: SnackBarType.error,
          );
          break;
        case MockupScenario.unrecognizedFace:
          UIHelper.showAppSnackBar(
            context: context,
            title: 'Không Nhận Dạng Được',
            message:
                'Đã phát hiện khuôn mặt nhưng không có trong hệ thống. Vui lòng thử lại.',
            type: SnackBarType.warning,
          );
          break;
        case MockupScenario.multipleFaces:
          UIHelper.showAppSnackBar(
            context: context,
            title: 'Nhiều Khuôn Mặt',
            message:
                'Phát hiện nhiều hơn một khuôn mặt. Vui lòng đảm bảo chỉ có một người trong khung hình.',
            type: SnackBarType.info,
          );
          break;
        default:
          // No notifications for other scenarios
          break;
      }
    });
  }

  void _showSuccessDialog() {
    SuccessInfoDialog.show(
      context,
      faceId: 'Lưu Nguyễn',
      imageUrl:
          'https://media.licdn.com/dms/image/D5603AQEUi25n28pWjw/profile-displayphoto-shrink_200_200/0/1690186774903?e=1722470400&v=beta&t=7u7a2e_hZ6-g8gZ6B8Z8Y8Z8Y8Z8Y8Z8Y8Y8Y8Y',
      confidence: 0.983,
      age: 29,
      gender: 'Male',
      mask: false,
      onDialogClosed: () {
        // In a real app, you might trigger a state change here
      },
    );
  }

  void _handleLogoTapInHeader() {
    setState(() {
      _logoTapCount++;
      if (_logoTapCount >= 5) {
        _showDebugInfo = !_showDebugInfo;
        _logoTapCount = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define theme at the top level of the build method
    final theme = Theme.of(context);

    // Handle full-screen scenarios first
    switch (widget.scenario) {
      case MockupScenario.initializing:
        return const FullScreenInfoWidget(
          title: 'Đang Khởi Tạo Camera',
          message: 'Vui lòng chờ trong giây lát...',
          child: CupertinoActivityIndicator(radius: 18),
        );
      case MockupScenario.permissionDenied:
        return FullScreenInfoWidget(
          icon: Icons.no_photography_rounded,
          iconColor: AppColors.error,
          title: 'Yêu Cầu Cấp Quyền',
          message:
              'Ứng dụng cần quyền truy cập camera để thực hiện check-in. Vui lòng cấp quyền trong cài đặt.',
          buttonText: 'Đi đến Cài đặt',
          buttonIcon: Icons.settings_rounded,
          onButtonPressed: () {},
        );
      case MockupScenario.noFrontCamera:
        return const FullScreenInfoWidget(
          icon: Icons.no_photography_outlined,
          iconColor: AppColors.warning,
          title: 'Không Tìm Thấy Camera Trước',
          message: 'Thiết bị này không có camera trước để thực hiện check-in.',
        );
      case MockupScenario.cameraError:
        return FullScreenInfoWidget(
          icon: Icons.error_rounded,
          iconColor: AppColors.error,
          title: 'Lỗi Camera',
          message:
              'Đã có lỗi xảy ra với camera. Vui lòng khởi động lại ứng dụng.',
          buttonText: 'Thử lại',
          buttonIcon: Icons.refresh_rounded,
          onButtonPressed: () {},
        );
      case MockupScenario.connectionLost:
        return FullScreenInfoWidget(
          icon: Icons.wifi_off_rounded,
          iconColor: AppColors.warning,
          title: 'Mất Kết Nối Mạng',
          message:
              'Camera đã tạm dừng để tiết kiệm pin. Vui lòng kiểm tra lại kết nối của bạn.',
          buttonText: 'Thử lại',
          buttonIcon: Icons.refresh_rounded,
          onButtonPressed: () {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            UIHelper.showAppSnackBar(
              context: context,
              title: 'Thông Báo',
              message: 'Đang thử kết nối lại...',
              type: SnackBarType.info,
            );
          },
        );
      default:
        // Continue to the main camera view for other scenarios
        return _buildCameraView(theme);
    }
  }

  Widget _buildCameraView(ThemeData theme) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Camera Preview Placeholder with a person's image
          Image.network(
            'https://st2.depositphotos.com/1011382/7491/i/450/depositphotos_74914105-stock-photo-real-man-face-looking-at.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: AppColors.background,
                child: const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: AppColors.background,
                child: Center(
                  child: Text(
                    'Camera Preview',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              );
            },
          ),

          // Header
          Positioned(top: 0, left: 0, right: 0, child: _buildHeader(theme)),
          if (_showDebugInfo)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildDebugFooter(theme),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 16,
            bottom: 16,
            left: 32,
            right: 32,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface.withAlpha(191),
            border: Border(
              bottom: BorderSide(color: AppColors.border.withAlpha(51)),
            ),
          ),
          child: Center(
            child: GestureDetector(
              onTap: _handleLogoTapInHeader,
              child: Image.asset(
                'assets/images/owt_logo.png',
                height: 36,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDebugFooter(ThemeData theme) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        child: Container(
          padding: EdgeInsets.only(
            top: 16,
            bottom: MediaQuery.of(context).padding.bottom + 16,
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFE4002B).withAlpha(204),
            border: Border(
              top: BorderSide(color: Colors.white.withAlpha(26), width: 1.0),
            ),
          ),
          child: DefaultTextStyle(
            style: theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
            child: SafeArea(
              top: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DEBUG INFO',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: AppColors.info,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Scenario: ${widget.scenario.name}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Time: ${DateFormat('HH:mm:ss.SSS').format(DateTime.now())}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// Toast types for different message variants
enum ToastType { success, failure }

/// Toast widget for displaying temporary notifications
class ToastWidget extends StatefulWidget {
  const ToastWidget({
    super.key,
    required this.message,
    required this.type,
    this.duration = const Duration(seconds: 3),
    this.onDismissed,
  });

  final String message;
  final ToastType type;
  final Duration duration;
  final VoidCallback? onDismissed;

  @override
  State<ToastWidget> createState() => _ToastWidgetState();

  /// Show success toast with personalized message
  static void showSuccess(
    BuildContext context,
    String userName, {
    Duration? duration,
    VoidCallback? onDismissed,
  }) {
    _showToast(
      context,
      ToastWidget(
        message: 'Welcome, $userName!',
        type: ToastType.success,
        duration: duration ?? const Duration(seconds: 3),
        onDismissed: onDismissed,
      ),
    );
  }

  /// Show failure toast with generic error message
  static void showFailure(
    BuildContext context, {
    String? customMessage,
    Duration? duration,
    VoidCallback? onDismissed,
  }) {
    _showToast(
      context,
      ToastWidget(
        message: customMessage ?? 'Recognition Failed. Please try again.',
        type: ToastType.failure,
        duration: duration ?? const Duration(seconds: 3),
        onDismissed: onDismissed,
      ),
    );
  }

  /// Internal method to show toast as overlay
  static void _showToast(BuildContext context, ToastWidget toast) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder:
          (context) => Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            right: 16,
            child: Material(
              color: Colors.transparent,
              child: ToastContainer(
                toast: toast,
                onDismissed: () {
                  entry.remove();
                  toast.onDismissed?.call();
                },
              ),
            ),
          ),
    );

    overlay.insert(entry);
  }
}

class _ToastWidgetState extends State<ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Start animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(_getIcon(), color: Colors.white, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (widget.type) {
      case ToastType.success:
        return const Color(0xFF4CAF50); // Green
      case ToastType.failure:
        return const Color(0xFFFF5722); // Orange/Red
    }
  }

  IconData _getIcon() {
    switch (widget.type) {
      case ToastType.success:
        return Icons.check_circle;
      case ToastType.failure:
        return Icons.error;
    }
  }
}

/// Container widget to handle auto-hide functionality
class ToastContainer extends StatefulWidget {
  const ToastContainer({
    super.key,
    required this.toast,
    required this.onDismissed,
  });

  final ToastWidget toast;
  final VoidCallback onDismissed;

  @override
  State<ToastContainer> createState() => _ToastContainerState();
}

class _ToastContainerState extends State<ToastContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Auto-hide after duration
    Future.delayed(widget.toast.duration, () {
      if (mounted) {
        _animationController.forward().then((_) {
          if (mounted) {
            widget.onDismissed();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _fadeAnimation, child: widget.toast);
  }
}

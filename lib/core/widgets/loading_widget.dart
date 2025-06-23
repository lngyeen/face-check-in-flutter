import 'package:flutter/material.dart';

/// Simple loading widget that displays a centered circular progress indicator
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

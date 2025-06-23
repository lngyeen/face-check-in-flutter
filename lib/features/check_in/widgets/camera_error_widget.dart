import 'package:flutter/material.dart';

class CameraErrorWidget extends StatelessWidget {
  const CameraErrorWidget({super.key, this.error});

  final String? error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Camera Error',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              error ?? 'An unknown camera error occurred.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';

/// Widget for displaying annotated images from backend in V2 implementation
class AnnotatedImagePreviewV2 extends StatelessWidget {
  final String annotatedImage;

  const AnnotatedImagePreviewV2({super.key, required this.annotatedImage});

  @override
  Widget build(BuildContext context) {
    try {
      final decodedImage = base64Decode(annotatedImage);
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Image.memory(
          decodedImage,
          gaplessPlayback: true,
          errorBuilder:
              (context, error, stackTrace) =>
                  const Text('Error loading annotated image'),
        ),
      );
    } catch (e) {
      return const Text('Invalid Base64 Image');
    }
  }
}

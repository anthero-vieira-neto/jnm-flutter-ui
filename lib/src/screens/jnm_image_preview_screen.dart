import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class JNMImagePreviewScreen extends StatelessWidget {
  final String imageUrl;

  const JNMImagePreviewScreen({
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoView(
        imageProvider: NetworkImage(imageUrl),
      ),
    );
  }
}

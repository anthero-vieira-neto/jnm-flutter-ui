import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

class JNMAppLoaderOverlay extends StatelessWidget {
  final String title;
  final Color titleColor;
  final Color progressIndicatorColor;

  const JNMAppLoaderOverlay({
    this.title = 'Memuat...',
    this.titleColor = JNMColors.primary600,
    this.progressIndicatorColor = JNMColors.primary600,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: progressIndicatorColor),
            const SizedBox(height: 20),
            Text(
              title,
              style: JNMFontFamilies.inter(
                fontSize: JNMFontSizes.md,
                fontWeight: JNMFontWeights.medium,
                color: titleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

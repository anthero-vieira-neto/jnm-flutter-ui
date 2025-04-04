import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

class JNMImagePreviewDialog {
  /// Dialog's title.
  final String title;

  /// Dialog content widget.
  final Widget? child;

  /// Image URl.
  final String imageUrl;

  /// Callback on close button.
  final VoidCallback onPressedClose;

  /// Callback on fullscreen button.
  final VoidCallback onPressedFullscreen;

  const JNMImagePreviewDialog({
    required this.title,
    required this.imageUrl,
    required this.onPressedClose,
    required this.onPressedFullscreen,
    this.child,
  });

  Future<void> show(BuildContext context) {
    return JNMUiUtils.showJNMDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: JNMFontFamilies.poppins(
                          fontWeight: JNMFontWeights.semibold,
                          fontSize: JNMFontSizes.lg,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    JNMLinkNeutralButton.iconOnly(
                      iconAssetName: JNMIcons.x_close,
                      onPressed: onPressedClose,
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                if (child != null) ...[
                  child!,
                ],
                Image.network(
                  imageUrl,
                  height: 200.0,
                ),
                const SizedBox(height: 16.0),
                JNMLinkNeutralButton.icon(
                  text: 'Fullscreen',
                  leadingIconAssetName: JNMIcons.maximize_01,
                  trailingIconAssetName: null,
                  onPressed: onPressedFullscreen,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

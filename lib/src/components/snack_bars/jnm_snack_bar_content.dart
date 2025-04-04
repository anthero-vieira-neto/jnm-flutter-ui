import 'package:jnm_ui/jnm_ui.dart';
import 'package:jnm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';

/// JNM UI's SnackBar Content component widget.
class JNMSnackBarContent extends StatelessWidget {
  /// Leading icon asset name.
  final IconData iconAssetName;

  /// Leading icon color.
  final Color iconColor;

  /// The SnackBar content title.
  final String title;

  /// The SnackBar content subtitle.
  final String? subtitle;

  /// The SnackBar positive button text.
  final String? positiveText;

  /// The SnackBar negative button text.
  final String? negativeText;

  /// Callback when pressing positive button.
  final VoidCallback? onPositiveButton;

  /// Callback when pressing negative button.
  final VoidCallback? onNegativeButton;

  /// Callback when pressing close button.
  final VoidCallback onCloseButton;

  const JNMSnackBarContent({
    required this.iconAssetName,
    required this.iconColor,
    required this.title,
    required this.onCloseButton,
    this.subtitle,
    this.positiveText,
    this.negativeText,
    this.onPositiveButton,
    this.onNegativeButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(JNMBorderRadius.md),
          color: JNMColors.white,
          boxShadow: JNMBoxShadow.lg,
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            JNMIcon(
              iconAssetName,
              color: iconColor,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: LibraryTextStyles.interSmSemiboldNeutral,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4.0),
                    Text(
                      subtitle!,
                      style: LibraryTextStyles.interSmRegularNeutral400,
                    ),
                  ],
                  if (negativeText != null || positiveText != null) ...[
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        if (negativeText != null)
                          Flexible(
                            child: JNMLinkNeutralButton.text(
                              height: JNMButtonHeights.sm,
                              text: negativeText!,
                              onPressed: onNegativeButton,
                            ),
                          ),
                        if (positiveText != null) ...[
                          const SizedBox(width: 12.0),
                          Flexible(
                            child: JNMLinkPrimaryButton.text(
                              height: JNMButtonHeights.sm,
                              text: positiveText!,
                              onPressed: onPositiveButton,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            JNMLinkNeutralButton.iconOnly(
              iconAssetName: JNMIcons.x_close,
              onPressed: onCloseButton,
            ),
          ],
        ),
      ),
    );
  }
}

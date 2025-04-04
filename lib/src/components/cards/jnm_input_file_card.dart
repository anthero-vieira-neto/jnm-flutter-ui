// ignore_for_file: deprecated_member_use_from_same_package

import 'package:jnm_ui/jnm_ui.dart';
import 'package:jnm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';

/// Card for selecting file to be uploaded.
class JNMInputFileCard extends StatelessWidget {
  /// Callback when card is tapped. Set this to null to disable the card.
  final VoidCallback? onTap;

  /// Card's 'Click to upload' label.
  final String clickToUploadLabel;

  /// Card's ' or drag and drop' label.
  final String orDragAndDropLabel;

  /// Card's subtitle.
  final String subtitle;

  /// Text color
  final Color textColor;

  const JNMInputFileCard({
    super.key,
    this.onTap,
    this.clickToUploadLabel = 'Click to upload',
    this.orDragAndDropLabel = ' or drag and drop',
    this.subtitle = 'SVG, PNG, JPG or GIF (max. 800x400px)',
    this.textColor = JNMColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: JNMColors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: JNMColors.neutral50),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                JNMBorderRadius.md,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0,
          ),
          child: Column(
            children: [
              const JNMIconRipple(
                backgroundColor: JNMColors.neutral50,
                iconAssetName: JNMIcons.upload_cloud_02,
                iconColor: JNMColors.neutral300,
                rippleColor: JNMColors.neutral25,
              ),
              const SizedBox(height: 12.0),
              RichText(
                text: TextSpan(
                  text: clickToUploadLabel,
                  style: JNMFontFamilies.inter(
                    fontSize: JNMFontSizes.sm,
                    fontWeight: JNMFontWeights.semibold,
                    color: onTap != null ? textColor : JNMColors.neutral100,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: orDragAndDropLabel,
                      style: LibraryTextStyles.interSmRegularNeutral400,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                subtitle,
                style: LibraryTextStyles.interSmRegularNeutral400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

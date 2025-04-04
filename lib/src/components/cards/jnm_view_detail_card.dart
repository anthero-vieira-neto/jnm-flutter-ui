import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

enum JNMViewDetailCardVariant {
  white,
  primary,
  secondary,
}

class JNMViewDetailCard extends StatelessWidget {
  final IconData leadingIconAssetName;
  final String title;
  final JNMViewDetailCardVariant variant;
  final IconData trailingIconAssetName;
  final Function(BuildContext context) onTap;
  final double leadingIconSize;
  final double trailingIconSize;

  const JNMViewDetailCard({
    required this.leadingIconAssetName,
    required this.title,
    required this.onTap,
    this.variant = JNMViewDetailCardVariant.white,
    this.trailingIconAssetName = JNMIcons.arrow_right,
    this.leadingIconSize = 16.0,
    this.trailingIconSize = 16.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late Color backgroundColor;
    late Color borderColor;
    late Color leadingIconColor;
    late Color textColor;
    late Color trailingIconColor;
    switch (variant) {
      case JNMViewDetailCardVariant.white:
        backgroundColor = JNMColors.white;
        borderColor = JNMColors.neutral100;
        leadingIconColor = JNMColors.neutral300;
        textColor = JNMColors.neutral400;
        trailingIconColor = JNMColors.primary;
        break;
      case JNMViewDetailCardVariant.primary:
        backgroundColor = JNMColors.primary600;
        borderColor = JNMColors.primary600;
        leadingIconColor = JNMColors.primary200;
        textColor = JNMColors.primary100;
        trailingIconColor = JNMColors.primary100;
        break;
      case JNMViewDetailCardVariant.secondary:
        backgroundColor = JNMColors.primary100;
        borderColor = JNMColors.primary200;
        leadingIconColor = JNMColors.primary;
        textColor = JNMColors.neutral400;
        trailingIconColor = JNMColors.primary;
        break;
    }

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(JNMBorderRadius.sm),
      child: InkWell(
        borderRadius: BorderRadius.circular(JNMBorderRadius.sm),
        onTap: () {
          onTap(context);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(JNMBorderRadius.sm),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              JNMIcon(
                leadingIconAssetName,
                color: leadingIconColor,
                size: leadingIconSize,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  title,
                  style: JNMFontFamilies.inter(
                    fontSize: JNMFontSizes.sm,
                    fontWeight: JNMFontWeights.medium,
                    color: textColor,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              JNMIcon(
                trailingIconAssetName,
                color: trailingIconColor,
                size: trailingIconSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

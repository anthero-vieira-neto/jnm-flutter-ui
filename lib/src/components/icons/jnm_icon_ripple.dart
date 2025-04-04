// ignore_for_file: deprecated_member_use_from_same_package

import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

/// [JNMIconRipple] variant.
enum JNMIconRippleVariant {
  defaultV,
  primary,
  success,
  warning,
  danger,
}

/// [JNMIcon] with ripple background border
class JNMIconRipple extends StatelessWidget {
  /// Color of background
  final Color? backgroundColor;

  /// Color of background border
  final Color? rippleColor;

  /// Filename of icon's asset
  final IconData iconAssetName;

  /// Color of icon
  final Color? iconColor;

  /// Height of container
  final double height;

  /// Width of container
  final double width;

  /// Width of background border
  final double rippleSize;

  /// Widget variant.
  final JNMIconRippleVariant? variant;

  const JNMIconRipple({
    required this.iconAssetName,
    @Deprecated('Use variant instead if possible.') this.backgroundColor,
    @Deprecated('Use variant instead if possible.') this.rippleColor,
    @Deprecated('Use variant instead if possible.') this.iconColor,
    this.height = 48,
    this.width = 48,
    this.rippleSize = 8,
    this.variant,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late Color finalRippleColor;
    late Color finalBackgroundColor;
    late Color finalIconColor;
    if (variant == null) {
      finalRippleColor = rippleColor!;
      finalBackgroundColor = backgroundColor!;
      finalIconColor = iconColor!;
    } else {
      switch (variant!) {
        case JNMIconRippleVariant.defaultV:
          finalRippleColor = JNMColors.neutral50;
          finalBackgroundColor = JNMColors.neutral100;
          finalIconColor = JNMColors.neutral;
          break;
        case JNMIconRippleVariant.primary:
          finalRippleColor = JNMColors.primary100;
          finalBackgroundColor = JNMColors.primary200;
          finalIconColor = JNMColors.primary;
          break;
        case JNMIconRippleVariant.success:
          finalRippleColor = JNMColors.success100;
          finalBackgroundColor = JNMColors.success200;
          finalIconColor = JNMColors.success;
          break;
        case JNMIconRippleVariant.warning:
          finalRippleColor = JNMColors.warning100;
          finalBackgroundColor = JNMColors.warning200;
          finalIconColor = JNMColors.warning600;
          break;
        case JNMIconRippleVariant.danger:
          finalRippleColor = JNMColors.danger100;
          finalBackgroundColor = JNMColors.danger200;
          finalIconColor = JNMColors.danger;
          break;
      }
    }

    return Center(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: finalBackgroundColor,
          border: Border.all(
            width: rippleSize,
            color: finalRippleColor,
          ),
        ),
        child: JNMIcon(
          iconAssetName,
          color: finalIconColor,
        ),
      ),
    );
  }
}

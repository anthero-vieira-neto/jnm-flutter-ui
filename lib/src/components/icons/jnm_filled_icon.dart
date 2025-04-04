import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

enum JNMFilledIconVariant {
  defaultV,
  primary,
  info,
  success,
  warning,
  danger,
}

class JNMFilledIcon extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final JNMFilledIconVariant variant;
  final EdgeInsetsGeometry padding;
  final BoxFit fit;

  const JNMFilledIcon({
    required this.icon,
    this.iconSize = 20.0,
    this.variant = JNMFilledIconVariant.defaultV,
    this.padding = const EdgeInsets.all(12.0),
    this.fit = BoxFit.scaleDown,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color iconColor = _getIconColor(variant);
    Color containerColor = _getContainerColor(variant);
    return FittedBox(
      fit: fit,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: containerColor,
        ),
        child: Padding(
          padding: padding,
          child: JNMIcon(
            icon,
            size: iconSize,
            color: iconColor,
          ),
        ),
      ),
    );
  }

  Color _getIconColor(JNMFilledIconVariant variant) {
    switch (variant) {
      case JNMFilledIconVariant.defaultV:
        return JNMColors.neutral;
      case JNMFilledIconVariant.primary:
        return JNMColors.primary;
      case JNMFilledIconVariant.info:
        return JNMColors.info;
      case JNMFilledIconVariant.success:
        return JNMColors.success;
      case JNMFilledIconVariant.warning:
        return JNMColors.warning600;
      case JNMFilledIconVariant.danger:
        return JNMColors.danger;
    }
  }

  Color _getContainerColor(JNMFilledIconVariant variant) {
    switch (variant) {
      case JNMFilledIconVariant.defaultV:
        return JNMColors.neutral50;
      case JNMFilledIconVariant.primary:
        return JNMColors.primary100;
      case JNMFilledIconVariant.info:
        return JNMColors.info100;
      case JNMFilledIconVariant.success:
        return JNMColors.success100;
      case JNMFilledIconVariant.warning:
        return JNMColors.warning100;
      case JNMFilledIconVariant.danger:
        return JNMColors.danger100;
    }
  }
}

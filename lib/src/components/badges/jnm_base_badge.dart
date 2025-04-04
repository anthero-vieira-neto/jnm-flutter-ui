import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

/// Base widget for badge widget.
class JNMBaseBadge extends StatelessWidget {
  /// The badge content.
  final Widget child;

  /// The container content padding.
  final EdgeInsetsGeometry contentPadding;

  /// Container border radius.
  final double borderRadius;

  /// The container background color.
  final Color? backgroundColor;

  /// The container border.
  final Border? border;

  /// Callback when the badge is tapped.
  final VoidCallback? onTap;

  const JNMBaseBadge({
    required this.child,
    required this.contentPadding,
    this.borderRadius = JNMBorderRadius.lg,
    this.backgroundColor,
    this.border,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            padding: contentPadding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: border,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

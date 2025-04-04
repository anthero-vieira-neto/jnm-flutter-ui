import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

class JNMPrimaryCard extends StatelessWidget {
  /// The card's contet padding.
  final EdgeInsetsGeometry? padding;

  /// Card content widget.
  final Widget child;

  const JNMPrimaryCard({
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: JNMColors.primary100,
        borderRadius: BorderRadius.circular(JNMBorderRadius.sm),
      ),
      padding: padding,
      child: child,
    );
  }
}

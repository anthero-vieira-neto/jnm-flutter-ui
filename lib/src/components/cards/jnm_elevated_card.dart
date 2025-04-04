import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

class JNMElevatedCard extends StatelessWidget {
  /// The card's contet padding.
  final EdgeInsetsGeometry? padding;

  /// Card content widget.
  final Widget child;

  const JNMElevatedCard({
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: JNMColors.neutral50,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(JNMBorderRadius.sm),
        boxShadow: JNMBoxShadow.sm,
      ),
      padding: padding,
      child: child,
    );
  }
}

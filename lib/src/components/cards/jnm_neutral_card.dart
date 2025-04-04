import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

class JNMNeutralCard extends StatelessWidget {
  /// The card's contet padding.
  final EdgeInsetsGeometry? padding;

  /// Card content widget.
  final Widget child;

  const JNMNeutralCard({
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: JNMColors.neutral100,
          width: 1,
        ),
        color: JNMColors.neutral50,
        borderRadius: BorderRadius.circular(JNMBorderRadius.md),
      ),
      padding: padding,
      child: child,
    );
  }
}

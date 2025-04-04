import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

class JNMOutlinedCard extends StatelessWidget {
  /// The card's contet padding.
  final EdgeInsetsGeometry? padding;

  /// Card content widget.
  final Widget child;

  const JNMOutlinedCard({
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
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(JNMBorderRadius.sm),
        boxShadow: JNMBoxShadow.xs,
      ),
      padding: padding,
      child: child,
    );
  }
}

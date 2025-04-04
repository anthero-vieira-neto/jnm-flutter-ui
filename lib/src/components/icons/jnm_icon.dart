import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

/// App's standardized icon widget.
class JNMIcon extends Icon {
  /// Constructor fot JNM icons.
  const JNMIcon(
    super.icon, {
    Key? key,
    double? size = 20.0,
    double? fill,
    double? weight,
    double? grade,
    double? opticalSize,
    // ignore: deprecated_member_use_from_same_package
    Color? color = JNMColors.grey700,
    List<Shadow>? shadows,
    String? semanticLabel,
    TextDirection? textDirection,
  }) : super(
          key: key,
          size: size,
          fill: fill,
          weight: weight,
          grade: grade,
          opticalSize: opticalSize,
          color: color,
          shadows: shadows,
          semanticLabel: semanticLabel,
          textDirection: textDirection,
        );
}

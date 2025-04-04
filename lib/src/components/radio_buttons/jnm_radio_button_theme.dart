import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/widgets.dart';

/// Used with [JNMRadioButtonTheme] or can be passed directly to
/// button widget parameter to configure the color of buttons.
class JNMRadioButtonThemeData {
  final Color titleColor;
  final Color subtitleColor;
  final Color hoverColor;
  final Color focusColor;
  final Color primaryColor;
  final Color backgroundColor;
  final Color backgroundActiveColor;
  final Color backgroundDisabledColor;
  final Color borderColor;
  final Color borderActiveColor;
  final Color borderFocusedColor;
  final Color borderDisabledColor;

  const JNMRadioButtonThemeData({
    this.titleColor = JNMColors.neutral,
    this.subtitleColor = JNMColors.neutral300,
    this.hoverColor = JNMColors.primary100,
    this.focusColor = JNMColors.white,
    this.primaryColor = JNMColors.primary,
    this.backgroundColor = JNMColors.white,
    this.backgroundActiveColor = JNMColors.primary100,
    this.backgroundDisabledColor = JNMColors.neutral100,
    this.borderColor = JNMColors.neutral200,
    this.borderActiveColor = JNMColors.primary,
    this.borderFocusedColor = JNMColors.primary300,
    this.borderDisabledColor = JNMColors.neutral200,
  });
}

/// Used with [JNMRadioButtonThemeData] to configure the color of buttons.
/// This widget will provide its predecessor's [JNMRadioButtonThemeData] and
/// every button in the predecessor tree will be configured with its theme data.
class JNMRadioButtonTheme extends InheritedWidget {
  final JNMRadioButtonThemeData? data;

  const JNMRadioButtonTheme({
    required Widget child,
    super.key,
    this.data,
  }) : super(child: child);

  static JNMRadioButtonTheme? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<JNMRadioButtonTheme>();
  }

  @override
  bool updateShouldNotify(JNMRadioButtonTheme oldWidget) {
    return true;
  }
}

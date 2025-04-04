import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/widgets.dart';

/// Used with [JNMCheckboxTheme] or can be passed directly to
/// button widget parameter to configure the color of buttons.
class JNMCheckboxThemeData {
  final Color borderColor;
  final Color borderCheckedColor;
  final Color borderDisabledColor;
  final Color borderFocusedColor;

  final Color backgroundColor;
  final Color backgroundCheckedColor;
  final Color backgroundDisabledColor;

  final Color iconEnabledColor;
  final Color iconDisabledColor;

  const JNMCheckboxThemeData({
    this.borderColor = JNMColors.neutral200,
    this.borderCheckedColor = JNMColors.primary,
    this.borderDisabledColor = JNMColors.neutral200,
    this.borderFocusedColor = JNMColors.primary300,
    this.backgroundColor = JNMColors.white,
    this.backgroundCheckedColor = JNMColors.primary100,
    this.backgroundDisabledColor = JNMColors.neutral100,
    this.iconEnabledColor = JNMColors.primary,
    this.iconDisabledColor = JNMColors.neutral200,
  });
}

/// Used with [JNMCheckboxThemeData] to configure the color of buttons.
/// This widget will provide its predecessor's [JNMCheckboxThemeData] and
/// every button in the predecessor tree will be configured with its theme data.
class JNMCheckboxTheme extends InheritedWidget {
  final JNMCheckboxThemeData? checkboxThemeData;

  const JNMCheckboxTheme({
    required Widget child,
    super.key,
    this.checkboxThemeData,
  }) : super(child: child);

  static JNMCheckboxTheme? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<JNMCheckboxTheme>();
  }

  @override
  bool updateShouldNotify(JNMCheckboxTheme oldWidget) {
    return true;
  }
}

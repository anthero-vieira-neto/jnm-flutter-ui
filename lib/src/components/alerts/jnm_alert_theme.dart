import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/widgets.dart';

/// Used with [JNMAlertTheme] or can be passed directly to
/// [JNMAlert] widget parameter to configure the theme of the widget.
class JNMAlertThemeData {
  final Color iconColor;
  final Color backgroundColor;
  final Color borderColor;
  final Color titleTextColor;
  final Color subtitleTextColor;
  final Color closeIconColor;
  final JNMLinkButtonThemeData secondaryButtonTheme;
  final JNMLinkButtonThemeData primaryButtonTheme;

  const JNMAlertThemeData({
    this.iconColor = JNMColors.primary600,
    this.backgroundColor = JNMColors.primary100,
    this.borderColor = JNMColors.primary200,
    this.titleTextColor = JNMColors.primary,
    this.subtitleTextColor = JNMColors.primary,
    this.closeIconColor = JNMColors.primary400,
    this.secondaryButtonTheme = const JNMLinkButtonThemeData(
      onPrimaryColor: JNMColors.primary400,
    ),
    this.primaryButtonTheme = const JNMLinkButtonThemeData(),
  });
}

/// Used with [JNMAlertThemeData] to configure the theme of [JNMAlert].
/// This widget will provide its predecessor's [JNMAlertThemeData] and
/// every alert in the predecessor tree will be configured with its theme data.
class JNMAlertTheme extends InheritedWidget {
  final JNMAlertThemeData? alertThemeData;

  const JNMAlertTheme({
    required Widget child,
    this.alertThemeData,
    super.key,
  }) : super(child: child);

  static JNMAlertTheme? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<JNMAlertTheme>();
  }

  @override
  bool updateShouldNotify(JNMAlertTheme oldWidget) {
    return true;
  }
}

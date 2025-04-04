import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

/// Used with [JNMButtonTheme] or can be passed directly to
/// button widget parameter to configure the color of buttons.
class JNMButtonThemeData {
  final Color shadowColor;
  final Color primaryColor;
  final Color disabledColor;
  final Color hoverColor;
  final Color focusColor;

  const JNMButtonThemeData({
    required this.shadowColor,
    required this.primaryColor,
    required this.disabledColor,
    required this.hoverColor,
    required this.focusColor,
  });
}

/// Used with [JNMPrimaryButton] to configure colors.
class JNMPrimaryButtonThemeData extends JNMButtonThemeData {
  const JNMPrimaryButtonThemeData({
    Color shadowColor = const Color(0xFFF4EBFF),
    Color primaryColor = JNMColors.primary,
    Color disabledColor = JNMColors.primary200,
    Color hoverColor = JNMColors.primary600,
    Color focusColor = JNMColors.primary,
  }) : super(
          shadowColor: shadowColor,
          primaryColor: primaryColor,
          disabledColor: disabledColor,
          hoverColor: hoverColor,
          focusColor: focusColor,
        );
}

/// Used with [JNMSecondaryButton] to configure colors.
class JNMSecondaryButtonThemeData extends JNMButtonThemeData {
  final Color onSecondaryColor;
  final Color onSecondaryVariantColor;
  final Color onHoverColor;

  const JNMSecondaryButtonThemeData({
    this.onSecondaryColor = JNMColors.primary,
    this.onSecondaryVariantColor = JNMColors.primary300,
    this.onHoverColor = JNMColors.primary800,
    Color shadowColor = const Color(0xFFF4EBFF),
    Color primaryColor = JNMColors.primary100,
    Color disabledColor = JNMColors.primary100,
    Color hoverColor = JNMColors.primary100,
    Color focusColor = JNMColors.primary100,
  }) : super(
          shadowColor: shadowColor,
          primaryColor: primaryColor,
          disabledColor: disabledColor,
          hoverColor: hoverColor,
          focusColor: focusColor,
        );
}

/// Used with [JNMOutlineButton] to configure colors.
class JNMOutlineButtonThemeData extends JNMButtonThemeData {
  final Color onSurfaceColor;
  final Color onSurfaceVariantColor;
  final Color borderColor;

  const JNMOutlineButtonThemeData({
    this.onSurfaceColor = JNMColors.neutral,
    this.onSurfaceVariantColor = JNMColors.neutral100,
    this.borderColor = JNMColors.neutral100,
    Color shadowColor = const Color(0xFFF2F4F7),
    Color primaryColor = JNMColors.white,
    Color disabledColor = JNMColors.white,
    Color hoverColor = JNMColors.neutral100,
    Color focusColor = JNMColors.white,
  }) : super(
          shadowColor: shadowColor,
          primaryColor: primaryColor,
          disabledColor: disabledColor,
          hoverColor: hoverColor,
          focusColor: focusColor,
        );
}

/// Used with [JNMLinkPrimaryButton] to configure colors.
class JNMLinkButtonThemeData extends JNMButtonThemeData {
  final Color onPrimaryColor;
  final Color onPrimaryVariantColor;

  const JNMLinkButtonThemeData({
    this.onPrimaryColor = JNMColors.primary,
    this.onPrimaryVariantColor = JNMColors.neutral100,
    Color shadowColor = const Color(0xFFF2F4F7),
    Color primaryColor = Colors.transparent,
    Color disabledColor = Colors.transparent,
    Color hoverColor = Colors.transparent,
    Color focusColor = Colors.transparent,
  }) : super(
          shadowColor: shadowColor,
          primaryColor: primaryColor,
          disabledColor: disabledColor,
          hoverColor: hoverColor,
          focusColor: focusColor,
        );

  factory JNMLinkButtonThemeData.neutral() {
    return const JNMLinkButtonThemeData(
      onPrimaryColor: JNMColors.neutral400,
    );
  }
}

/// Used with [JNMTertiaryPrimaryButton] to configure colors.
class JNMTertiaryButtonThemeData extends JNMButtonThemeData {
  final Color onPrimaryColor;
  final Color onPrimaryVariantColor;

  const JNMTertiaryButtonThemeData({
    this.onPrimaryColor = JNMColors.primary,
    this.onPrimaryVariantColor = JNMColors.neutral100,
    Color shadowColor = const Color(0xFFF2F4F7),
    Color primaryColor = JNMColors.primary100,
    Color disabledColor = Colors.transparent,
    Color hoverColor = JNMColors.primary100,
    Color focusColor = Colors.transparent,
  }) : super(
          shadowColor: shadowColor,
          primaryColor: primaryColor,
          disabledColor: disabledColor,
          hoverColor: hoverColor,
          focusColor: focusColor,
        );

  factory JNMTertiaryButtonThemeData.neutral() {
    return const JNMTertiaryButtonThemeData(
      onPrimaryColor: JNMColors.neutral400,
      primaryColor: JNMColors.neutral100,
    );
  }
}

/// Used with [ButtonThemeData] to configure the color of buttons.
/// This widget will provide its predecessor's [JNMButtonThemeData] and
/// every button in the predecessor tree will be configured with its theme data.
class JNMButtonTheme extends InheritedWidget {
  const JNMButtonTheme({
    required Widget child,
    super.key,
    this.primaryButtonThemeData,
    this.secondaryButtonThemeData,
    this.outlineButtonThemeData,
    this.linkButtonThemeData,
    this.tertiaryPrimaryButtonThemeData,
  }) : super(child: child);

  final JNMPrimaryButtonThemeData? primaryButtonThemeData;
  final JNMSecondaryButtonThemeData? secondaryButtonThemeData;
  final JNMOutlineButtonThemeData? outlineButtonThemeData;
  final JNMLinkButtonThemeData? linkButtonThemeData;
  final JNMTertiaryButtonThemeData? tertiaryPrimaryButtonThemeData;

  static JNMButtonTheme? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<JNMButtonTheme>();
  }

  @override
  bool updateShouldNotify(JNMButtonTheme oldWidget) {
    return oldWidget != this;
  }
}

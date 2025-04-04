import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

class JNMThemeData {
  static ThemeData light() {
    return ThemeData(
      primaryColor: JNMColors.primary,
      colorScheme: const ColorScheme.light(
        primary: JNMColors.primary,
        secondary: JNMColors.success,
      ),
      scaffoldBackgroundColor: JNMColors.neutral25,
      dividerTheme: const DividerThemeData(
        color: JNMColors.neutral50,
      ),
      dialogTheme: const DialogTheme(
        backgroundColor: JNMColors.white,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: const CardTheme(
        surfaceTintColor: Colors.transparent,
      ),
      popupMenuTheme: const PopupMenuThemeData(
        surfaceTintColor: Colors.transparent,
      ),
      useMaterial3: false,
    );
  }
}

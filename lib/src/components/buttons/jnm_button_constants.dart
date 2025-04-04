import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

/// Possible height values for buttons.
class JNMButtonHeights {
  /// Small (SM) button height.
  static const sm = 36.0;

  /// Medium (MD) button height.
  static const md = 40.0;

  /// Large (LG) button height.
  static const lg = 44.0;

  /// Extra Large (XL) button height.
  static const xl = 48.0;

  /// Extra Large 2 (2XL) button height.
  static const xl2 = 60.0;
}

/// Possible text font size for buttons.
class JNMButtonTextFontSize {
  /// Small (SM) button text font size.
  static const sm = JNMFontSizes.sm;

  /// Medium (MD) button text font size.
  static const md = JNMFontSizes.sm;

  /// Large (LG) button text font size.
  static const lg = JNMFontSizes.md;

  /// Extra Large (XL) button text font size.
  static const xl = JNMFontSizes.md;

  /// Extra Large 2 (2XL) button text font size.
  static const xl2 = JNMFontSizes.lg;

  /// Get [JNMButtonTextFontSize] value from [JNMButtonHeights].
  static double fromButtonHeights(double buttonHeights) {
    if (buttonHeights <= JNMButtonHeights.sm) {
      return sm;
    } else if (buttonHeights <= JNMButtonHeights.md) {
      return md;
    } else if (buttonHeights <= JNMButtonHeights.lg) {
      return lg;
    } else if (buttonHeights <= JNMButtonHeights.xl) {
      return xl;
    } else {
      return xl2;
    }
  }
}

/// Possible content padding for buttons.
class JNMButtonPadding {
  /// Small (SM) button content padding.
  static const sm = EdgeInsets.symmetric(
    vertical: 8.0,
    horizontal: 14.0,
  );

  /// Medium (MD) button content padding.
  static const md = EdgeInsets.symmetric(
    vertical: 10.0,
    horizontal: 16.0,
  );

  /// Large (LG) button content padding.
  static const lg = EdgeInsets.symmetric(
    vertical: 10.0,
    horizontal: 18.0,
  );

  /// Extra Large (XL) button content padding.
  static const xl = EdgeInsets.symmetric(
    vertical: 12.0,
    horizontal: 20.0,
  );

  /// Extra Large 2 (2XL) button content padding.
  static const xl2 = EdgeInsets.symmetric(
    vertical: 16.0,
    horizontal: 28.0,
  );

  /// Get [JNMButtonPadding] value from [JNMButtonHeights].
  static EdgeInsetsGeometry fromButtonHeights(double buttonHeights) {
    if (buttonHeights <= JNMButtonHeights.sm) {
      return sm;
    } else if (buttonHeights <= JNMButtonHeights.md) {
      return md;
    } else if (buttonHeights <= JNMButtonHeights.lg) {
      return lg;
    } else if (buttonHeights <= JNMButtonHeights.xl) {
      return xl;
    } else {
      return xl2;
    }
  }
}

/// Possible content padding for icon-only buttons.
class JNMButtonIconOnlyPadding {
  /// Small (SM) icon-only button content padding.
  static const sm = EdgeInsets.all(8.0);

  /// Medium (MD) icon-only button content padding.
  static const md = EdgeInsets.all(10.0);

  /// Large (LG) icon-only button content padding.
  static const lg = EdgeInsets.all(12.0);

  /// Extra Large (XL) icon-only button content padding.
  static const xl = EdgeInsets.all(14.0);

  /// Extra Large 2 (2XL) icon-only button content padding.
  static const xl2 = EdgeInsets.all(16.0);

  /// Get [JNMButtonIconOnlyPadding] value from [JNMButtonHeights].
  static EdgeInsetsGeometry fromButtonHeights(double buttonHeights) {
    if (buttonHeights <= JNMButtonHeights.sm) {
      return sm;
    } else if (buttonHeights <= JNMButtonHeights.md) {
      return md;
    } else if (buttonHeights <= JNMButtonHeights.lg) {
      return lg;
    } else if (buttonHeights <= JNMButtonHeights.xl) {
      return xl;
    } else {
      return xl2;
    }
  }
}

/// Possible icon size for buttons.
class JNMButtonIconSize {
  /// Get [JNMButtonIconSize] value from [JNMButtonHeights].
  static double fromButtonHeights(double buttonHeights) {
    if (buttonHeights <= JNMButtonHeights.xl) {
      return 20.0;
    } else {
      return 24.0;
    }
  }
}

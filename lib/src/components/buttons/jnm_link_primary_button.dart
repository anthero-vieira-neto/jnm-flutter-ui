import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

/// JNM UI's Link Primary Button component widget.
class JNMLinkPrimaryButton extends StatefulWidget {
  /// The button's height. Use [JNMButtonHeights] whenever possible.
  final double height;

  /// The button's child builder.
  final Widget Function(BuildContext context, bool isFocused, bool isHovered)
      builder;

  /// Callback when button is pressed. Set this value to null to disable the
  /// button.
  final VoidCallback? onPressed;

  /// The button's contet padding.
  final EdgeInsetsGeometry? contentPadding;

  /// Theme data for button styling
  final JNMLinkButtonThemeData? buttonThemeData;

  const JNMLinkPrimaryButton({
    required this.builder,
    required this.onPressed,
    this.height = JNMButtonHeights.md,
    this.contentPadding,
    this.buttonThemeData,
    super.key,
  });

  @override
  State<JNMLinkPrimaryButton> createState() =>
      _JNMLinkPrimaryButtonState();

  /// Creates [JNMLinkPrimaryButton] with only text as content.
  factory JNMLinkPrimaryButton.text({
    required String text,
    double height = JNMButtonHeights.md,
    VoidCallback? onPressed,
    JNMLinkButtonThemeData? buttonThemeData,
    Key? key,
  }) {
    return JNMLinkPrimaryButton(
      key: key,
      height: height,
      onPressed: onPressed,
      buttonThemeData: buttonThemeData,
      builder: (context, isFocused, isHovered) {
        // ignore: no_leading_underscores_for_local_identifiers
        final _buttonThemeData = buttonThemeData ??
            JNMButtonTheme.of(context)?.linkButtonThemeData ??
            const JNMLinkButtonThemeData();

        Color textColor;
        if (!isHovered) {
          textColor = onPressed != null
              ? _buttonThemeData.onPrimaryColor
              : _buttonThemeData.onPrimaryVariantColor;
        } else {
          textColor = JNMColors.primary800;
        }
        return Text(
          text,
          textAlign: TextAlign.center,
          style: JNMFontFamilies.inter(
            color: textColor,
            fontSize:
                JNMLinkPrimaryButton.getFontSizeFromButtonHeight(height),
            fontWeight: JNMFontWeights.semibold,
          ),
        );
      },
    );
  }

  /// Creates [JNMLinkPrimaryButton] with text and icon(s) (leading and/or trailing)
  /// as content.
  factory JNMLinkPrimaryButton.icon({
    required String text,
    required IconData? leadingIconAssetName,
    required IconData? trailingIconAssetName,
    double height = JNMButtonHeights.md,
    VoidCallback? onPressed,
    JNMLinkButtonThemeData? buttonThemeData =
        const JNMLinkButtonThemeData(),
    Key? key,
  }) {
    return JNMLinkPrimaryButton(
      key: key,
      height: height,
      onPressed: onPressed,
      buttonThemeData: buttonThemeData,
      builder: (context, isFocused, isHovered) {
        // ignore: no_leading_underscores_for_local_identifiers
        final _buttonThemeData = buttonThemeData ??
            JNMButtonTheme.of(context)?.linkButtonThemeData ??
            const JNMLinkButtonThemeData();
        Color textColor;
        if (!isHovered) {
          textColor = onPressed != null
              ? _buttonThemeData.onPrimaryColor
              : _buttonThemeData.onPrimaryVariantColor;
        } else {
          textColor = JNMColors.primary800;
        }
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leadingIconAssetName != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      JNMIcon(
                        leadingIconAssetName,
                        color: textColor,
                        size: JNMButtonIconSize.fromButtonHeights(height),
                      ),
                      const SizedBox(width: 8.0),
                    ],
                  )
                : Container(),
            Text(
              text,
              textAlign: TextAlign.center,
              style: JNMFontFamilies.inter(
                color: textColor,
                fontSize: JNMLinkPrimaryButton.getFontSizeFromButtonHeight(
                  height,
                ),
                fontWeight: JNMFontWeights.semibold,
              ),
            ),
            trailingIconAssetName != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 8.0),
                      JNMIcon(
                        trailingIconAssetName,
                        color: textColor,
                        size: JNMButtonIconSize.fromButtonHeights(height),
                      ),
                    ],
                  )
                : Container(),
          ],
        );
      },
    );
  }

  /// Creates [JNMLinkPrimaryButton] with only an icon as content.
  factory JNMLinkPrimaryButton.iconOnly({
    required IconData iconAssetName,
    double height = JNMButtonHeights.md,
    VoidCallback? onPressed,
    JNMLinkButtonThemeData? buttonThemeData =
        const JNMLinkButtonThemeData(),
    Key? key,
  }) {
    return JNMLinkPrimaryButton(
      key: key,
      height: height,
      onPressed: onPressed,
      contentPadding: JNMButtonIconOnlyPadding.fromButtonHeights(height),
      buttonThemeData: buttonThemeData,
      builder: (context, isFocused, isHovered) {
        // ignore: no_leading_underscores_for_local_identifiers
        final _buttonThemeData = buttonThemeData ??
            JNMButtonTheme.of(context)?.linkButtonThemeData ??
            const JNMLinkButtonThemeData();
        Color textColor;
        if (!isHovered) {
          textColor = onPressed != null
              ? _buttonThemeData.onPrimaryColor
              : _buttonThemeData.onPrimaryVariantColor;
        } else {
          textColor = JNMColors.primary800;
        }
        return JNMIcon(
          iconAssetName,
          color: textColor,
          size: JNMButtonIconSize.fromButtonHeights(height),
        );
      },
    );
  }

  static double getFontSizeFromButtonHeight(double height) {
    double fontSize;
    if (height <= JNMButtonHeights.sm) {
      fontSize = JNMFontSizes.sm;
    } else if (height <= JNMButtonHeights.md) {
      fontSize = JNMFontSizes.sm;
    } else if (height <= JNMButtonHeights.lg) {
      fontSize = JNMFontSizes.md;
    } else if (height <= JNMButtonHeights.xl) {
      fontSize = JNMFontSizes.md;
    } else {
      fontSize = JNMFontSizes.lg;
    }
    return fontSize;
  }
}

class _JNMLinkPrimaryButtonState extends State<JNMLinkPrimaryButton> {
  /// Whether currently the button is focused.
  bool _isFocused = false;

  /// Whether currently the button is hovered.
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    JNMLinkButtonThemeData buttonThemeData = widget.buttonThemeData ??
        JNMButtonTheme.of(context)?.linkButtonThemeData ??
        const JNMLinkButtonThemeData();

    late Color primaryColor;
    late Color disabledColor;
    late Color hoverColor;
    late Color focusColor;
    primaryColor = buttonThemeData.primaryColor;
    disabledColor = buttonThemeData.disabledColor;
    hoverColor = buttonThemeData.hoverColor;
    focusColor = buttonThemeData.focusColor;
    return Material(
      color: widget.onPressed != null ? primaryColor : disabledColor,
      borderRadius: BorderRadius.circular(
        JNMBorderRadius.sm,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(
          JNMBorderRadius.sm,
        ),
        onFocusChange: (value) {
          setState(() {
            _isFocused = value;
          });
        },
        hoverColor: hoverColor,
        focusColor: focusColor,
        onHover: (value) {
          setState(() {
            _isHovered = value;
          });
        },
        onTap: widget.onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              JNMBorderRadius.sm,
            ),
          ),
          child: widget.builder(context, _isFocused, _isHovered),
        ),
      ),
    );
  }
}

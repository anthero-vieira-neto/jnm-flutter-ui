import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

/// JNM UI's Tertiary Primary Button component widget.
class JNMTertiaryPrimaryButton extends StatefulWidget {
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

  /// Whether to style the button as destructive/dangerous.
  final bool isDestructive;

  /// Theme data for button styling
  final JNMTertiaryButtonThemeData? buttonThemeData;

  const JNMTertiaryPrimaryButton({
    required this.builder,
    required this.onPressed,
    this.height = JNMButtonHeights.md,
    this.contentPadding,
    this.isDestructive = false,
    this.buttonThemeData,
    super.key,
  });

  @override
  State<JNMTertiaryPrimaryButton> createState() =>
      _JNMTertiaryPrimaryButtonState();

  /// Creates [JNMTertiaryPrimaryButton] with only text as content.
  factory JNMTertiaryPrimaryButton.text({
    required String text,
    double height = JNMButtonHeights.md,
    VoidCallback? onPressed,
    bool isDestructive = false,
    JNMTertiaryButtonThemeData? buttonThemeData,
    Key? key,
  }) {
    return JNMTertiaryPrimaryButton(
      key: key,
      height: height,
      onPressed: onPressed,
      isDestructive: isDestructive,
      buttonThemeData: buttonThemeData,
      builder: (context, isFocused, isHovered) {
        // ignore: no_leading_underscores_for_local_identifiers
        final _buttonThemeData = buttonThemeData ??
            JNMButtonTheme.of(context)?.tertiaryPrimaryButtonThemeData ??
            const JNMTertiaryButtonThemeData();
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
            fontSize: JNMButtonTextFontSize.fromButtonHeights(height),
            fontWeight: JNMFontWeights.semibold,
          ),
        );
      },
    );
  }

  /// Creates [JNMTertiaryPrimaryButton] with text and icon(s) (leading and/or trailing)
  /// as content.
  factory JNMTertiaryPrimaryButton.icon({
    required String text,
    required IconData? leadingIconAssetName,
    required IconData? trailingIconAssetName,
    double height = JNMButtonHeights.md,
    VoidCallback? onPressed,
    bool isDestructive = false,
    JNMTertiaryButtonThemeData? buttonThemeData,
    Key? key,
  }) {
    return JNMTertiaryPrimaryButton(
      key: key,
      height: height,
      onPressed: onPressed,
      isDestructive: isDestructive,
      buttonThemeData: buttonThemeData,
      builder: (context, isFocused, isHovered) {
        // ignore: no_leading_underscores_for_local_identifiers
        final _buttonThemeData = buttonThemeData ??
            JNMButtonTheme.of(context)?.tertiaryPrimaryButtonThemeData ??
            const JNMTertiaryButtonThemeData();
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
                fontSize: JNMButtonTextFontSize.fromButtonHeights(height),
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

  /// Creates [JNMTertiaryPrimaryButton] with only an icon as content.
  factory JNMTertiaryPrimaryButton.iconOnly({
    required IconData iconAssetName,
    double height = JNMButtonHeights.md,
    VoidCallback? onPressed,
    bool isDestructive = false,
    JNMTertiaryButtonThemeData? buttonThemeData,
    Key? key,
  }) {
    return JNMTertiaryPrimaryButton(
      key: key,
      height: height,
      onPressed: onPressed,
      isDestructive: isDestructive,
      contentPadding: JNMButtonIconOnlyPadding.fromButtonHeights(height),
      buttonThemeData: buttonThemeData,
      builder: (context, isFocused, isHovered) {
        // ignore: no_leading_underscores_for_local_identifiers
        final _buttonThemeData = buttonThemeData ??
            JNMButtonTheme.of(context)?.tertiaryPrimaryButtonThemeData ??
            const JNMTertiaryButtonThemeData();
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
}

class _JNMTertiaryPrimaryButtonState
    extends State<JNMTertiaryPrimaryButton> {
  /// Whether currently the button is focused.
  bool _isFocused = false;

  /// Whether currently the button is hovered.
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    JNMTertiaryButtonThemeData buttonThemeData = widget.buttonThemeData ??
        JNMButtonTheme.of(context)?.tertiaryPrimaryButtonThemeData ??
        const JNMTertiaryButtonThemeData();

    late Color hoverColor;
    late Color focusColor;
    hoverColor = buttonThemeData.hoverColor;
    focusColor = buttonThemeData.focusColor;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          JNMBorderRadius.sm,
        ),
      ),
      child: Material(
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
          focusColor: focusColor,
          hoverColor: hoverColor,
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
            child: Padding(
              padding: widget.contentPadding ??
                  JNMButtonPadding.fromButtonHeights(widget.height),
              child: widget.builder(context, _isFocused, _isHovered),
            ),
          ),
        ),
      ),
    );
  }
}

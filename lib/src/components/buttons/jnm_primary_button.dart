import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

/// JNM UI's Primary Button component widget.
class JNMPrimaryButton extends StatefulWidget {
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
  final JNMPrimaryButtonThemeData? buttonThemeData;

  const JNMPrimaryButton({
    required this.builder,
    required this.onPressed,
    this.height = JNMButtonHeights.md,
    this.contentPadding,
    this.isDestructive = false,
    this.buttonThemeData,
    super.key,
  });

  @override
  State<JNMPrimaryButton> createState() => _JNMPrimaryButtonState();

  /// Creates [JNMPrimaryButton] with only text as content.
  factory JNMPrimaryButton.text({
    required String text,
    double height = JNMButtonHeights.md,
    VoidCallback? onPressed,
    bool isDestructive = false,
    JNMPrimaryButtonThemeData? buttonThemeData,
    Key? key,
  }) {
    return JNMPrimaryButton(
      key: key,
      height: height,
      onPressed: onPressed,
      isDestructive: isDestructive,
      buttonThemeData: buttonThemeData,
      builder: (_, __, ___) => Text(
        text,
        textAlign: TextAlign.center,
        style: JNMFontFamilies.inter(
          color: JNMColors.white,
          fontSize: JNMButtonTextFontSize.fromButtonHeights(height),
          fontWeight: JNMFontWeights.semibold,
        ),
      ),
    );
  }

  /// Creates [JNMPrimaryButton] with text and icon(s) (leading and/or trailing)
  /// as content.
  factory JNMPrimaryButton.icon({
    required String text,
    required IconData? leadingIconAssetName,
    required IconData? trailingIconAssetName,
    double height = JNMButtonHeights.md,
    VoidCallback? onPressed,
    bool isDestructive = false,
    JNMPrimaryButtonThemeData? buttonThemeData,
    Key? key,
  }) {
    return JNMPrimaryButton(
      key: key,
      height: height,
      onPressed: onPressed,
      isDestructive: isDestructive,
      buttonThemeData: buttonThemeData,
      builder: (_, __, ___) => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          leadingIconAssetName != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    JNMIcon(
                      leadingIconAssetName,
                      color: JNMColors.white,
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
              color: JNMColors.white,
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
                      color: JNMColors.white,
                      size: JNMButtonIconSize.fromButtonHeights(height),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  /// Creates [JNMPrimaryButton] with only an icon as content.
  factory JNMPrimaryButton.iconOnly({
    required IconData iconAssetName,
    double height = JNMButtonHeights.md,
    VoidCallback? onPressed,
    bool isDestructive = false,
    JNMPrimaryButtonThemeData? buttonThemeData,
    Key? key,
  }) {
    return JNMPrimaryButton(
      key: key,
      height: height,
      onPressed: onPressed,
      isDestructive: isDestructive,
      contentPadding: JNMButtonIconOnlyPadding.fromButtonHeights(height),
      buttonThemeData: buttonThemeData,
      builder: (_, __, ___) => JNMIcon(
        iconAssetName,
        color: JNMColors.white,
        size: JNMButtonIconSize.fromButtonHeights(height),
      ),
    );
  }
}

class _JNMPrimaryButtonState extends State<JNMPrimaryButton> {
  /// Whether currently the button is focused.
  bool _isFocused = false;

  /// Whether currently the button is hovered.
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    JNMButtonThemeData buttonThemeData = widget.buttonThemeData ??
        JNMButtonTheme.of(context)?.primaryButtonThemeData ??
        const JNMPrimaryButtonThemeData();

    late Color shadowColor;
    late Color primaryColor;
    late Color disabledColor;
    late Color hoverColor;
    late Color focusColor;
    if (!widget.isDestructive) {
      shadowColor = buttonThemeData.shadowColor;
      primaryColor = buttonThemeData.primaryColor;
      disabledColor = buttonThemeData.disabledColor;
      hoverColor = buttonThemeData.hoverColor;
      focusColor = buttonThemeData.focusColor;
    } else {
      shadowColor = const Color(0xFFFEE4E2);
      primaryColor = JNMColors.danger;
      disabledColor = JNMColors.danger200;
      hoverColor = JNMColors.danger600;
      focusColor = JNMColors.danger;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          JNMBorderRadius.sm,
        ),
        boxShadow: !_isFocused
            ? JNMBoxShadow.xs
            : [
                const BoxShadow(
                  color: Color.fromRGBO(16, 24, 40, 0.05),
                  offset: Offset(1.0, 0.0),
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                ),
                BoxShadow(
                  color: shadowColor,
                  offset: const Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 4.0,
                ),
              ],
      ),
      child: Material(
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

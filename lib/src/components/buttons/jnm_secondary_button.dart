import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

/// JNM UI's Secondary Button component widget.
class JNMSecondaryButton extends StatefulWidget {
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
  final JNMSecondaryButtonThemeData? buttonThemeData;

  const JNMSecondaryButton({
    required this.builder,
    required this.onPressed,
    this.height = JNMButtonHeights.md,
    this.contentPadding,
    this.isDestructive = false,
    this.buttonThemeData,
    super.key,
  });

  @override
  State<JNMSecondaryButton> createState() => _JNMSecondaryButtonState();

  /// Creates [JNMSecondaryButton] with only text as content.
  factory JNMSecondaryButton.text({
    required String text,
    double height = JNMButtonHeights.md,
    VoidCallback? onPressed,
    bool isDestructive = false,
    JNMSecondaryButtonThemeData? buttonThemeData,
    Key? key,
  }) {
    return JNMSecondaryButton(
      key: key,
      height: height,
      onPressed: onPressed,
      isDestructive: isDestructive,
      buttonThemeData: buttonThemeData,
      builder: (context, __, isHovered) {
        // ignore: no_leading_underscores_for_local_identifiers
        final _buttonThemeData = buttonThemeData ??
            JNMButtonTheme.of(context)?.secondaryButtonThemeData ??
            const JNMSecondaryButtonThemeData();
        Color textColor;
        if (!isDestructive) {
          textColor = _buttonThemeData.onSecondaryColor;
          if (onPressed == null) {
            textColor = _buttonThemeData.onSecondaryVariantColor;
          } else if (isHovered) {
            textColor = _buttonThemeData.onHoverColor;
          }
        } else {
          textColor = JNMColors.danger;
          if (onPressed == null) {
            textColor = JNMColors.danger300;
          } else if (isHovered) {
            textColor = JNMColors.danger800;
          }
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

  /// Creates [JNMSecondaryButton] with text and icon(s) (leading and/or trailing)
  /// as content.
  factory JNMSecondaryButton.icon({
    required String text,
    required IconData? leadingIconAssetName,
    required IconData? trailingIconAssetName,
    double height = JNMButtonHeights.md,
    VoidCallback? onPressed,
    bool isDestructive = false,
    JNMSecondaryButtonThemeData? buttonThemeData,
    Key? key,
  }) {
    return JNMSecondaryButton(
      key: key,
      height: height,
      onPressed: onPressed,
      isDestructive: isDestructive,
      buttonThemeData: buttonThemeData,
      builder: (context, __, isHovered) {
        // ignore: no_leading_underscores_for_local_identifiers
        final _buttonThemeData = buttonThemeData ??
            JNMButtonTheme.of(context)?.secondaryButtonThemeData ??
            const JNMSecondaryButtonThemeData();
        Color textColor;
        if (!isDestructive) {
          textColor = _buttonThemeData.onSecondaryColor;
          if (onPressed == null) {
            textColor = _buttonThemeData.onSecondaryVariantColor;
          } else if (isHovered) {
            textColor = _buttonThemeData.onHoverColor;
          }
        } else {
          textColor = JNMColors.danger;
          if (onPressed == null) {
            textColor = JNMColors.danger300;
          } else if (isHovered) {
            textColor = JNMColors.danger800;
          }
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

  /// Creates [JNMSecondaryButton] with only an icon as content.
  factory JNMSecondaryButton.iconOnly({
    required IconData iconAssetName,
    double height = JNMButtonHeights.md,
    VoidCallback? onPressed,
    bool isDestructive = false,
    JNMSecondaryButtonThemeData? buttonThemeData,
    Key? key,
  }) {
    return JNMSecondaryButton(
      key: key,
      height: height,
      onPressed: onPressed,
      isDestructive: isDestructive,
      contentPadding: JNMButtonIconOnlyPadding.fromButtonHeights(height),
      buttonThemeData: buttonThemeData,
      builder: (context, __, isHovered) {
        // ignore: no_leading_underscores_for_local_identifiers
        final _buttonThemeData = buttonThemeData ??
            JNMButtonTheme.of(context)?.secondaryButtonThemeData ??
            const JNMSecondaryButtonThemeData();
        Color textColor;
        if (!isDestructive) {
          textColor = _buttonThemeData.onSecondaryColor;
          if (onPressed == null) {
            textColor = _buttonThemeData.onSecondaryVariantColor;
          } else if (isHovered) {
            textColor = _buttonThemeData.onHoverColor;
          }
        } else {
          textColor = JNMColors.danger;
          if (onPressed == null) {
            textColor = JNMColors.danger300;
          } else if (isHovered) {
            textColor = JNMColors.danger800;
          }
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

class _JNMSecondaryButtonState extends State<JNMSecondaryButton> {
  /// Whether currently the button is focused.
  bool _isFocused = false;

  /// Whether currently the button is hovered.
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    JNMSecondaryButtonThemeData buttonThemeData = widget.buttonThemeData ??
        JNMButtonTheme.of(context)?.secondaryButtonThemeData ??
        const JNMSecondaryButtonThemeData();

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
      primaryColor = JNMColors.danger100;
      disabledColor = JNMColors.danger100;
      hoverColor = JNMColors.danger100;
      focusColor = JNMColors.danger100;
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

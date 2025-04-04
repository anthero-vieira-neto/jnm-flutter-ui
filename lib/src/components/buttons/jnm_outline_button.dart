import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

/// JNM UI's Outline Button component widget.
class JNMOutlineButton extends StatefulWidget {
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
  final JNMOutlineButtonThemeData buttonThemeData;

  const JNMOutlineButton({
    required this.builder,
    required this.onPressed,
    required this.buttonThemeData,
    this.height = JNMButtonHeights.md,
    this.contentPadding,
    this.isDestructive = false,
    super.key,
  });

  @override
  State<JNMOutlineButton> createState() => _JNMOutlineButtonState();

  /// Creates [JNMOutlineButton] with only text as content.
  factory JNMOutlineButton.text({
    required String text,
    double height = JNMButtonHeights.md,
    VoidCallback? onPressed,
    bool isDestructive = false,
    JNMOutlineButtonThemeData buttonThemeData =
        const JNMOutlineButtonThemeData(),
    Key? key,
  }) {
    return JNMOutlineButton(
      key: key,
      height: height,
      onPressed: onPressed,
      isDestructive: isDestructive,
      buttonThemeData: buttonThemeData,
      builder: (context, isFocused, isHovered) {
        // ignore: no_leading_underscores_for_local_identifiers
        final _buttonThemeData =
            JNMButtonTheme.of(context)?.outlineButtonThemeData ??
                buttonThemeData;
        Color textColor;
        if (!isDestructive) {
          textColor = onPressed != null
              ? _buttonThemeData.onSurfaceColor
              : _buttonThemeData.onSurfaceVariantColor;
        } else {
          if (!isHovered) {
            textColor = onPressed != null
                ? JNMColors.danger
                : JNMColors.danger300;
          } else {
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

  /// Creates [JNMOutlineButton] with text and icon(s) (leading and/or trailing)
  /// as content.
  factory JNMOutlineButton.icon({
    required String text,
    required IconData? leadingIconAssetName,
    required IconData? trailingIconAssetName,
    double height = JNMButtonHeights.md,
    VoidCallback? onPressed,
    bool isDestructive = false,
    JNMOutlineButtonThemeData buttonThemeData =
        const JNMOutlineButtonThemeData(),
    Key? key,
  }) {
    return JNMOutlineButton(
      key: key,
      height: height,
      onPressed: onPressed,
      isDestructive: isDestructive,
      buttonThemeData: buttonThemeData,
      builder: (context, isFocused, isHovered) {
        // ignore: no_leading_underscores_for_local_identifiers
        final _buttonThemeData =
            JNMButtonTheme.of(context)?.outlineButtonThemeData ??
                buttonThemeData;
        Color textColor;
        if (!isDestructive) {
          textColor = onPressed != null
              ? _buttonThemeData.onSurfaceColor
              : _buttonThemeData.onSurfaceVariantColor;
        } else {
          if (!isHovered) {
            textColor = onPressed != null
                ? JNMColors.danger
                : JNMColors.danger300;
          } else {
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

  /// Creates [JNMOutlineButton] with only an icon as content.
  factory JNMOutlineButton.iconOnly({
    required IconData iconAssetName,
    double height = JNMButtonHeights.md,
    VoidCallback? onPressed,
    bool isDestructive = false,
    JNMOutlineButtonThemeData buttonThemeData =
        const JNMOutlineButtonThemeData(),
    Key? key,
  }) {
    return JNMOutlineButton(
      key: key,
      height: height,
      onPressed: onPressed,
      isDestructive: isDestructive,
      contentPadding: JNMButtonIconOnlyPadding.fromButtonHeights(height),
      buttonThemeData: buttonThemeData,
      builder: (context, isFocused, isHovered) {
        // ignore: no_leading_underscores_for_local_identifiers
        final _buttonThemeData =
            JNMButtonTheme.of(context)?.outlineButtonThemeData ??
                buttonThemeData;
        Color textColor;
        if (!isDestructive) {
          textColor = onPressed != null
              ? _buttonThemeData.onSurfaceColor
              : _buttonThemeData.onSurfaceVariantColor;
        } else {
          if (!isHovered) {
            textColor = onPressed != null
                ? JNMColors.danger
                : JNMColors.danger300;
          } else {
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

class _JNMOutlineButtonState extends State<JNMOutlineButton> {
  /// Whether currently the button is focused.
  bool _isFocused = false;

  /// Whether currently the button is hovered.
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    JNMOutlineButtonThemeData buttonThemeData =
        JNMButtonTheme.of(context)?.outlineButtonThemeData ??
            widget.buttonThemeData;

    late Color borderColor;
    late Color shadowColor;
    late Color primaryColor;
    late Color disabledColor;
    late Color hoverColor;
    late Color focusColor;
    if (!widget.isDestructive) {
      borderColor = buttonThemeData.borderColor;
      shadowColor = buttonThemeData.shadowColor;
      primaryColor = buttonThemeData.primaryColor;
      disabledColor = buttonThemeData.disabledColor;
      hoverColor = buttonThemeData.hoverColor;
      focusColor = buttonThemeData.focusColor;
    } else {
      borderColor = widget.onPressed != null
          ? JNMColors.danger300
          : JNMColors.danger200;
      shadowColor = const Color(0xFFFEE4E2);
      primaryColor = JNMColors.white;
      disabledColor = JNMColors.white;
      hoverColor = JNMColors.danger100;
      focusColor = JNMColors.white;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          JNMBorderRadius.sm,
        ),
        border: Border.all(color: borderColor),
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

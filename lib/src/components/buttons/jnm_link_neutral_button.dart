import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

/// JNM UI's Link Neutral Button component widget.
class JNMLinkNeutralButton extends StatefulWidget {
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

  const JNMLinkNeutralButton({
    required this.builder,
    required this.onPressed,
    this.height = JNMButtonHeights.md,
    this.contentPadding,
    this.isDestructive = false,
    super.key,
  });

  @override
  State<JNMLinkNeutralButton> createState() =>
      _JNMLinkNeutralButtonState();

  /// Creates [JNMLinkNeutralButton] with only text as content.
  factory JNMLinkNeutralButton.text({
    required String text,
    double height = JNMButtonHeights.md,
    VoidCallback? onPressed,
    bool isDestructive = false,
    Key? key,
  }) {
    return JNMLinkNeutralButton(
      key: key,
      height: height,
      onPressed: onPressed,
      isDestructive: isDestructive,
      builder: (context, isFocused, isHovered) {
        Color textColor;
        if (!isDestructive) {
          if (!isHovered) {
            textColor = onPressed != null
                ? JNMColors.neutral400
                : JNMColors.neutral100;
          } else {
            textColor = JNMColors.neutral;
          }
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
            fontSize:
                JNMLinkNeutralButton.getFontSizeFromButtonHeight(height),
            fontWeight: JNMFontWeights.semibold,
          ),
        );
      },
    );
  }

  /// Creates [JNMLinkNeutralButton] with text and icon(s) (leading and/or trailing)
  /// as content.
  factory JNMLinkNeutralButton.icon({
    required String text,
    required IconData? leadingIconAssetName,
    required IconData? trailingIconAssetName,
    double height = JNMButtonHeights.md,
    VoidCallback? onPressed,
    bool isDestructive = false,
    Key? key,
  }) {
    return JNMLinkNeutralButton(
      key: key,
      height: height,
      onPressed: onPressed,
      isDestructive: isDestructive,
      builder: (context, isFocused, isHovered) {
        Color textColor;
        if (!isDestructive) {
          if (!isHovered) {
            textColor = onPressed != null
                ? JNMColors.neutral400
                : JNMColors.neutral100;
          } else {
            textColor = JNMColors.neutral;
          }
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
                fontSize: JNMLinkNeutralButton.getFontSizeFromButtonHeight(
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

  /// Creates [JNMLinkNeutralButton] with only an icon as content.
  factory JNMLinkNeutralButton.iconOnly({
    required IconData iconAssetName,
    double height = JNMButtonHeights.md,
    VoidCallback? onPressed,
    bool isDestructive = false,
    Key? key,
  }) {
    return JNMLinkNeutralButton(
      key: key,
      height: height,
      onPressed: onPressed,
      isDestructive: isDestructive,
      contentPadding: JNMButtonIconOnlyPadding.fromButtonHeights(height),
      builder: (context, isFocused, isHovered) {
        Color textColor;
        if (!isDestructive) {
          if (!isHovered) {
            textColor = onPressed != null
                ? JNMColors.neutral400
                : JNMColors.neutral100;
          } else {
            textColor = JNMColors.neutral;
          }
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

class _JNMLinkNeutralButtonState extends State<JNMLinkNeutralButton> {
  /// Whether currently the button is focused.
  bool _isFocused = false;

  /// Whether currently the button is hovered.
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    late Color primaryColor;
    late Color disabledColor;
    late Color hoverColor;
    late Color focusColor;
    if (!widget.isDestructive) {
      primaryColor = Colors.transparent;
      disabledColor = Colors.transparent;
      hoverColor = Colors.transparent;
      focusColor = Colors.transparent;
    } else {
      primaryColor = Colors.transparent;
      disabledColor = Colors.transparent;
      hoverColor = Colors.transparent;
      focusColor = Colors.transparent;
    }

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

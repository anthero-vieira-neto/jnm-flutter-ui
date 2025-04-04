import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

/// JNM UI's Tertiary Neutral Button component widget.
class JNMTertiaryNeutralButton extends StatefulWidget {
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

  const JNMTertiaryNeutralButton({
    required this.builder,
    required this.onPressed,
    this.height = JNMButtonHeights.md,
    this.contentPadding,
    this.isDestructive = false,
    super.key,
  });

  @override
  State<JNMTertiaryNeutralButton> createState() =>
      _JNMTertiaryNeutralButtonState();

  /// Creates [JNMTertiaryNeutralButton] with only text as content.
  factory JNMTertiaryNeutralButton.text({
    required String text,
    double height = JNMButtonHeights.md,
    VoidCallback? onPressed,
    bool isDestructive = false,
    Key? key,
  }) {
    return JNMTertiaryNeutralButton(
      key: key,
      height: height,
      onPressed: onPressed,
      isDestructive: isDestructive,
      builder: (context, isFocused, isHovered) {
        Color textColor;
        if (!isDestructive) {
          if (!isHovered) {
            textColor = onPressed != null
                ? JNMColors.neutral500
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
            fontSize: JNMButtonTextFontSize.fromButtonHeights(height),
            fontWeight: JNMFontWeights.semibold,
          ),
        );
      },
    );
  }

  /// Creates [JNMTertiaryNeutralButton] with text and icon(s) (leading and/or trailing)
  /// as content.
  factory JNMTertiaryNeutralButton.icon({
    required String text,
    required IconData? leadingIconAssetName,
    required IconData? trailingIconAssetName,
    double height = JNMButtonHeights.md,
    VoidCallback? onPressed,
    bool isDestructive = false,
    Key? key,
  }) {
    return JNMTertiaryNeutralButton(
      key: key,
      height: height,
      onPressed: onPressed,
      isDestructive: isDestructive,
      builder: (context, isFocused, isHovered) {
        Color textColor;
        if (!isDestructive) {
          if (!isHovered) {
            textColor = onPressed != null
                ? JNMColors.neutral500
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

  /// Creates [JNMTertiaryNeutralButton] with only an icon as content.
  factory JNMTertiaryNeutralButton.iconOnly({
    required IconData iconAssetName,
    double height = JNMButtonHeights.md,
    VoidCallback? onPressed,
    bool isDestructive = false,
    Key? key,
  }) {
    return JNMTertiaryNeutralButton(
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
                ? JNMColors.neutral500
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
}

class _JNMTertiaryNeutralButtonState
    extends State<JNMTertiaryNeutralButton> {
  /// Whether currently the button is focused.
  bool _isFocused = false;

  /// Whether currently the button is hovered.
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    late Color hoverColor;
    late Color focusColor;
    if (!widget.isDestructive) {
      hoverColor = JNMColors.neutral100;
      focusColor = Colors.transparent;
    } else {
      hoverColor = JNMColors.danger100;
      focusColor = Colors.transparent;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          JNMBorderRadius.sm,
        ),
      ),
      child: Material(
        color: Colors.transparent,
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

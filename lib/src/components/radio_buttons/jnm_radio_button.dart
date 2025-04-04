import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

/// Possible size values for radio button.
enum JNMRadioButtonSize {
  /// Small (SM) radio button size.
  sm,

  /// Medium (MD) radio button size.
  md,
}

/// JNM UI's Radio Button component widget.
class JNMRadioButton<T> extends StatefulWidget {
  /// The value represented by this radio button.
  final T value;

  /// The currently selected value for this group of radio buttons.
  final T? groupValue;

  /// Radio button's size.
  final JNMRadioButtonSize size;

  /// Radio button supporting title if any.
  final String? title;

  /// Radio button supporting subtitle if any.
  final String? subtitle;

  /// Callback when radio button value is changed. Set this value to null to
  /// disable the radio button.
  final ValueChanged<T>? onChanged;

  /// Theme for radio button styling.
  final JNMRadioButtonThemeData themeData;

  const JNMRadioButton({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.size = JNMRadioButtonSize.md,
    this.themeData = const JNMRadioButtonThemeData(),
    this.title,
    this.subtitle,
    super.key,
  });

  @override
  State<JNMRadioButton<T>> createState() => _JNMRadioButtonState<T>();
}

class _JNMRadioButtonState<T> extends State<JNMRadioButton<T>> {
  /// Whether currently the radio button is focused.
  bool _isFocused = false;

  /// Whether currently the radio button is hovered.
  bool _isHovered = false;

  /// Theme for radio button styling.
  late JNMRadioButtonThemeData themeData;

  @override
  Widget build(BuildContext context) {
    themeData = JNMRadioButtonTheme.of(context)?.data ?? widget.themeData;

    if (widget.title == null && widget.subtitle == null) {
      return _buildRadioButton(context);
    } else {
      return _buildRadioButtonWithTexts(context);
    }
  }

  /// Builds the radio button widget.
  Widget _buildRadioButton(BuildContext context) {
    double radioButtonSize;
    double radioButtonBorderRadius;
    double radioButtonIconSize;
    switch (widget.size) {
      case JNMRadioButtonSize.sm:
        radioButtonSize = 16.0;
        radioButtonBorderRadius = 8.0;
        radioButtonIconSize = 6.0;
        break;
      case JNMRadioButtonSize.md:
      default:
        radioButtonSize = 20.0;
        radioButtonBorderRadius = 10.0;
        radioButtonIconSize = 8.0;
        break;
    }

    Color radioButtonBorderColor;
    if (widget.onChanged != null) {
      if (widget.value == widget.groupValue || _isHovered) {
        radioButtonBorderColor = themeData.borderActiveColor;
      } else {
        if (_isFocused) {
          radioButtonBorderColor = themeData.borderFocusedColor;
        } else {
          radioButtonBorderColor = themeData.borderColor;
        }
      }
    } else {
      radioButtonBorderColor = themeData.borderDisabledColor;
    }

    Color radioButtonBackgroundColor;
    if (widget.onChanged != null) {
      if (widget.value == widget.groupValue || _isHovered) {
        radioButtonBackgroundColor = themeData.backgroundActiveColor;
      } else {
        radioButtonBackgroundColor = themeData.backgroundColor;
      }
    } else {
      radioButtonBackgroundColor = themeData.backgroundDisabledColor;
    }

    List<BoxShadow>? radioButtonBoxShadow;
    if (widget.onChanged != null && _isFocused) {
      radioButtonBoxShadow = const [
        BoxShadow(
          color: Color.fromRGBO(235, 241, 255, 1.0),
          offset: Offset(0.0, 0.0),
          blurRadius: 0.0,
          spreadRadius: 4.0,
        ),
      ];
    }

    Widget? child;
    if (widget.value == widget.groupValue) {
      child = Center(
        child: Container(
          height: radioButtonIconSize,
          width: radioButtonIconSize,
          decoration: BoxDecoration(
            color: themeData.primaryColor,
            shape: BoxShape.circle,
          ),
        ),
      );
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: radioButtonBoxShadow,
          borderRadius: BorderRadius.circular(radioButtonBorderRadius),
        ),
        child: Material(
          color: radioButtonBackgroundColor,
          borderRadius: BorderRadius.circular(radioButtonBorderRadius),
          child: InkWell(
            onTap: () => widget.onChanged != null
                ? widget.onChanged!(widget.value)
                : null,
            onFocusChange: (value) {
              setState(() {
                _isFocused = value;
              });
            },
            focusColor: themeData.focusColor,
            onHover: (value) {
              setState(() {
                _isHovered = value;
              });
            },
            hoverColor: themeData.hoverColor,
            borderRadius: BorderRadius.circular(radioButtonBorderRadius),
            child: Container(
              width: radioButtonSize,
              height: radioButtonSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radioButtonBorderRadius),
                border: Border.all(
                  color: radioButtonBorderColor,
                ),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the radio button widget with supporting texts.
  Widget _buildRadioButtonWithTexts(BuildContext context) {
    double fontSize;
    switch (widget.size) {
      case JNMRadioButtonSize.sm:
        fontSize = JNMFontSizes.sm;
        break;
      case JNMRadioButtonSize.md:
      default:
        fontSize = JNMFontSizes.md;
        break;
    }

    return GestureDetector(
      onTap: () =>
          widget.onChanged != null ? widget.onChanged!(widget.value) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRadioButton(context),
            const SizedBox(width: 8.0),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title!,
                    style: JNMFontFamilies.inter(
                      color: themeData.titleColor,
                      fontSize: fontSize,
                      fontWeight: JNMFontWeights.medium,
                    ),
                  ),
                  widget.subtitle != null
                      ? Text(
                          widget.subtitle!,
                          style: JNMFontFamilies.inter(
                            color: themeData.subtitleColor,
                            fontSize: fontSize,
                            fontWeight: JNMFontWeights.regular,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

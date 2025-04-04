import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

/// JNM UI's Radio List Tile component widget.
class JNMRadioListTile<T> extends StatefulWidget {
  /// The value represented by this radio button.
  final T value;

  /// The currently selected value for this group of radio buttons.
  final T? groupValue;

  /// Radio button's size.
  final JNMRadioButtonSize size;

  /// Radio List Tile supporting title if any.
  final String? title;

  /// Radio List Tile supporting subtitle if any.
  final String? subtitle;

  /// Callback when radio button value is changed.
  /// Set this value to null to disable the radio button.
  final ValueChanged<T>? onChanged;

  /// Radio List Tile supporting trailing widget if any.
  final Widget? trailingWidget;

  /// Radio List Tile padding size
  final EdgeInsets padding;

  const JNMRadioListTile({
    required this.value,
    this.groupValue,
    this.size = JNMRadioButtonSize.md,
    this.title,
    this.subtitle,
    this.onChanged,
    this.trailingWidget,
    this.padding = const EdgeInsets.all(16.0),
    super.key,
  });

  @override
  // ignore: lines_longer_than_80_chars
  State<JNMRadioListTile<T>> createState() =>
      _JNMRadioListTileState<T>();
}

class _JNMRadioListTileState<T> extends State<JNMRadioListTile<T>> {
  /// Whether currently the radio button is focused.
  bool _isFocused = false;

  /// Whether currently the radio button is hovered.
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
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

    Color listTileBackgroundColor;
    if (widget.onChanged != null) {
      if (_isHovered) {
        listTileBackgroundColor = JNMColors.primary100;
      } else {
        listTileBackgroundColor = JNMColors.white;
      }
    } else {
      listTileBackgroundColor = JNMColors.neutral100;
    }

    List<BoxShadow>? listTileBoxShadow;
    if (widget.onChanged != null && _isFocused) {
      listTileBoxShadow = const [
        BoxShadow(
          color: Color.fromRGBO(235, 241, 255, 1.0),
          offset: Offset(0.0, 0.0),
          blurRadius: 0.0,
          spreadRadius: 4.0,
        ),
      ];
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: JNMColors.neutral100,
        ),
        color: listTileBackgroundColor,
        borderRadius: BorderRadius.circular(JNMBorderRadius.sm),
        boxShadow: listTileBoxShadow,
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () =>
              widget.onChanged != null ? widget.onChanged!(widget.value) : null,
          onFocusChange: (value) {
            setState(() {
              _isFocused = value;
            });
          },
          focusColor: JNMColors.white,
          onHover: (value) {
            setState(() {
              _isHovered = value;
            });
          },
          hoverColor: JNMColors.primary100,
          borderRadius: BorderRadius.circular(JNMBorderRadius.sm),
          child: Padding(
            padding: widget.padding,
            child: Row(
              children: [
                JNMRadioButton<T>(
                  value: widget.value,
                  groupValue: widget.groupValue,
                  onChanged: widget.onChanged,
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title!,
                        style: JNMFontFamilies.inter(
                          color: JNMColors.neutral,
                          fontSize: fontSize,
                          fontWeight: JNMFontWeights.medium,
                        ),
                      ),
                      widget.subtitle != null
                          ? Text(
                              widget.subtitle!,
                              style: JNMFontFamilies.inter(
                                color: JNMColors.neutral300,
                                fontSize: fontSize,
                                fontWeight: JNMFontWeights.regular,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                if (widget.trailingWidget != null) widget.trailingWidget!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

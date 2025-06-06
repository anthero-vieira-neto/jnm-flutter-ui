import 'package:jnm_ui/jnm_ui.dart';
import 'package:jnm_ui/src/styles/library_text_styles.dart';
import 'package:flutter/material.dart';

/// JNM UI's Checkbox List Tile component widget.
class JNMCheckboxListTile extends StatefulWidget {
  /// Whether the checkbox is checked.
  final bool checked;

  /// Whether the checkbox is indeterminate. Make sure to set [checked] as well
  /// to use this property.
  final bool indeterminate;

  /// Checkbox's size.
  final JNMCheckboxSize size;

  /// Checkbox supporting title if any.
  final String title;

  /// Checkbox supporting subtitle if any.
  final String? subtitle;

  /// Callback when checkbox is pressed.
  /// Set this value to null to disable the checkbox.
  final VoidCallback? onPressed;

  /// Radio List Tile supporting trailing widget if any.
  final Widget? trailingWidget;

  /// Radio List Tile padding size
  final EdgeInsets padding;

  /// Theme for checkbox styling.
  final JNMCheckboxThemeData checkboxThemeData;

  const JNMCheckboxListTile({
    required this.checked,
    required this.onPressed,
    required this.title,
    this.indeterminate = false,
    this.size = JNMCheckboxSize.md,
    this.subtitle,
    this.trailingWidget,
    this.padding = const EdgeInsets.all(16.0),
    this.checkboxThemeData = const JNMCheckboxThemeData(),
    super.key,
  });

  @override
  State<JNMCheckboxListTile> createState() =>
      _JNMCheckboxListTileState();
}

class _JNMCheckboxListTileState extends State<JNMCheckboxListTile> {
  /// Whether currently the checkbox is focused.
  bool _isFocused = false;

  /// Whether currently the checkbox is hovered.
  bool _isHovered = false;

  /// Theme for checkbox styling.
  late JNMCheckboxThemeData checkboxThemeData;

  @override
  Widget build(BuildContext context) {
    checkboxThemeData = JNMCheckboxTheme.of(context)?.checkboxThemeData ??
        widget.checkboxThemeData;

    return _buildListTile(context);
  }

  /// Builds the checkbox widget.
  Widget _buildListTile(BuildContext context) {
    Color listTileBackgroundColor;
    if (widget.onPressed != null) {
      if (widget.indeterminate || _isHovered) {
        listTileBackgroundColor = checkboxThemeData.backgroundCheckedColor;
      } else {
        listTileBackgroundColor = checkboxThemeData.backgroundColor;
      }
    } else {
      listTileBackgroundColor = checkboxThemeData.backgroundDisabledColor;
    }

    List<BoxShadow>? listTileBoxShadow;
    if (widget.onPressed != null && _isFocused) {
      listTileBoxShadow = const [
        BoxShadow(
          color: Color(0xFFEBF1FF),
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
          onTap: () => widget.onPressed != null ? widget.onPressed!() : null,
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
                JNMCheckbox(
                  checked: widget.checked,
                  indeterminate: widget.indeterminate,
                  size: widget.size,
                  onPressed: widget.onPressed,
                  checkboxThemeData: checkboxThemeData,
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: LibraryTextStyles.interSmMediumNeutral,
                      ),
                      widget.subtitle != null
                          ? Text(
                              widget.subtitle!,
                              style: LibraryTextStyles.interXsRegularNeutral300,
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

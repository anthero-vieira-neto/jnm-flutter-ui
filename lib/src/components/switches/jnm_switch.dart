import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

/// Possible size values for checkbox.
enum JNMSwitchSize {
  /// Small (SM) checkbox size.
  sm,

  /// Medium (MD) checkbox size.
  md,
}

/// JNM UI's Switch component widget.
class JNMSwitch extends StatefulWidget {
  /// Whether the switch is turned on.
  final bool value;

  /// Callback when switch is pressed. Set this value to null to disable the
  /// switch.
  final void Function(bool?)? onChanged;

  /// Switch's size.
  final JNMSwitchSize size;

  /// Switch animation duration.
  final Duration duration;

  /// Switch focus node if any.
  final FocusNode? focusNode;

  /// Switch supporting title if any.
  final String? title;

  /// Switch supporting subtitle if any.
  final String? subtitle;

  const JNMSwitch({
    required this.value,
    this.onChanged,
    this.size = JNMSwitchSize.md,
    this.duration = const Duration(milliseconds: 200),
    this.focusNode,
    this.title,
    this.subtitle,
    super.key,
  });

  @override
  State<JNMSwitch> createState() => _JNMSwitchState();
}

class _JNMSwitchState extends State<JNMSwitch> {
  /// Whether currently the switch is focused.
  bool _isFocused = false;

  /// The switch focus node.
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
    } else {
      _focusNode = FocusNode();
    }
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.title == null && widget.subtitle == null) {
      return _buildSwitch(context);
    } else {
      return _buildSwitchWithTexts(context);
    }
  }

  /// Builds the switch widget.
  Widget _buildSwitch(BuildContext context) {
    double indicatorSize;
    if (widget.size == JNMSwitchSize.sm) {
      indicatorSize = 16.0;
    } else {
      indicatorSize = 20.0;
    }
    Color thumbColor;
    Color trackColor;
    Color trackHoverColor;
    if (widget.onChanged != null) {
      thumbColor = JNMColors.white;
      if (!widget.value) {
        trackColor = JNMColors.neutral100;
        trackHoverColor = JNMColors.neutral200;
      } else {
        trackColor = JNMColors.primary;
        trackHoverColor = JNMColors.primary700;
      }
    } else {
      thumbColor = JNMColors.neutral100;
      trackColor = JNMColors.neutral100;
      trackHoverColor = JNMColors.neutral100;
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(JNMBorderRadius.md),
          boxShadow: !_isFocused
              ? JNMBoxShadow.xs
              : [
                  const BoxShadow(
                    color: Color(0xFFEBF1FF),
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 4.0,
                  ),
                ],
        ),
        child: Material(
          color: trackColor,
          borderRadius: BorderRadius.circular(JNMBorderRadius.md),
          child: InkWell(
            onTap: widget.onChanged != null
                ? () {
                    widget.onChanged!(!widget.value);
                  }
                : null,
            hoverColor: trackHoverColor,
            focusColor: trackColor,
            focusNode: _focusNode,
            borderRadius: BorderRadius.circular(JNMBorderRadius.md),
            child: Container(
              padding: const EdgeInsets.all(2.0),
              width: indicatorSize * 2,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: AnimatedAlign(
                alignment:
                    widget.value ? Alignment.centerRight : Alignment.centerLeft,
                duration: widget.duration,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: thumbColor,
                    boxShadow: JNMBoxShadow.sm,
                  ),
                  height: indicatorSize,
                  width: indicatorSize,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the switch widget with supporting texts.
  Widget _buildSwitchWithTexts(BuildContext context) {
    double fontSize;
    switch (widget.size) {
      case JNMSwitchSize.sm:
        fontSize = JNMFontSizes.sm;
        break;
      case JNMSwitchSize.md:
      default:
        fontSize = JNMFontSizes.md;
        break;
    }

    return GestureDetector(
      onTap: widget.onChanged != null
          ? () {
              widget.onChanged!(!widget.value);
            }
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSwitch(context),
          const SizedBox(width: 8.0),
          Column(
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
        ],
      ),
    );
  }
}

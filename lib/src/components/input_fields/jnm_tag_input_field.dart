import 'package:collection/collection.dart';
import 'package:jnm_ui/jnm_ui.dart';
import 'package:jnm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';

class JNMTagInputFieldValue<T> {
  final T value;
  final String label;

  JNMTagInputFieldValue({
    required this.value,
    required this.label,
  });
}

/// JNM UI's tag input field.
///
/// This component was made as closely as possible to [TextFormField].
class JNMTagInputField<T> extends StatefulWidget {
  /// The label above the input field.
  final String? label;

  /// The error text if any.
  final String? errorText;

  /// The hint text.
  final String? hintText;

  /// The helper text.
  final String? helperText;

  /// The suffix icon asset name.
  final IconData? suffixIconAssetName;

  /// The text field size.
  final JNMTextInputFieldSize size;

  /// If false the text field is "disabled": it ignores taps and its
  /// [decoration] is rendered in grey.
  ///
  /// If non-null this property overrides the [decoration]'s
  /// [InputDecoration.enabled] property.
  final bool enabled;

  /// Whether the field is required or not.
  final bool isRequired;

  final List<JNMTagInputFieldValue<T>> value;

  /// {@template flutter.material.textfield.onTap}
  /// Called for each distinct tap except for every second tap of a double tap.
  ///
  /// The text field builds a [GestureDetector] to handle input events like tap,
  /// to trigger focus requests, to move the caret, adjust the selection, etc.
  /// Handling some of those events by wrapping the text field with a competing
  /// GestureDetector is problematic.
  ///
  /// To unconditionally handle taps, without interfering with the text field's
  /// internal gesture detector, provide this callback.
  ///
  /// If the text field is created with [enabled] false, taps will not be
  /// recognized.
  ///
  /// To be notified when the text field gains or loses the focus, provide a
  /// [focusNode] and add a listener to that.
  ///
  /// To listen to arbitrary pointer events without competing with the
  /// text field's internal gesture detector, use a [Listener].
  /// {@endtemplate}
  final void Function()? onTap;

  /// Defines the keyboard focus for this widget.
  ///
  /// The [focusNode] is a long-lived object that's typically managed by a
  /// [StatefulWidget] parent. See [FocusNode] for more information.
  ///
  /// To give the keyboard focus to this widget, provide a [focusNode] and then
  /// use the current [FocusScope] to request the focus:
  ///
  /// ```dart
  /// FocusScope.of(context).requestFocus(myFocusNode);
  /// ```
  ///
  /// This happens automatically when the widget is tapped.
  ///
  /// To be notified when the widget gains or loses the focus, add a listener
  /// to the [focusNode]:
  ///
  /// ```dart
  /// myFocusNode.addListener(() { print(myFocusNode.hasFocus); });
  /// ```
  ///
  /// If null, this widget will create its own [FocusNode].
  ///
  /// ## Keyboard
  ///
  /// Requesting the focus will typically cause the keyboard to be shown
  /// if it's not showing already.
  ///
  /// On Android, the user can hide the keyboard - without changing the focus -
  /// with the system back button. They can restore the keyboard's visibility
  /// by tapping on a text field. The user might hide the keyboard and
  /// switch to a physical keyboard, or they might just need to get it
  /// out of the way for a moment, to expose something it's
  /// obscuring. In this case requesting the focus again will not
  /// cause the focus to change, and will not make the keyboard visible.
  ///
  /// This widget builds an [EditableText] and will ensure that the keyboard is
  /// showing when it is tapped by calling
  /// [EditableTextState.requestKeyboard()].
  final FocusNode? focusNode;

  const JNMTagInputField({
    this.value = const [],
    super.key,
    this.label,
    this.errorText,
    this.hintText,
    this.enabled = true,
    this.helperText,
    this.size = JNMTextInputFieldSize.md,
    this.suffixIconAssetName = JNMIcons.chevron_right,
    this.onTap,
    this.focusNode,
    this.isRequired = false,
  });

  @override
  State<JNMTagInputField> createState() => _JNMTagInputFieldState();
}

class _JNMTagInputFieldState extends State<JNMTagInputField> {
  bool _isFocused = false;
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
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry contentPadding;
    if (widget.size == JNMTextInputFieldSize.sm) {
      contentPadding = const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12.0,
      );
    } else {
      contentPadding = const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 14.0,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? JNMInputFieldLabel(
                label: widget.label!,
                isRequired: widget.isRequired,
              )
            : Container(),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
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
                      color: widget.errorText == null
                          ? const Color(0xFFEBF1FF)
                          : const Color(0xFFFEE4E2),
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 4.0,
                    ),
                  ],
          ),
          child: Material(
            color:
                widget.enabled ? JNMColors.white : JNMColors.neutral50,
            borderRadius: BorderRadius.circular(8.0),
            child: InkWell(
              onTap: widget.enabled ? widget.onTap : null,
              focusNode: _focusNode,
              focusColor: JNMColors.white,
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: widget.errorText == null
                        ? _isFocused
                            ? JNMColors.primary200
                            : JNMColors.neutral100
                        : JNMColors.danger300,
                  ),
                ),
                padding: contentPadding,
                child: Row(
                  children: [
                    Expanded(
                      child: widget.value.isEmpty
                          ? Text(
                              widget.hintText ?? '',
                              style: JNMFontFamilies.inter(
                                fontSize: JNMFontSizes.md,
                                fontWeight: JNMFontWeights.regular,
                                color: JNMColors.neutral300,
                              ),
                            )
                          : SingleChildScrollView(
                              primary: false,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: widget.value
                                    .mapIndexed(
                                      (index, item) => Padding(
                                        padding: index > 0
                                            ? const EdgeInsets.only(left: 8.0)
                                            : EdgeInsets.zero,
                                        child: JNMTag(
                                          text: item.label,
                                          size: JNMTagSize.sm,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                    ),
                    const SizedBox(width: 8.0),
                    JNMIcon(
                      widget.suffixIconAssetName,
                      color: JNMColors.neutral300,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        widget.helperText != null &&
                (widget.errorText == null || !widget.enabled)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6.0),
                  Text(
                    widget.helperText!,
                    style: LibraryTextStyles.interXsRegularNeutral300,
                  ),
                ],
              )
            : Container(),
        widget.errorText != null && widget.enabled
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6.0),
                  Text(
                    widget.errorText!,
                    style: LibraryTextStyles.interXsRegularDanger,
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}

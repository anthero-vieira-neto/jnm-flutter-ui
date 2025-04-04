import 'dart:math';

import 'package:jnm_ui/jnm_ui.dart';
import 'package:jnm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// [JNMAutocompleteInputField] option class.
class JNMAutocompleteInputFieldOption<T> {
  /// The option value.
  final T value;

  /// The option title.
  final String title;

  /// The option subtitle.
  final String? subtitle;

  JNMAutocompleteInputFieldOption({
    required this.value,
    required this.title,
    this.subtitle,
  });
}

/// JNM UI's autocomplete input field.
class JNMAutocompleteInputField<T> extends StatefulWidget {
  /// The autocomplete options.
  final List<JNMAutocompleteInputFieldOption<T>> options;

  /// The initial value.
  final T? initialValue;

  /// The callback when value is changed.
  final void Function(T? value) onChanged;

  /// The callback when [JNMTextInputField] value is changed.
  final void Function(String? value)? onTextChanged;

  /// Check icon asset name for selected option.
  final IconData checkIconAssetName;

  /// Suffix icon asset name.
  final IconData suffixIconAssetName;

  /// Maximum height for the options view.
  final double maxOptionsHeight;

  /// The label above the input field.
  final String? label;

  /// The error text if any.
  final String? errorText;

  /// The hint text.
  final String? hintText;

  /// The helper text.
  final String? helperText;

  /// The text field size.
  final JNMTextInputFieldSize textInputSize;

  /// Whether the field is required or not.
  final bool isRequired;

  /// If false the text field is "disabled": it ignores taps and its
  /// [decoration] is rendered in grey.
  ///
  /// If non-null this property overrides the [decoration]'s
  /// [InputDecoration.enabled] property.
  final bool enabled;

  const JNMAutocompleteInputField({
    required this.options,
    required this.onChanged,
    this.label,
    this.hintText,
    this.helperText,
    this.initialValue,
    this.checkIconAssetName = JNMIcons.check,
    this.suffixIconAssetName = JNMIcons.chevron_down,
    this.maxOptionsHeight = 320.0,
    this.errorText,
    this.textInputSize = JNMTextInputFieldSize.md,
    this.enabled = true,
    this.isRequired = false,
    this.onTextChanged,
    super.key,
  });

  @override
  State<JNMAutocompleteInputField<T>> createState() =>
      _JNMAutocompleteInputFieldState<T>();
}

class _JNMAutocompleteInputFieldState<T>
    extends State<JNMAutocompleteInputField<T>> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  JNMAutocompleteInputFieldOption<T>? _value;

  @override
  void initState() {
    super.initState();

    if (widget.initialValue != null) {
      JNMAutocompleteInputFieldOption<T>? initialOption;
      for (var option in widget.options) {
        if (option.value == widget.initialValue) {
          initialOption = option;
        }
      }
      _textEditingController.text = initialOption?.title ?? '';
      _value = initialOption;
    }

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        String lastText = _textEditingController.text;
        JNMAutocompleteInputFieldOption<T>? newValue;
        if (lastText == '') {
        } else {
          for (var option in widget.options) {
            if (option.title == lastText) {
              newValue = option;
            }
          }
          newValue ??= _value;
        }
        setState(() {
          _value = newValue;
        });
        if (newValue == null) {
          _textEditingController.text = '';
        } else {
          _textEditingController.text = newValue.title;
        }
        widget.onChanged(newValue?.value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return RawAutocomplete<JNMAutocompleteInputFieldOption<T>>(
          focusNode: _focusNode,
          textEditingController: _textEditingController,
          displayStringForOption: (value) {
            return value.title;
          },
          onSelected: (value) {
            widget.onChanged(value.value);
          },
          optionsBuilder: (textEditingValue) {
            if (textEditingValue.text == '') {
              return Iterable<JNMAutocompleteInputFieldOption<T>>.empty();
            }
            return widget.options
                .where((JNMAutocompleteInputFieldOption option) {
              return option.title
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            });
          },
          optionsViewBuilder: (context, onSelected, options) {
            return _buildOptionsView(
              constraints: constraints,
              onSelected: onSelected,
              options: options,
            );
          },
          fieldViewBuilder:
              (context, textEditingController, focusNode, onFieldSubmitted) {
            return JNMTextInputField(
              controller: textEditingController,
              onFieldSubmitted: (_) => onFieldSubmitted(),
              onChanged: widget.onTextChanged,
              focusNode: focusNode,
              isRequired: widget.isRequired,
              label: widget.label,
              hintText: widget.hintText,
              helperText: widget.helperText,
              errorText: widget.errorText,
              size: widget.textInputSize,
              enabled: widget.enabled,
              suffixIconAssetName: widget.suffixIconAssetName,
            );
          },
        );
      },
    );
  }

  /// Builds autocomplete options view.
  Widget _buildOptionsView({
    required BoxConstraints constraints,
    required void Function(JNMAutocompleteInputFieldOption<T>) onSelected,
    required Iterable<JNMAutocompleteInputFieldOption<T>> options,
  }) {
    double maxHeight =
        min(48.0 * options.length + 8.0, widget.maxOptionsHeight);
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        child: Container(
          decoration: BoxDecoration(
            color: JNMColors.white,
            borderRadius: BorderRadius.circular(
              JNMBorderRadius.sm,
            ),
            border: Border.all(
              // ignore: deprecated_member_use_from_same_package
              color: JNMColors.grey200, // FIXME
            ),
            boxShadow: JNMBoxShadow.lg,
          ),
          height: maxHeight,
          width: constraints.biggest.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: ListView.builder(
              itemCount: options.length,
              shrinkWrap: false,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                final option = options.elementAt(index);
                return Container(
                  height: 48.0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.0,
                  ),
                  child: Builder(
                    builder: (context) {
                      final bool highlight =
                          AutocompleteHighlightedOption.of(context) == index;
                      if (highlight) {
                        SchedulerBinding.instance
                            .addPostFrameCallback((Duration timeStamp) {
                          Scrollable.ensureVisible(context, alignment: 0.5);
                        });
                      }
                      return Material(
                        color: highlight
                            ? JNMColors.primary100
                            : (_value?.value == option.value
                                ? const Color(0xFFF9FAFB)
                                : JNMColors.white),
                        borderRadius: BorderRadius.circular(6.0),
                        child: InkWell(
                          onTap: () => onSelected(option),
                          borderRadius: BorderRadius.circular(6.0),
                          hoverColor: JNMColors.primary100,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 8.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        option.title,
                                        style: LibraryTextStyles
                                            .interMdMediumNeutral,
                                      ),
                                      option.subtitle != null
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                              ),
                                              child: Text(
                                                option.subtitle!,
                                                style: LibraryTextStyles
                                                    .interMdRegularNeutral400,
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                                _value?.value == option.value
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: JNMIcon(
                                          widget.checkIconAssetName,
                                          color: JNMColors.primary,
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

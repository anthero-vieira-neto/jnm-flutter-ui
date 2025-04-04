import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

class JNMTwoChoiceRadioCard<T> extends StatelessWidget {
  /// The possible values.
  final List<JNMRadioItemModel<T>> items;

  /// The currently selected value for this group of radio buttons.
  final T? groupValue;

  /// Callback when radio button value is changed. Set this value to null to
  /// disable the radio button.
  final ValueChanged<T>? onChanged;

  final JNMRadioButtonSize size;

  const JNMTwoChoiceRadioCard({
    required this.groupValue,
    required this.onChanged,
    required this.items,
    this.size = JNMRadioButtonSize.sm,
    super.key,
  }) : assert(items.length == 2, 'items should have length of 2');

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildRadioCard(context, items[0]),
        const SizedBox(width: 16.0),
        _buildRadioCard(context, items[1]),
      ],
    );
  }

  Widget _buildRadioCard(
    BuildContext context,
    JNMRadioItemModel<T> item,
  ) {
    bool enabled = onChanged != null;
    return Expanded(
      child: Material(
        color: enabled ? JNMColors.white : JNMColors.neutral50,
        borderRadius: BorderRadius.circular(JNMBorderRadius.sm),
        child: InkWell(
          onTap: enabled
              ? () {
                  onChanged!(item.value);
                }
              : null,
          borderRadius: BorderRadius.circular(JNMBorderRadius.sm),
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(JNMBorderRadius.sm),
              border: Border.all(color: JNMColors.neutral100),
            ),
            child: Center(
              child: JNMRadioButton<T>(
                title: item.title,
                value: item.value,
                size: size,
                groupValue: groupValue,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

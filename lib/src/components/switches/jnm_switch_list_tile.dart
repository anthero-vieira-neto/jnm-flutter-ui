import 'package:jnm_ui/jnm_ui.dart';
import 'package:jnm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';

class JNMSwitchListTile extends StatelessWidget {
  final String title;
  final bool value;
  final void Function(bool?)? onChanged;
  final int? maxLinesTitle;
  final String positiveLabel;
  final String negativeLabel;
  final JNMSwitchSize switchSize;

  const JNMSwitchListTile({
    required this.title,
    required this.value,
    this.onChanged,
    this.maxLinesTitle = 2,
    this.positiveLabel = 'Ya',
    this.negativeLabel = 'Tidak',
    this.switchSize = JNMSwitchSize.sm,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: JNMColors.white,
      borderRadius: BorderRadius.circular(JNMBorderRadius.sm),
      child: InkWell(
        onTap: onChanged != null
            ? () {
                onChanged!(!value);
              }
            : null,
        borderRadius: BorderRadius.circular(JNMBorderRadius.sm),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: JNMColors.neutral100),
            borderRadius: BorderRadius.circular(JNMBorderRadius.sm),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    maxLines: maxLinesTitle,
                    overflow: TextOverflow.ellipsis,
                    style: LibraryTextStyles.interSmMediumNeutral,
                  ),
                ),
                const SizedBox(width: 16.0),
                JNMSwitch(
                  value: value,
                  title: value ? positiveLabel : negativeLabel,
                  size: switchSize,
                  onChanged: onChanged,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

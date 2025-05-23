import 'package:jnm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';

/// JNM UI's text input field label.
///
/// This component was made as label for [inputField].
class JNMInputFieldLabel extends StatelessWidget {
  /// The label above the input field.
  final String label;

  /// Whether the field is required or not.
  final bool isRequired;

  const JNMInputFieldLabel({
    required this.label,
    required this.isRequired,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: LibraryTextStyles.interSmMediumNeutral,
            children: <TextSpan>[
              if (isRequired)
                TextSpan(
                  text: '*',
                  style: LibraryTextStyles.interSmMediumDanger,
                ),
            ],
          ),
        ),
        const SizedBox(height: 6.0),
      ],
    );
  }
}

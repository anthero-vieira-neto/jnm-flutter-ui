import 'package:jnm_ui/jnm_ui.dart';
import 'package:jnm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';

/// JNM UI's pagination footer component widget for mobile.
class JNMMobilePaginationFooter extends StatelessWidget {
  /// Current page (starting from 1).
  final int currentPage;

  /// Total number of pages.
  final int numPages;

  /// Callback when previous button is pressed.
  /// Set this to null to disable the button.
  final VoidCallback? onPressedPrevious;

  /// Callback when next button is pressed.
  /// Set this to null to disable the button.
  final VoidCallback? onPressedNext;

  /// Previous button icon asset name.
  final IconData previousIconAssetName;

  /// Next button icon asset name.
  final IconData nextIconAssetName;

  /// Custom formatter for the label at the middle of the footer.
  final String Function(int currentPage, int numPages)? labelTextFormatter;

  const JNMMobilePaginationFooter({
    required this.currentPage,
    required this.numPages,
    required this.onPressedPrevious,
    required this.onPressedNext,
    this.previousIconAssetName = JNMIcons.arrow_left,
    this.nextIconAssetName = JNMIcons.arrow_right,
    this.labelTextFormatter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        JNMOutlineButton.iconOnly(
          iconAssetName: previousIconAssetName,
          onPressed: onPressedPrevious,
          height: JNMButtonHeights.sm,
        ),
        Expanded(
          child: Text(
            labelTextFormatter != null
                ? labelTextFormatter!(currentPage, numPages)
                : 'Page $currentPage of $numPages',
            textAlign: TextAlign.center,
            style: LibraryTextStyles.interSmMediumNeutral300,
          ),
        ),
        JNMOutlineButton.iconOnly(
          iconAssetName: nextIconAssetName,
          onPressed: onPressedNext,
          height: JNMButtonHeights.sm,
        ),
      ],
    );
  }
}

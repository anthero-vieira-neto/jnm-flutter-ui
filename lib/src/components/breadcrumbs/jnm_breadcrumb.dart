import 'package:jnm_ui/jnm_ui.dart';
import 'package:jnm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';

class JNMBreadcrumb extends StatelessWidget {
  final IconData icon;
  final List<String> steps;

  const JNMBreadcrumb({
    required this.icon,
    required this.steps,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> breadcrumbs = [];
    for (var i = 0; i < steps.length; i++) {
      String step = steps[i];
      bool isLastStep = i == steps.length - 1;
      // Add step
      breadcrumbs.add(
        Text(
          step,
          style: !isLastStep
              ? LibraryTextStyles.interSmRegularNeutral400
              : LibraryTextStyles.interSmMediumPrimary500,
        ),
      );
      // Add separator if not last step
      if (!isLastStep) {
        breadcrumbs.addAll([
          const SizedBox(width: 8.0),
          const JNMIcon(
            JNMIcons.chevron_right,
            size: 16,
            color: JNMColors.neutral200,
          ),
          const SizedBox(width: 8.0),
        ]);
      }
    }

    return Row(
      children: [
        JNMIcon(
          icon,
          color: JNMColors.neutral400,
          size: 16.0,
        ),
        const SizedBox(width: 4.0),
        ...breadcrumbs,
      ],
    );
  }
}

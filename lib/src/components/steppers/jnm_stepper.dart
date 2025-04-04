import 'package:jnm_ui/jnm_ui.dart';
import 'package:jnm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';

///The status of each step in the stepper
enum JNMStepperStepStatus {
  uncompleted,
  ongoing,
  completed,
}

class JNMStepperStep {
  /// Stepper's title.
  final String title;

  /// Stepper's subtitle.
  final String subtitle;

  /// Callback when the stapper is tapped.
  final VoidCallback? onTap;

  JNMStepperStep({
    required this.title,
    required this.subtitle,
    this.onTap,
  });
}

/// JNM UI's Stepper component widget.
class JNMStepper extends StatelessWidget {
  final List<JNMStepperStep> steps;
  final int currentStep;

  const JNMStepper({
    required this.steps,
    required this.currentStep,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: steps.asMap().entries.map((entry) {
        int index = entry.key;
        JNMStepperStep step = entry.value;
        JNMStepperStepStatus status = JNMStepperStepStatus.uncompleted;
        if (index < currentStep) {
          status = JNMStepperStepStatus.completed;
        } else if (index == currentStep) {
          status = JNMStepperStepStatus.ongoing;
        }
        return _buildStep(
          status: status,
          title: step.title,
          subtitle: step.subtitle,
          onTap: step.onTap,
          isLast: index >= steps.length - 1,
        );
      }).toList(),
    );
  }

  Widget _buildStep({
    required JNMStepperStepStatus status,
    required bool isLast,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return SizedBox(
      height: 66.0,
      child: Row(
        children: [
          Column(
            children: [
              _buildStepIcon(status),
              const SizedBox(height: 4.0),
              !isLast
                  ? Container(
                      height: 36.0,
                      width: 2.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        color: status == JNMStepperStepStatus.completed
                            ? JNMColors.primary
                            // ignore: deprecated_member_use_from_same_package
                            : JNMColors.grey200, // FIXME
                      ),
                    )
                  : Container(),
            ],
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: LibraryTextStyles.interSmSemiboldGrey700,
                    ),
                    Text(
                      subtitle,
                      style: LibraryTextStyles.interSmRegularGrey600,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIcon(JNMStepperStepStatus status) {
    Color color;
    Widget child;
    switch (status) {
      case JNMStepperStepStatus.uncompleted:
        // ignore: deprecated_member_use_from_same_package
        color = JNMColors.grey100; // FIXME
        child = Container(
          height: 8.0,
          width: 8.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: JNMColors.white,
          ),
        );
        break;
      case JNMStepperStepStatus.ongoing:
        color = JNMColors.primary;
        child = Container(
          height: 8.0,
          width: 8.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: JNMColors.white,
          ),
        );
        break;
      case JNMStepperStepStatus.completed:
        color = JNMColors.primary;
        child = const SizedBox(
          height: 14.0,
          width: 14.0,
          child: JNMIcon(
            JNMIcons.check,
            color: Colors.white,
          ),
        );
        break;
    }
    return Container(
      height: 24.0,
      width: 24.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Center(
        child: child,
      ),
    );
  }
}

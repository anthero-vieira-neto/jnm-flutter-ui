import 'package:jnm_ui/jnm_ui.dart';
import 'package:jnm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';

// FIXME: Move this somewhere else
const mobileMaxWidth = 600;
// FIXME: Move this somewhere else
const mobileDialogMaxWidth = 480.0;

enum JNMConfirmAlertDialogSize {
  adaptive,
  desktop,
  mobile,
}

class JNMConfirmAlertDialog {
  /// Dialog's title
  final String title;

  /// Dialog's subtitle
  final String subtitle;

  /// Positive button text
  final String? positiveText;

  /// Negative button text
  final String? negativeText;

  /// Callback on positive button
  final VoidCallback? onPositiveButton;

  /// Callback on negative button
  final VoidCallback? onNegativeButton;

  /// Dialog's variant.
  final JNMDialogVariant variant;

  /// Dialog's size.
  final JNMConfirmAlertDialogSize size;

  /// Dialog's max width.
  final double maxWidth;

  // Dialog's icon asset name.
  final IconData? iconAssetName;

  const JNMConfirmAlertDialog({
    required this.title,
    required this.subtitle,
    this.onPositiveButton,
    this.onNegativeButton,
    this.positiveText,
    this.negativeText,
    this.variant = JNMDialogVariant.basic,
    this.size = JNMConfirmAlertDialogSize.adaptive,
    this.maxWidth = mobileDialogMaxWidth,
    this.iconAssetName,
  });

  Future<T?> show<T>(BuildContext context) {
    IconData finalIcon;
    late JNMIconRippleVariant iconRippleVariant;
    bool isPositiveButtonDestructive = false;
    switch (variant) {
      case JNMDialogVariant.primary:
        finalIcon = iconAssetName ?? JNMIcons.check_circle;
        iconRippleVariant = JNMIconRippleVariant.primary;
        break;
      case JNMDialogVariant.success:
        finalIcon = iconAssetName ?? JNMIcons.check_circle;
        iconRippleVariant = JNMIconRippleVariant.success;
        break;
      case JNMDialogVariant.warning:
        finalIcon = iconAssetName ?? JNMIcons.alert_triangle;
        iconRippleVariant = JNMIconRippleVariant.warning;
        break;
      case JNMDialogVariant.danger:
        finalIcon = iconAssetName ?? JNMIcons.alert_triangle;
        isPositiveButtonDestructive = true;
        iconRippleVariant = JNMIconRippleVariant.danger;
        break;
      case JNMDialogVariant.basic:
      default:
        finalIcon = iconAssetName ?? JNMIcons.info_circle;
        iconRippleVariant = JNMIconRippleVariant.defaultV;
        break;
    }

    return JNMUiUtils.showJNMDialog<T>(
      context: context,
      builder: (context) {
        return _buildDialog(
          context: context,
          finalIcon: finalIcon,
          iconRippleVariant: iconRippleVariant,
          isPositiveButtonDestructive: isPositiveButtonDestructive,
        );
      },
    );
  }

  Widget _buildDialog({
    required BuildContext context,
    required IconData finalIcon,
    required JNMIconRippleVariant iconRippleVariant,
    required bool isPositiveButtonDestructive,
  }) {
    bool useMobile = true;
    switch (size) {
      case JNMConfirmAlertDialogSize.mobile:
        useMobile = true;
        break;
      case JNMConfirmAlertDialogSize.desktop:
        useMobile = false;
        break;
      case JNMConfirmAlertDialogSize.adaptive:
        useMobile = MediaQuery.of(context).size.width < mobileMaxWidth;
        break;
    }
    bool isBuildNegativeButton = negativeText?.isNotEmpty == true;
    bool isBuildPositiveButton = positiveText?.isNotEmpty == true;
    if (useMobile) {
      return _buildMobileDialog(
        context: context,
        finalIcon: finalIcon,
        iconRippleVariant: iconRippleVariant,
        isPositiveButtonDestructive: isPositiveButtonDestructive,
        isBuildNegativeButton: isBuildNegativeButton,
        isBuildPositiveButton: isBuildPositiveButton,
      );
    } else {
      return _buildDesktopDialog(
        context: context,
        finalIcon: finalIcon,
        iconRippleVariant: iconRippleVariant,
        isPositiveButtonDestructive: isPositiveButtonDestructive,
        isBuildNegativeButton: isBuildNegativeButton,
        isBuildPositiveButton: isBuildPositiveButton,
      );
    }
  }

  Widget _buildMobileDialog({
    required BuildContext context,
    required IconData finalIcon,
    required JNMIconRippleVariant iconRippleVariant,
    required bool isPositiveButtonDestructive,
    required bool isBuildNegativeButton,
    required bool isBuildPositiveButton,
  }) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(JNMBorderRadius.md),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                right: 16.0,
                left: 16.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  JNMIconRipple(
                    iconAssetName: finalIcon,
                    variant: iconRippleVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: LibraryTextStyles.poppinsLgSemiboldNeutral,
                  ),
                  Text(
                    subtitle,
                    style: LibraryTextStyles.interSmRegularNeutral300,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const JNMDivider(height: 0.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isBuildPositiveButton)
                    SizedBox(
                      width: double.infinity,
                      child: JNMPrimaryButton.text(
                        height: JNMAvatarSizes.lg,
                        text: positiveText!,
                        onPressed: onPositiveButton,
                        isDestructive: isPositiveButtonDestructive,
                      ),
                    ),
                  if (isBuildPositiveButton && isBuildNegativeButton)
                    const SizedBox(height: 8),
                  if (isBuildNegativeButton)
                    SizedBox(
                      width: double.infinity,
                      child: JNMOutlineButton.text(
                        height: JNMAvatarSizes.lg,
                        text: negativeText!,
                        onPressed: onNegativeButton,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopDialog({
    required BuildContext context,
    required IconData finalIcon,
    required JNMIconRippleVariant iconRippleVariant,
    required bool isPositiveButtonDestructive,
    required bool isBuildNegativeButton,
    required bool isBuildPositiveButton,
  }) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(JNMBorderRadius.md),
      ),
      backgroundColor: JNMColors.white,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth, minWidth: 200),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      JNMIconRipple(
                        iconAssetName: finalIcon,
                        variant: iconRippleVariant,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const JNMIcon(
                          JNMIcons.x_close,
                          color: JNMColors.neutral300,
                          size: 24.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    title,
                    style: LibraryTextStyles.poppinsXlSemiboldNeutral,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    subtitle,
                    style: LibraryTextStyles.interMdRegularNeutral300,
                  ),
                ],
              ),
            ),
            const JNMDivider(height: 0.0),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  if (isBuildNegativeButton)
                    Expanded(
                      child: JNMOutlineButton.text(
                        height: JNMAvatarSizes.lg,
                        text: negativeText!,
                        onPressed: onNegativeButton,
                      ),
                    ),
                  if (isBuildNegativeButton && isBuildPositiveButton)
                    const SizedBox(width: 12.0),
                  if (isBuildPositiveButton)
                    Expanded(
                      child: JNMPrimaryButton.text(
                        height: JNMAvatarSizes.lg,
                        text: positiveText!,
                        onPressed: onPositiveButton,
                        isDestructive: isPositiveButtonDestructive,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

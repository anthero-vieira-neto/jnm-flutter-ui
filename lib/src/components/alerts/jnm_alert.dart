import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

/// [JNMAlert] possible sizes.
enum JNMAlertSize {
  mobile,
  desktop,
}

class JNMAlert extends StatelessWidget {
  /// The alert variant.
  final JNMAlertVariant variant;

  /// The alert title text.
  final String? text;

  /// The alert subtitle text.
  final String? subtitle;

  /// The callback when close alert.
  final VoidCallback? onClose;

  /// The callback of secondary action button.
  final String? secondaryActionText;

  /// The callback of secondary action button.
  final VoidCallback? onPressedSecondaryAction;

  /// The callback of primary action button.
  final String? primaryActionText;

  /// The callback of primary action button.
  final VoidCallback? onPressedPrimaryAction;

  /// The alert size.
  final JNMAlertSize size;

  /// The alert theme data.
  final JNMAlertThemeData alertThemeData;

  const JNMAlert({
    required this.variant,
    this.text,
    this.onClose,
    this.size = JNMAlertSize.mobile,
    this.alertThemeData = const JNMAlertThemeData(),
    this.subtitle,
    this.secondaryActionText,
    this.onPressedSecondaryAction,
    this.primaryActionText,
    this.onPressedPrimaryAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    JNMAlertThemeData theme =
        JNMAlertTheme.of(context)?.alertThemeData ?? alertThemeData;

    late IconData assetNameIcon;
    late Color iconColor;
    late Color backgroundColor;
    late Color borderColor;
    late Color titleTextColor;
    late Color subtitleTextColor;
    late Color closeIconColor;
    late JNMLinkButtonThemeData primaryButtonTheme;
    late JNMLinkButtonThemeData secondaryButtonTheme;

    switch (variant) {
      case JNMAlertVariant.defaultV:
        assetNameIcon = JNMIcons.info_circle;
        iconColor = JNMColors.neutral400;
        backgroundColor = JNMColors.white;
        borderColor = JNMColors.neutral100;
        titleTextColor = JNMColors.neutral;
        subtitleTextColor = JNMColors.neutral400;
        closeIconColor = JNMColors.neutral300;
        secondaryButtonTheme = JNMLinkButtonThemeData.neutral();
        primaryButtonTheme = const JNMLinkButtonThemeData();
        break;
      case JNMAlertVariant.primary:
        assetNameIcon = JNMIcons.info_circle;
        iconColor = theme.iconColor;
        backgroundColor = theme.backgroundColor;
        borderColor = theme.borderColor;
        titleTextColor = theme.titleTextColor;
        subtitleTextColor = theme.subtitleTextColor;
        closeIconColor = theme.closeIconColor;
        secondaryButtonTheme = theme.secondaryButtonTheme;
        primaryButtonTheme = theme.primaryButtonTheme;
        break;
      case JNMAlertVariant.danger:
        assetNameIcon = JNMIcons.alert_triangle;
        iconColor = JNMColors.danger600;
        backgroundColor = JNMColors.danger100;
        borderColor = JNMColors.danger200;
        titleTextColor = JNMColors.danger600;
        subtitleTextColor = JNMColors.danger600;
        closeIconColor = JNMColors.danger400;
        secondaryButtonTheme = const JNMLinkButtonThemeData(
          onPrimaryColor: JNMColors.danger500,
        );
        primaryButtonTheme = const JNMLinkButtonThemeData(
          onPrimaryColor: JNMColors.danger600,
        );
        break;
      case JNMAlertVariant.warning:
        assetNameIcon = JNMIcons.alert_triangle;
        iconColor = JNMColors.warning700;
        backgroundColor = JNMColors.warning100;
        borderColor = JNMColors.warning200;
        titleTextColor = JNMColors.warning700;
        subtitleTextColor = JNMColors.warning700;
        closeIconColor = JNMColors.warning400;
        secondaryButtonTheme = const JNMLinkButtonThemeData(
          onPrimaryColor: JNMColors.warning600,
        );
        primaryButtonTheme = const JNMLinkButtonThemeData(
          onPrimaryColor: JNMColors.warning700,
        );
        break;
      case JNMAlertVariant.success:
        assetNameIcon = JNMIcons.check_circle;
        iconColor = JNMColors.success700;
        backgroundColor = JNMColors.success100;
        borderColor = JNMColors.success200;
        titleTextColor = JNMColors.success700;
        subtitleTextColor = JNMColors.success700;
        closeIconColor = JNMColors.success400;
        secondaryButtonTheme = const JNMLinkButtonThemeData(
          onPrimaryColor: JNMColors.success600,
        );
        primaryButtonTheme = const JNMLinkButtonThemeData(
          onPrimaryColor: JNMColors.success700,
        );
        break;
      case JNMAlertVariant.info:
        assetNameIcon = JNMIcons.info_circle;
        iconColor = JNMColors.info700;
        backgroundColor = JNMColors.info100;
        borderColor = JNMColors.info200;
        titleTextColor = JNMColors.info700;
        subtitleTextColor = JNMColors.info700;
        closeIconColor = JNMColors.info400;
        secondaryButtonTheme = const JNMLinkButtonThemeData(
          onPrimaryColor: JNMColors.info500,
        );
        primaryButtonTheme = const JNMLinkButtonThemeData(
          onPrimaryColor: JNMColors.info700,
        );
        break;
    }

    late EdgeInsets padding;
    switch (size) {
      case JNMAlertSize.mobile:
        padding = const EdgeInsets.all(12.0);
        break;
      case JNMAlertSize.desktop:
        padding = const EdgeInsets.all(16.0);
        break;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          JNMBorderRadius.md,
        ),
        border: Border.all(
          color: borderColor,
        ),
        color: backgroundColor,
      ),
      child: Padding(
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            JNMIcon(
              assetNameIcon,
              color: iconColor,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (text?.isNotEmpty == true) ...[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            text!,
                            style: JNMFontFamilies.inter(
                              fontSize: JNMFontSizes.sm,
                              fontWeight: JNMFontWeights.semibold,
                              color: titleTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (text?.isNotEmpty == true &&
                      subtitle?.isNotEmpty == true) ...[
                    const SizedBox(height: 4.0),
                  ],
                  if (subtitle?.isNotEmpty == true) ...[
                    Text(
                      subtitle!,
                      style: JNMFontFamilies.inter(
                        fontSize: JNMFontSizes.sm,
                        fontWeight: JNMFontWeights.regular,
                        color: subtitleTextColor,
                      ),
                    ),
                  ],
                  _buildActions(secondaryButtonTheme, primaryButtonTheme),
                ],
              ),
            ),
            if (onClose != null) ...[
              const SizedBox(width: 12.0),
              InkWell(
                onTap: onClose,
                child: JNMIcon(
                  JNMIcons.x_close,
                  color: closeIconColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActions(
    JNMLinkButtonThemeData secondaryButtonTheme,
    JNMLinkButtonThemeData primaryButtonTheme,
  ) {
    bool showSecondaryAction = secondaryActionText?.isNotEmpty == true &&
        onPressedSecondaryAction != null;
    bool showPrimaryAction =
        primaryActionText?.isNotEmpty == true && onPressedPrimaryAction != null;
    // No actions.
    if (!showSecondaryAction && !showPrimaryAction) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12.0),
        Row(
          children: [
            // Builds secondary action if exists.
            if (showSecondaryAction)
              JNMLinkPrimaryButton.text(
                text: secondaryActionText!,
                onPressed: onPressedSecondaryAction,
                buttonThemeData: secondaryButtonTheme,
              ),
            // Builds margin if both actions exist.
            if (showSecondaryAction && showPrimaryAction)
              const SizedBox(width: 12.0),
            // Builds primary action if exists.
            if (showPrimaryAction)
              JNMLinkPrimaryButton.text(
                text: primaryActionText!,
                onPressed: onPressedPrimaryAction,
                buttonThemeData: primaryButtonTheme,
              ),
          ],
        ),
      ],
    );
  }
}

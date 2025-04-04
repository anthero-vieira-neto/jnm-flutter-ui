import 'package:jnm_ui/jnm_ui.dart';
import 'package:jnm_ui/src/components/badges/jnm_base_badge.dart';
import 'package:flutter/material.dart';

/// JNM's filled badge widget.
class JNMFilledBadge extends StatelessWidget {
  /// The badge's content.
  final Widget child;

  /// The badge's size.
  final JNMBadgeSize size;

  /// The badge's variant.
  final JNMBadgeVariant variant;

  /// The content padding.
  final EdgeInsetsGeometry? contentPadding;

  /// Callback when the badge is tapped.
  final VoidCallback? onTap;

  const JNMFilledBadge({
    required this.child,
    this.size = JNMBadgeSize.md,
    this.variant = JNMBadgeVariant.defaultV,
    this.contentPadding,
    this.onTap,
    super.key,
  });

  /// Creates [JNMFilledBadge] with only [text] as a content.
  factory JNMFilledBadge.text(
    String text, {
    JNMBadgeSize size = JNMBadgeSize.md,
    JNMBadgeVariant variant = JNMBadgeVariant.defaultV,
    VoidCallback? onTap,
  }) {
    EdgeInsetsGeometry contentPadding;
    double fontSize;
    switch (size) {
      case JNMBadgeSize.sm:
        contentPadding = const EdgeInsets.only(
          top: 2.0,
          bottom: 2.0,
          right: 8.0,
          left: 8.0,
        );
        fontSize = JNMFontSizes.xs;
        break;
      case JNMBadgeSize.lg:
        contentPadding = const EdgeInsets.only(
          top: 4.0,
          bottom: 4.0,
          right: 12.0,
          left: 12.0,
        );
        fontSize = JNMFontSizes.sm;
        break;
      case JNMBadgeSize.md:
      default:
        contentPadding = const EdgeInsets.only(
          top: 2.0,
          bottom: 2.0,
          right: 10.0,
          left: 10.0,
        );
        fontSize = JNMFontSizes.sm;
        break;
    }

    Color textColor;
    switch (variant) {
      case JNMBadgeVariant.primary:
        textColor = JNMColors.primary700;
        break;
      case JNMBadgeVariant.danger:
        textColor = JNMColors.danger700;
        break;
      case JNMBadgeVariant.warning:
        textColor = JNMColors.warning700;
        break;
      case JNMBadgeVariant.success:
        textColor = JNMColors.success700;
        break;
      case JNMBadgeVariant.info:
        textColor = JNMColors.info700;
        break;
      case JNMBadgeVariant.defaultV:
      default:
        textColor = JNMColors.neutral;
        break;
    }
    return JNMFilledBadge(
      size: size,
      variant: variant,
      contentPadding: contentPadding,
      onTap: onTap,
      child: Text(
        text,
        style: JNMFontFamilies.inter(
          fontWeight: JNMFontWeights.medium,
          fontSize: fontSize,
          color: textColor,
        ),
      ),
    );
  }

  /// Creates [JNMFilledBadge] with [text] and a leading dot as content.
  factory JNMFilledBadge.dot(
    String text, {
    JNMBadgeSize size = JNMBadgeSize.md,
    JNMBadgeVariant variant = JNMBadgeVariant.defaultV,
    VoidCallback? onTap,
  }) {
    EdgeInsetsGeometry contentPadding;
    double fontSize;
    double dotMargin;
    switch (size) {
      case JNMBadgeSize.sm:
        contentPadding = const EdgeInsets.only(
          top: 2.0,
          bottom: 2.0,
          right: 8.0,
          left: 7.0,
        );
        fontSize = JNMFontSizes.xs;
        dotMargin = 5.0;
        break;
      case JNMBadgeSize.lg:
        contentPadding = const EdgeInsets.only(
          top: 4.0,
          bottom: 4.0,
          right: 12.0,
          left: 11.0,
        );
        fontSize = JNMFontSizes.sm;
        dotMargin = 7.0;
        break;
      case JNMBadgeSize.md:
      default:
        contentPadding = const EdgeInsets.only(
          top: 2.0,
          bottom: 2.0,
          right: 10.0,
          left: 9.0,
        );
        fontSize = JNMFontSizes.sm;
        dotMargin = 7.0;
        break;
    }
    Color textColor;
    Color dotColor;
    switch (variant) {
      case JNMBadgeVariant.primary:
        textColor = JNMColors.primary700;
        dotColor = JNMColors.primary500;
        break;
      case JNMBadgeVariant.danger:
        textColor = JNMColors.danger700;
        dotColor = JNMColors.danger500;
        break;
      case JNMBadgeVariant.warning:
        textColor = JNMColors.warning700;
        dotColor = JNMColors.warning500;
        break;
      case JNMBadgeVariant.success:
        textColor = JNMColors.success700;
        dotColor = JNMColors.success500;
        break;
      case JNMBadgeVariant.info:
        textColor = JNMColors.info700;
        dotColor = JNMColors.info700;
        break;
      case JNMBadgeVariant.defaultV:
      default:
        textColor = JNMColors.neutral;
        dotColor = JNMColors.neutral400;
        break;
    }
    return JNMFilledBadge(
      size: size,
      variant: variant,
      contentPadding: contentPadding,
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: 6.0,
            width: 6.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: dotColor,
            ),
          ),
          SizedBox(width: dotMargin),
          Text(
            text,
            style: JNMFontFamilies.inter(
              fontWeight: JNMFontWeights.medium,
              fontSize: fontSize,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  /// Creates [JNMFilledBadge] with [text] and a leading [JNMAvatar]
  /// as content.
  factory JNMFilledBadge.avatar(
    String text,
    JNMAvatar avatar, {
    JNMBadgeSize size = JNMBadgeSize.md,
    JNMBadgeVariant variant = JNMBadgeVariant.defaultV,
    VoidCallback? onTap,
  }) {
    EdgeInsetsGeometry contentPadding;
    double fontSize;
    switch (size) {
      case JNMBadgeSize.sm:
        contentPadding = const EdgeInsets.only(
          top: 2.0,
          bottom: 2.0,
          right: 8.0,
          left: 3.0,
        );
        fontSize = JNMFontSizes.xs;
        break;
      case JNMBadgeSize.lg:
        contentPadding = const EdgeInsets.only(
          top: 4.0,
          bottom: 4.0,
          right: 12.0,
          left: 6.0,
        );
        fontSize = JNMFontSizes.sm;
        break;
      case JNMBadgeSize.md:
      default:
        contentPadding = const EdgeInsets.only(
          top: 2.0,
          bottom: 2.0,
          right: 10.0,
          left: 4.0,
        );
        fontSize = JNMFontSizes.sm;
        break;
    }
    Color textColor;
    switch (variant) {
      case JNMBadgeVariant.primary:
        textColor = JNMColors.primary700;
        break;
      case JNMBadgeVariant.danger:
        textColor = JNMColors.danger700;
        break;
      case JNMBadgeVariant.warning:
        textColor = JNMColors.warning700;
        break;
      case JNMBadgeVariant.success:
        textColor = JNMColors.success700;
        break;
      case JNMBadgeVariant.info:
        textColor = JNMColors.info700;
        break;
      case JNMBadgeVariant.defaultV:
      default:
        textColor = JNMColors.neutral;
        break;
    }
    return JNMFilledBadge(
      size: size,
      variant: variant,
      contentPadding: contentPadding,
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            height: 16.0,
            width: 16.0,
            child: avatar,
          ),
          const SizedBox(width: 6.0),
          Text(
            text,
            style: JNMFontFamilies.inter(
              fontWeight: JNMFontWeights.medium,
              fontSize: fontSize,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  /// Creates [JNMFilledBadge] with [text] and a trailing cancel icon
  /// as content.
  factory JNMFilledBadge.cancel(
    String text, {
    JNMBadgeSize size = JNMBadgeSize.md,
    JNMBadgeVariant variant = JNMBadgeVariant.defaultV,
    IconData cancelIconAssetName = JNMIcons.x_close,
    VoidCallback? onTap,
  }) {
    EdgeInsetsGeometry contentPadding;
    double fontSize;
    switch (size) {
      case JNMBadgeSize.sm:
        contentPadding = const EdgeInsets.only(
          top: 2.0,
          bottom: 2.0,
          right: 5.0,
          left: 8.0,
        );
        fontSize = JNMFontSizes.xs;
        break;
      case JNMBadgeSize.lg:
        contentPadding = const EdgeInsets.only(
          top: 4.0,
          bottom: 4.0,
          right: 10.0,
          left: 12.0,
        );
        fontSize = JNMFontSizes.sm;
        break;
      case JNMBadgeSize.md:
      default:
        contentPadding = const EdgeInsets.only(
          top: 2.0,
          bottom: 2.0,
          right: 8.0,
          left: 10.0,
        );
        fontSize = JNMFontSizes.sm;
        break;
    }
    Color textColor;
    Color iconColor;
    switch (variant) {
      case JNMBadgeVariant.primary:
        textColor = JNMColors.primary700;
        iconColor = JNMColors.primary500;
        break;
      case JNMBadgeVariant.danger:
        textColor = JNMColors.danger700;
        iconColor = JNMColors.danger500;
        break;
      case JNMBadgeVariant.warning:
        textColor = JNMColors.warning700;
        iconColor = JNMColors.warning500;
        break;
      case JNMBadgeVariant.success:
        textColor = JNMColors.success700;
        iconColor = JNMColors.success500;
        break;
      case JNMBadgeVariant.info:
        textColor = JNMColors.info700;
        iconColor = JNMColors.info700;
        break;
      case JNMBadgeVariant.defaultV:
      default:
        textColor = JNMColors.neutral;
        iconColor = JNMColors.neutral400;
        break;
    }
    return JNMFilledBadge(
      size: size,
      variant: variant,
      contentPadding: contentPadding,
      onTap: onTap,
      child: Row(
        children: [
          Text(
            text,
            style: JNMFontFamilies.inter(
              fontWeight: JNMFontWeights.medium,
              fontSize: fontSize,
              color: textColor,
            ),
          ),
          const SizedBox(width: 4.0),
          JNMIcon(
            cancelIconAssetName,
            size: 12.0,
            color: iconColor,
          ),
        ],
      ),
    );
  }

  /// Creates [JNMFilledBadge] with only an icon as content.
  factory JNMFilledBadge.iconOnly(
    IconData iconAssetName, {
    JNMBadgeSize size = JNMBadgeSize.md,
    JNMBadgeVariant variant = JNMBadgeVariant.defaultV,
    VoidCallback? onTap,
  }) {
    EdgeInsetsGeometry contentPadding;
    switch (size) {
      case JNMBadgeSize.sm:
        contentPadding = const EdgeInsets.all(4.0);
        break;
      case JNMBadgeSize.lg:
        contentPadding = const EdgeInsets.all(8.0);
        break;
      case JNMBadgeSize.md:
      default:
        contentPadding = const EdgeInsets.all(6.0);
        break;
    }
    Color iconColor;
    switch (variant) {
      case JNMBadgeVariant.primary:
        iconColor = JNMColors.primary500;
        break;
      case JNMBadgeVariant.danger:
        iconColor = JNMColors.danger500;
        break;
      case JNMBadgeVariant.warning:
        iconColor = JNMColors.warning500;
        break;
      case JNMBadgeVariant.success:
        iconColor = JNMColors.success500;
        break;
      case JNMBadgeVariant.info:
        iconColor = JNMColors.info700;
        break;
      case JNMBadgeVariant.defaultV:
      default:
        iconColor = JNMColors.neutral400;
        break;
    }
    return JNMFilledBadge(
      size: size,
      variant: variant,
      contentPadding: contentPadding,
      onTap: onTap,
      child: JNMIcon(
        iconAssetName,
        size: 12.0,
        color: iconColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    switch (variant) {
      case JNMBadgeVariant.primary:
        backgroundColor = JNMColors.primary100;
        break;
      case JNMBadgeVariant.danger:
        backgroundColor = JNMColors.danger100;
        break;
      case JNMBadgeVariant.warning:
        backgroundColor = JNMColors.warning100;
        break;
      case JNMBadgeVariant.success:
        backgroundColor = JNMColors.success100;
        break;
      case JNMBadgeVariant.info:
        backgroundColor = JNMColors.info100;
        break;
      case JNMBadgeVariant.defaultV:
      default:
        backgroundColor = JNMColors.neutral100;
        break;
    }

    return JNMBaseBadge(
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
      backgroundColor: backgroundColor,
      onTap: onTap,
      child: child,
    );
  }
}

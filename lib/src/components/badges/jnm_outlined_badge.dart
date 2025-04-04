import 'package:jnm_ui/jnm_ui.dart';
import 'package:jnm_ui/src/components/badges/jnm_base_badge.dart';
import 'package:flutter/material.dart';

/// JNM's outlined badge widget.
class JNMOutlinedBadge extends StatelessWidget {
  /// The badge's content.
  final Widget child;

  /// The badge's size.
  final JNMBadgeSize size;

  /// The badge's variant.
  final JNMBadgeVariant variant;

  /// The border width.
  final double borderWidth;

  /// The content padding.
  final EdgeInsetsGeometry? contentPadding;

  /// Callback when the badge is tapped.
  final VoidCallback? onTap;

  const JNMOutlinedBadge({
    required this.child,
    this.size = JNMBadgeSize.md,
    this.variant = JNMBadgeVariant.defaultV,
    this.borderWidth = 1.5,
    this.contentPadding,
    this.onTap,
    super.key,
  });

  /// Creates [JNMOutlinedBadge] with only [text] as a content.
  factory JNMOutlinedBadge.text(
    String text, {
    JNMBadgeSize size = JNMBadgeSize.md,
    JNMBadgeVariant variant = JNMBadgeVariant.defaultV,
    VoidCallback? onTap,
    double borderWidth = 1.5,
  }) {
    EdgeInsetsGeometry contentPadding;
    double fontSize;
    switch (size) {
      case JNMBadgeSize.sm:
        contentPadding = EdgeInsets.symmetric(
          vertical: 2.0 - borderWidth,
          horizontal: 8.0 - borderWidth,
        );
        fontSize = JNMFontSizes.xs;
        break;
      case JNMBadgeSize.lg:
        contentPadding = EdgeInsets.symmetric(
          vertical: 4.0 - borderWidth,
          horizontal: 12.0 - borderWidth,
        );
        fontSize = JNMFontSizes.sm;
        break;
      case JNMBadgeSize.md:
      default:
        contentPadding = EdgeInsets.symmetric(
          vertical: 2.0 - borderWidth,
          horizontal: 10.0 - borderWidth,
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
        textColor = JNMColors.neutral400;
        break;
    }
    return JNMOutlinedBadge(
      size: size,
      variant: variant,
      contentPadding: contentPadding,
      onTap: onTap,
      borderWidth: borderWidth,
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

  /// Creates [JNMOutlinedBadge] with [text] and a leading dot as content.
  factory JNMOutlinedBadge.dot(
    String text, {
    JNMBadgeSize size = JNMBadgeSize.md,
    JNMBadgeVariant variant = JNMBadgeVariant.defaultV,
    VoidCallback? onTap,
    double borderWidth = 1.5,
  }) {
    EdgeInsetsGeometry contentPadding;
    double fontSize;
    double dotMargin;
    switch (size) {
      case JNMBadgeSize.sm:
        contentPadding = EdgeInsets.only(
          top: 2.0 - borderWidth,
          bottom: 2.0 - borderWidth,
          right: 8.0 - borderWidth,
          left: 7.0 - borderWidth,
        );
        fontSize = JNMFontSizes.xs;
        dotMargin = 5.0;
        break;
      case JNMBadgeSize.lg:
        contentPadding = EdgeInsets.only(
          top: 4.0 - borderWidth,
          bottom: 4.0 - borderWidth,
          right: 12.0 - borderWidth,
          left: 11.0 - borderWidth,
        );
        fontSize = JNMFontSizes.sm;
        dotMargin = 7.0;
        break;
      case JNMBadgeSize.md:
      default:
        contentPadding = EdgeInsets.only(
          top: 2.0 - borderWidth,
          bottom: 2.0 - borderWidth,
          right: 10.0 - borderWidth,
          left: 9.0 - borderWidth,
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
        dotColor = JNMColors.danger600;
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
        textColor = JNMColors.neutral400;
        dotColor = JNMColors.neutral400;
        break;
    }
    return JNMOutlinedBadge(
      size: size,
      variant: variant,
      contentPadding: contentPadding,
      onTap: onTap,
      borderWidth: borderWidth,
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

  /// Creates [JNMOutlinedBadge] with [text] and a leading [JNMAvatar]
  /// as content.
  factory JNMOutlinedBadge.avatar(
    String text,
    JNMAvatar avatar, {
    JNMBadgeSize size = JNMBadgeSize.md,
    JNMBadgeVariant variant = JNMBadgeVariant.defaultV,
    VoidCallback? onTap,
    double borderWidth = 1.5,
  }) {
    EdgeInsetsGeometry contentPadding;
    double fontSize;
    switch (size) {
      case JNMBadgeSize.sm:
        contentPadding = EdgeInsets.only(
          top: 2.0 - borderWidth,
          bottom: 2.0 - borderWidth,
          right: 8.0 - borderWidth,
          left: 3.0 - borderWidth,
        );
        fontSize = JNMFontSizes.xs;
        break;
      case JNMBadgeSize.lg:
        contentPadding = EdgeInsets.only(
          top: 4.0 - borderWidth,
          bottom: 4.0 - borderWidth,
          right: 12.0 - borderWidth,
          left: 6.0 - borderWidth,
        );
        fontSize = JNMFontSizes.sm;
        break;
      case JNMBadgeSize.md:
      default:
        contentPadding = EdgeInsets.only(
          top: 2.0 - borderWidth,
          bottom: 2.0 - borderWidth,
          right: 10.0 - borderWidth,
          left: 4.0 - borderWidth,
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
        textColor = JNMColors.neutral400;
        break;
    }
    return JNMOutlinedBadge(
      size: size,
      variant: variant,
      contentPadding: contentPadding,
      onTap: onTap,
      borderWidth: borderWidth,
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

  /// Creates [JNMOutlinedBadge] with [text] and a trailing cancel icon
  /// as content.
  factory JNMOutlinedBadge.cancel(
    String text, {
    JNMBadgeSize size = JNMBadgeSize.md,
    JNMBadgeVariant variant = JNMBadgeVariant.defaultV,
    IconData cancelIconAssetName = JNMIcons.x_close,
    double borderWidth = 1.5,
    VoidCallback? onTap,
  }) {
    EdgeInsetsGeometry contentPadding;
    double fontSize;
    switch (size) {
      case JNMBadgeSize.sm:
        contentPadding = EdgeInsets.only(
          top: 2.0 - borderWidth,
          bottom: 2.0 - borderWidth,
          right: 5.0 - borderWidth,
          left: 8.0 - borderWidth,
        );
        fontSize = JNMFontSizes.xs;
        break;
      case JNMBadgeSize.lg:
        contentPadding = EdgeInsets.only(
          top: 4.0 - borderWidth,
          bottom: 4.0 - borderWidth,
          right: 10.0 - borderWidth,
          left: 12.0 - borderWidth,
        );
        fontSize = JNMFontSizes.sm;
        break;
      case JNMBadgeSize.md:
      default:
        contentPadding = EdgeInsets.only(
          top: 2.0 - borderWidth,
          bottom: 2.0 - borderWidth,
          right: 8.0 - borderWidth,
          left: 10.0 - borderWidth,
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
        iconColor = JNMColors.danger600;
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
        textColor = JNMColors.neutral400;
        iconColor = JNMColors.neutral400;
        break;
    }
    return JNMOutlinedBadge(
      size: size,
      variant: variant,
      contentPadding: contentPadding,
      onTap: onTap,
      borderWidth: borderWidth,
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

  /// Creates [JNMOutlinedBadge] with only an icon as content.
  factory JNMOutlinedBadge.iconOnly(
    IconData iconAssetName, {
    JNMBadgeSize size = JNMBadgeSize.md,
    JNMBadgeVariant variant = JNMBadgeVariant.defaultV,
    VoidCallback? onTap,
    double borderWidth = 1.5,
  }) {
    EdgeInsetsGeometry contentPadding;
    switch (size) {
      case JNMBadgeSize.sm:
        contentPadding = EdgeInsets.all(4.0 - borderWidth);
        break;
      case JNMBadgeSize.lg:
        contentPadding = EdgeInsets.all(8.0 - borderWidth);
        break;
      case JNMBadgeSize.md:
      default:
        contentPadding = EdgeInsets.all(6.0 - borderWidth);
        break;
    }
    Color iconColor;
    switch (variant) {
      case JNMBadgeVariant.primary:
        iconColor = JNMColors.primary500;
        break;
      case JNMBadgeVariant.danger:
        iconColor = JNMColors.danger600;
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
    return JNMOutlinedBadge(
      size: size,
      variant: variant,
      contentPadding: contentPadding,
      onTap: onTap,
      borderWidth: borderWidth,
      child: JNMIcon(
        iconAssetName,
        size: 12.0,
        color: iconColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    switch (variant) {
      case JNMBadgeVariant.primary:
        borderColor = JNMColors.primary;
        break;
      case JNMBadgeVariant.danger:
        borderColor = JNMColors.danger600;
        break;
      case JNMBadgeVariant.warning:
        borderColor = JNMColors.warning;
        break;
      case JNMBadgeVariant.success:
        borderColor = JNMColors.success;
        break;
      case JNMBadgeVariant.info:
        borderColor = JNMColors.info;
        break;
      case JNMBadgeVariant.defaultV:
      default:
        borderColor = JNMColors.neutral100;
        break;
    }

    return JNMBaseBadge(
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
      border: Border.all(
        color: borderColor,
        width: borderWidth,
      ),
      onTap: onTap,
      child: child,
    );
  }
}

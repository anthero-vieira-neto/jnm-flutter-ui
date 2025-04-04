import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

/// [JNMTag]'s possible sizes
enum JNMTagSize {
  sm,
  md,
  lg,
}

/// [JNMTag]'s possible trailing types.
enum JNMTagTrailing {
  /// Close icon.
  closeIcon,

  /// Count.
  count,
}

class JNMTag extends StatelessWidget {
  /// Tag's text.
  final String text;

  /// Tag's leading widget.
  final Widget? leading;

  /// Callback when the tag is tapped.
  final VoidCallback? onTap;

  /// Tag's size.
  final JNMTagSize size;

  /// Tag's trailing type.
  final JNMTagTrailing? trailing;

  /// Tag's count. Displayed if [trailing] is [JNMTagTrailing.count].
  final int count;

  /// If true, displays checkbox inside the tag.
  final bool showCheckbox;

  /// The checkbox value. Used when [showCheckbox] is true.
  final bool checkboxValue;

  /// Set this true when avatar is displayed to make sure the padding
  /// is correct.
  final bool showAvatar;

  /// Set this true when dot is displayed to make sure the padding
  /// is correct.
  final bool showDot;

  const JNMTag({
    required this.text,
    this.leading,
    this.onTap,
    this.size = JNMTagSize.md,
    this.trailing,
    this.count = 0,
    this.showCheckbox = false,
    this.checkboxValue = false,
    this.showAvatar = false,
    this.showDot = false,
    super.key,
  });

  factory JNMTag.dot({
    required String text,
    Color dotColor = JNMColors.success,
    VoidCallback? onTap,
    JNMTagSize size = JNMTagSize.md,
    JNMTagTrailing? trailing,
    int count = 0,
    bool showCheckbox = false,
    bool checkboxValue = false,
  }) {
    return JNMTag(
      onTap: onTap,
      size: size,
      trailing: trailing,
      count: count,
      showCheckbox: showCheckbox,
      checkboxValue: checkboxValue,
      showDot: true,
      text: text,
      leading: Container(
        width: 8.0,
        height: 8.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: dotColor,
        ),
      ),
    );
  }

  factory JNMTag.avatar({
    required String text,
    VoidCallback? onTap,
    JNMTagSize size = JNMTagSize.md,
    JNMTagTrailing? trailing,
    int count = 0,
    bool showCheckbox = false,
    bool checkboxValue = false,
    Color avatarBackgroundColor = JNMColors.neutral100,
    bool avatarShowVerifiedTick = false,
    double? avatarVerifiedTickSize,
    bool avatarShowOnlineIndicator = false,
    double avatarOnlineIndicatorBorderWidth = 1.5,
    Color avatarOnlineIndicatorBorderColor = JNMColors.white,
    Color avatarOnlineIndicatorColor = JNMColors.success,
    double? avatarOnlineIndicatorSize,
    ImageProvider<Object>? avatarImage,
    String? avatarInitial,
    IconData avatarEmptyIconAssetName = JNMIcons.user_01,
    Color avatarEmptyIconColor = JNMColors.neutral400,
    double? avatarEmptyIconSize,
    FontWeight avatarInitialFontWeight = JNMFontWeights.medium,
    Color avatarInitialFontColor = JNMColors.neutral400,
    double? avatarInitialFontSize,
  }) {
    return JNMTag(
      onTap: onTap,
      size: size,
      trailing: trailing,
      count: count,
      showCheckbox: showCheckbox,
      checkboxValue: checkboxValue,
      showAvatar: true,
      text: text,
      leading: JNMAvatar(
        size: 16.0,
        backgroundColor: avatarBackgroundColor,
        showVerifiedTick: avatarShowVerifiedTick,
        verifiedTickSize: avatarVerifiedTickSize,
        showOnlineIndicator: avatarShowOnlineIndicator,
        onlineIndicatorBorderWidth: avatarOnlineIndicatorBorderWidth,
        onlineIndicatorBorderColor: avatarOnlineIndicatorBorderColor,
        onlineIndicatorColor: avatarOnlineIndicatorColor,
        onlineIndicatorSize: avatarOnlineIndicatorSize,
        image: avatarImage,
        initial: avatarInitial,
        emptyIconAssetName: avatarEmptyIconAssetName,
        emptyIconColor: avatarEmptyIconColor,
        emptyIconSize: avatarEmptyIconSize,
        initialFontWeight: avatarInitialFontWeight,
        initialFontColor: avatarInitialFontColor,
        initialFontSize: avatarInitialFontSize,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double borderRadius = 6.0;

    late TextStyle textStyle;

    late double leadingMargin;
    late double trailingMargin;

    late TextStyle countTextStyle;
    late double countSize;

    late double closeIconSize;

    late double checkboxMargin;
    late JNMCheckboxSize checkboxSize;

    switch (size) {
      case JNMTagSize.sm:
        textStyle = JNMFontFamilies.inter(
          fontSize: JNMFontSizes.xs,
          fontWeight: JNMFontWeights.medium,
          color: JNMColors.neutral400,
        );

        checkboxMargin = 4.0;
        checkboxSize = JNMCheckboxSize.sm;

        countSize = 16.0;
        countTextStyle = JNMFontFamilies.inter(
          fontSize: JNMFontSizes.xs,
          fontWeight: JNMFontWeights.medium,
          color: JNMColors.neutral400,
        );

        closeIconSize = 14.0;

        leadingMargin = 4.0;
        switch (trailing) {
          case JNMTagTrailing.count:
            trailingMargin = 4.0;
            break;
          case JNMTagTrailing.closeIcon:
          default:
            trailingMargin = 3.0;
        }
        break;
      case JNMTagSize.md:
        textStyle = JNMFontFamilies.inter(
          fontSize: JNMFontSizes.sm,
          fontWeight: JNMFontWeights.medium,
          color: JNMColors.neutral400,
        );

        checkboxMargin = 5.0;
        checkboxSize = JNMCheckboxSize.md;

        countSize = 19.0;
        countTextStyle = JNMFontFamilies.inter(
          fontSize: JNMFontSizes.xs,
          fontWeight: JNMFontWeights.medium,
          color: JNMColors.neutral400,
        );

        closeIconSize = 16.0;

        leadingMargin = 5.0;
        switch (trailing) {
          case JNMTagTrailing.count:
            trailingMargin = 5.0;
            break;
          case JNMTagTrailing.closeIcon:
          default:
            trailingMargin = 3.0;
        }
        break;
      case JNMTagSize.lg:
        textStyle = JNMFontFamilies.inter(
          fontSize: JNMFontSizes.sm,
          fontWeight: JNMFontWeights.medium,
          color: JNMColors.neutral400,
        );

        checkboxMargin = 6.0;
        checkboxSize = JNMCheckboxSize.md; // TODO: lg in Figma

        countSize = 21.0;
        countTextStyle = JNMFontFamilies.inter(
          fontSize: JNMFontSizes.sm,
          fontWeight: JNMFontWeights.medium,
          color: JNMColors.neutral400,
        );

        closeIconSize = 20.0;

        leadingMargin = 6.0;
        switch (trailing) {
          case JNMTagTrailing.count:
            trailingMargin = 6.0;
            break;
          case JNMTagTrailing.closeIcon:
          default:
            trailingMargin = 3.0;
        }
        break;
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Material(
        color: JNMColors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            padding: _getContentPadding(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: JNMColors.neutral100,
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                if (showCheckbox) ...[
                  JNMCheckbox(
                    size: checkboxSize,
                    checked: checkboxValue,
                    onPressed: onTap,
                  ),
                  SizedBox(width: checkboxMargin),
                ],
                Row(
                  children: [
                    if (leading != null) ...[
                      leading!,
                      SizedBox(width: leadingMargin),
                    ],
                    Text(
                      text,
                      style: textStyle,
                    ),
                  ],
                ),
                if (trailing != null) ...[
                  SizedBox(width: trailingMargin),
                  _buildTrailing(
                    trailing!,
                    countSize,
                    closeIconSize,
                    countTextStyle,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  EdgeInsets _getContentPadding() {
    late EdgeInsets contentPadding;
    switch (size) {
      case JNMTagSize.sm:
        double contentPaddingLeft = 8.0;
        if (showCheckbox) {
          contentPaddingLeft = 5.0;
        } else {
          if (showAvatar) {
            contentPaddingLeft = 4.0;
          } else if (showDot) {
            contentPaddingLeft = 6.0;
          }
        }
        double contentPaddingRight = 8.0;
        if (trailing == JNMTagTrailing.closeIcon) {
          contentPaddingRight = 4.0;
        } else if (trailing == JNMTagTrailing.count) {
          contentPaddingRight = 4.0;
        }
        contentPadding = EdgeInsets.only(
          top: 3.0,
          bottom: 3.0,
          right: contentPaddingRight,
          left: contentPaddingLeft,
        );
        break;
      case JNMTagSize.md:
        double contentPaddingLeft = 9.0;
        if (showCheckbox) {
          contentPaddingLeft = 4.0;
        } else {
          if (showAvatar) {
            contentPaddingLeft = 5.0;
          } else if (showDot) {
            contentPaddingLeft = 7.0;
          }
        }
        double contentPaddingRight = 9.0;
        if (trailing == JNMTagTrailing.closeIcon) {
          contentPaddingRight = 4.0;
        } else if (trailing == JNMTagTrailing.count) {
          contentPaddingRight = 3.0;
        }
        contentPadding = EdgeInsets.only(
          top: 2.0,
          bottom: 2.0,
          right: contentPaddingRight,
          left: contentPaddingLeft,
        );
        break;
      case JNMTagSize.lg:
        double contentPaddingLeft = 10.0;
        if (showCheckbox) {
          contentPaddingLeft = 5.0;
        } else {
          if (showAvatar) {
            contentPaddingLeft = 7.0;
          } else if (showDot) {
            contentPaddingLeft = 9.0;
          }
        }
        double contentPaddingRight = 10.0;
        if (trailing == JNMTagTrailing.closeIcon) {
          contentPaddingRight = 4.0;
        } else if (trailing == JNMTagTrailing.count) {
          contentPaddingRight = 4.0;
        }
        contentPadding = EdgeInsets.only(
          top: 4.0,
          bottom: 4.0,
          right: contentPaddingRight,
          left: contentPaddingLeft,
        );
        break;
    }
    return contentPadding;
  }

  Widget _buildTrailing(
    JNMTagTrailing trailing,
    double countSize,
    double closeIconSize,
    TextStyle countTextStyle,
  ) {
    switch (trailing) {
      case JNMTagTrailing.closeIcon:
        return JNMIcon(
          JNMIcons.x_close,
          size: closeIconSize,
        );
      case JNMTagTrailing.count:
        return Container(
          width: countSize,
          height: countSize,
          decoration: BoxDecoration(
            color: JNMColors.neutral100,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Center(
            child: Text(
              count.toString(),
              style: countTextStyle,
            ),
          ),
        );
    }
  }
}

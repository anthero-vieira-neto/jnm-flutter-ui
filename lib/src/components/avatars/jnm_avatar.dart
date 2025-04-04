import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JNMAvatarSizes {
  static const double xs = 24.0;
  static const double sm = 32.0;
  static const double md = 40.0;
  static const double lg = 48.0;
  static const double xl = 56.0;
  static const double xl2 = 64.0;
}

class _JNMAvatarOnlineIndicatorSizes {
  static const double xs = 6.0;
  static const double sm = 8.0;
  static const double md = 10.0;
  static const double lg = 12.0;
  static const double xl = 14.0;
  static const double xl2 = 16.0;

  static double fromAvatarSize(double avatarSizes) {
    if (avatarSizes <= JNMAvatarSizes.xs) {
      return xs;
    } else if (avatarSizes <= JNMAvatarSizes.sm) {
      return sm;
    } else if (avatarSizes <= JNMAvatarSizes.md) {
      return md;
    } else if (avatarSizes <= JNMAvatarSizes.lg) {
      return lg;
    } else if (avatarSizes <= JNMAvatarSizes.xl) {
      return xl;
    } else {
      return xl2;
    }
  }
}

class _JNMAvatarIconSizes {
  static const double xs = 16.0;
  static const double sm = 20.0;
  static const double md = 24.0;
  static const double lg = 28.0;
  static const double xl = 32.0;
  static const double xl2 = 32.0;

  static double fromAvatarSize(double avatarSizes) {
    if (avatarSizes <= JNMAvatarSizes.xs) {
      return xs;
    } else if (avatarSizes <= JNMAvatarSizes.sm) {
      return sm;
    } else if (avatarSizes <= JNMAvatarSizes.md) {
      return md;
    } else if (avatarSizes <= JNMAvatarSizes.lg) {
      return lg;
    } else if (avatarSizes <= JNMAvatarSizes.xl) {
      return xl;
    } else {
      return xl2;
    }
  }
}

class _JNMAvatarVerifiedIconSizes {
  static const double xs = 10.0;
  static const double sm = 12.0;
  static const double md = 14.0;
  static const double lg = 16.0;
  static const double xl = 18.0;
  static const double xl2 = 20.0;

  static double fromAvatarSize(double avatarSizes) {
    if (avatarSizes <= JNMAvatarSizes.xs) {
      return xs;
    } else if (avatarSizes <= JNMAvatarSizes.sm) {
      return sm;
    } else if (avatarSizes <= JNMAvatarSizes.md) {
      return md;
    } else if (avatarSizes <= JNMAvatarSizes.lg) {
      return lg;
    } else if (avatarSizes <= JNMAvatarSizes.xl) {
      return xl;
    } else {
      return xl2;
    }
  }
}

class _JNMAvatarInitialFontSizes {
  static const double xs = JNMFontSizes.xs;
  static const double sm = JNMFontSizes.sm;
  static const double md = JNMFontSizes.md;
  static const double lg = JNMFontSizes.lg;
  static const double xl = JNMFontSizes.xl;
  static const double xl2 = JNMFontSizes.xl2;

  static double fromAvatarSize(double avatarSizes) {
    if (avatarSizes <= JNMAvatarSizes.xs) {
      return xs;
    } else if (avatarSizes <= JNMAvatarSizes.sm) {
      return sm;
    } else if (avatarSizes <= JNMAvatarSizes.md) {
      return md;
    } else if (avatarSizes <= JNMAvatarSizes.lg) {
      return lg;
    } else if (avatarSizes <= JNMAvatarSizes.xl) {
      return xl;
    } else {
      return xl2;
    }
  }
}

class JNMAvatar extends StatelessWidget {
  /// The size of the circle container. Use [JNMAvatarSizes] values.
  final double size;

  /// The background color of the circle container.
  final Color backgroundColor;

  /// The image shown in the avatar.
  final ImageProvider? image;

  /// The initial text shown in the avatar. If [image] is present,
  /// this property won't be used.
  final String? initial;

  /// The initial text’s font weight.
  final FontWeight initialFontWeight;

  /// The initial text’s font color.
  final Color initialFontColor;

  /// The initial text’s font size.
  final double? initialFontSize;

  /// The empty icon asset name.
  final IconData emptyIconAssetName;

  /// The empty icon asset name.
  final Color emptyIconColor;

  /// The empty icon size.
  final double? emptyIconSize;

  /// Whether to show online indicator.
  final bool showOnlineIndicator;

  /// Online indicator border width.
  final double onlineIndicatorBorderWidth;

  /// Online indicator border width.
  final Color onlineIndicatorBorderColor;

  /// Online indicator border color.
  final Color onlineIndicatorColor;

  /// Online indicator size.
  final double? onlineIndicatorSize;

  /// Whether to show verified tick.
  final bool showVerifiedTick;

  /// Verified tick size.
  final double? verifiedTickSize;

  const JNMAvatar({
    super.key,
    this.size = JNMAvatarSizes.md,
    this.backgroundColor = JNMColors.neutral100,
    this.showVerifiedTick = false,
    this.verifiedTickSize,
    this.showOnlineIndicator = false,
    this.onlineIndicatorBorderWidth = 1.5,
    this.onlineIndicatorBorderColor = JNMColors.white,
    this.onlineIndicatorColor = JNMColors.success,
    this.onlineIndicatorSize,
    this.image,
    this.initial,
    this.emptyIconAssetName = JNMIcons.user_01,
    this.emptyIconColor = JNMColors.neutral400,
    this.emptyIconSize,
    this.initialFontWeight = JNMFontWeights.medium,
    this.initialFontColor = JNMColors.neutral400,
    this.initialFontSize,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = Container();
    DecorationImage? decorationImage;
    if (image != null) {
      decorationImage = DecorationImage(
        image: image!,
        fit: BoxFit.cover,
      );
    } else if (initial != null) {
      child = Text(
        initial!,
        style: JNMFontFamilies.inter(
          fontWeight: initialFontWeight,
          fontSize: initialFontSize ??
              _JNMAvatarInitialFontSizes.fromAvatarSize(size),
          color: initialFontColor,
        ),
      );
    } else {
      child = JNMIcon(
        emptyIconAssetName,
        size: emptyIconSize ?? _JNMAvatarIconSizes.fromAvatarSize(size),
        color: emptyIconColor,
      );
    }

    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            image: decorationImage,
          ),
          child: Center(
            child: child,
          ),
        ),
        showOnlineIndicator && !showVerifiedTick
            ? Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Container(
                  width: onlineIndicatorSize ??
                      _JNMAvatarOnlineIndicatorSizes.fromAvatarSize(size),
                  height: onlineIndicatorSize ??
                      _JNMAvatarOnlineIndicatorSizes.fromAvatarSize(size),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: onlineIndicatorColor,
                    border: Border.all(
                      color: onlineIndicatorBorderColor,
                      width: onlineIndicatorBorderWidth,
                    ),
                  ),
                ),
              )
            : Container(),
        showVerifiedTick
            ? Positioned(
                bottom: 0.0,
                right: 0.0,
                child: SvgPicture.asset(
                  'packages/jnm_ui/assets/icons/verified-tick.svg',
                  width: verifiedTickSize ??
                      _JNMAvatarVerifiedIconSizes.fromAvatarSize(size),
                  height: verifiedTickSize ??
                      _JNMAvatarVerifiedIconSizes.fromAvatarSize(size),
                ),
              )
            : Container(),
      ],
    );
  }
}

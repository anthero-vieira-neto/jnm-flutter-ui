import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// [JNMLogo]'s variant.
enum JNMLogoVariant {
  black,
  colorful,
  whiteGreen,
  white,
}

/// JNM UI's JNM logo widget.
class JNMLogo extends StatelessWidget {
  /// The logo's height.
  final double height;

  /// The logo's width.
  final double? width;

  /// Whether to use the white font or not.
  @Deprecated(
    'Use variant property instead. Will be removed in the future release.',
  )
  final bool? isWhite;

  /// The logo's variant.
  final JNMLogoVariant variant;

  const JNMLogo({
    super.key,
    this.height = 20.0,
    this.width,
    @Deprecated(
      'Use variant property instead. Will be removed in the future release.',
    )
    this.isWhite,
    this.variant = JNMLogoVariant.colorful,
  });

  @override
  Widget build(BuildContext context) {
    late String assetName;
    // ignore: deprecated_member_use_from_same_package
    if (isWhite != null) {
      // ignore: deprecated_member_use_from_same_package
      assetName = !isWhite!
          ? 'packages/jnm_ui/assets/images/jnm_logo_colorful.svg'
          : 'packages/jnm_ui/assets/images/jnm_logo_white_green.svg';
    } else {
      switch (variant) {
        case JNMLogoVariant.black:
          assetName =
              'packages/jnm_ui/assets/images/jnm_logo_black.svg';
          break;
        case JNMLogoVariant.colorful:
          assetName =
              'packages/jnm_ui/assets/images/jnm_logo_colorful.svg';
          break;
        case JNMLogoVariant.whiteGreen:
          assetName =
              'packages/jnm_ui/assets/images/jnm_logo_white_green.svg';
          break;
        case JNMLogoVariant.white:
          assetName =
              'packages/jnm_ui/assets/images/jnm_logo_white.svg';
          break;
      }
    }
    return SvgPicture.asset(
      assetName,
      height: height,
      width: width,
    );
  }
}

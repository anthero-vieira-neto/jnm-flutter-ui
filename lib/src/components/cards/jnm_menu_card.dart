import 'package:jnm_ui/jnm_ui.dart';
import 'package:jnm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';

enum JNMMenuCardVariant {
  elevated,
  text,
}

/// Tappable menu card widget.
class JNMMenuCard extends StatelessWidget {
  /// The card's title.
  final String title;

  /// The card's subtitle.
  final String? subtitle;

  /// The card's icon.
  final IconData icon;

  /// The card's icon variant.
  final JNMFilledIconVariant iconVariant;

  /// The callback when the card is tapped.
  final VoidCallback? onTap;

  /// The title's max lines.
  final int? maxLinesTitle;

  /// The subtitle's max lines.
  final int? maxLinesSubtitle;

  /// Opacity when card is disabled.
  final double disabledOpacity;

  /// The card's variant.
  final JNMMenuCardVariant variant;

  const JNMMenuCard({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.iconVariant,
    this.subtitle,
    this.maxLinesTitle = 1,
    this.maxLinesSubtitle = 1,
    this.disabledOpacity = 0.3,
    this.variant = JNMMenuCardVariant.elevated,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (onTap != null) {
      return _buildCard(context, variant);
    } else {
      return Opacity(
        opacity: disabledOpacity,
        child: _buildCard(context, variant),
      );
    }
  }

  Widget _buildCard(BuildContext context, JNMMenuCardVariant variant) {
    switch (variant) {
      case JNMMenuCardVariant.elevated:
        return _buildElevatedCard(context);
      case JNMMenuCardVariant.text:
        return _buildTextCard(context);
    }
  }

  Widget _buildElevatedCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: JNMBoxShadow.sm,
        borderRadius: BorderRadius.circular(JNMBorderRadius.sm),
      ),
      child: Material(
        color: JNMColors.white,
        borderRadius: BorderRadius.circular(JNMBorderRadius.sm),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(JNMBorderRadius.sm),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: JNMColors.neutral50,
              ),
              borderRadius: BorderRadius.circular(JNMBorderRadius.sm),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 12.0,
              ),
              child: Column(
                children: [
                  JNMFilledIcon(
                    icon: icon,
                    variant: iconVariant,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: maxLinesTitle,
                    overflow: TextOverflow.ellipsis,
                    style: LibraryTextStyles.interSmSemiboldNeutral,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4.0),
                    Text(
                      subtitle!,
                      textAlign: TextAlign.center,
                      maxLines: maxLinesSubtitle,
                      overflow: TextOverflow.ellipsis,
                      style: LibraryTextStyles.interXsRegularNeutral300,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextCard(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(JNMBorderRadius.xs),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(JNMBorderRadius.xs),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              JNMFilledIcon(
                icon: icon,
                iconSize: 24.0,
                variant: iconVariant,
              ),
              const SizedBox(height: 12.0),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: maxLinesTitle,
                overflow: TextOverflow.ellipsis,
                style: LibraryTextStyles.interXsRegularNeutral,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

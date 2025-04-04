import 'package:cached_network_image/cached_network_image.dart';
import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

class JNMThumbnailList extends StatelessWidget {
  final List<String> imageUrls;
  final double size;
  final Function(BuildContext context, int index)? onTap;

  const JNMThumbnailList({
    required this.imageUrls,
    this.size = 64.0,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          String url = imageUrls[index];
          return InkWell(
            onTap: onTap != null
                ? () {
                    onTap!(context, index);
                  }
                : null,
            borderRadius: BorderRadius.circular(JNMBorderRadius.sm),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(JNMBorderRadius.sm),
              child: CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                width: size,
                height: size,
                progressIndicatorBuilder: (context, url, progress) {
                  return Container(
                    color: JNMColors.primary200,
                    width: size,
                    height: size,
                  );
                },
                errorWidget: (_, __, ___) {
                  return Container(
                    color: JNMColors.danger200,
                    width: size,
                    height: size,
                    child: const Center(
                      child: JNMIcon(
                        JNMIcons.alert_triangle,
                        color: JNMColors.danger,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 8.0);
        },
        itemCount: imageUrls.length,
      ),
    );
  }
}

import 'dart:ui';

import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

class JNMUiUtils {
  static Future<T?> showJNMDialog<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool barrierDismissible = true,
  }) {
    return showDialog(
      context: context,
      builder: (context) => buildDialogBackground(
        context: context,
        builder: builder,
        isDismissible: barrierDismissible,
      ),
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.transparent,
    );
  }

  static Widget buildDialogBackground({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isDismissible = true,
  }) {
    bool useMobile = MediaQuery.of(context).size.width < mobileMaxWidth;
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 4.0,
        sigmaY: 4.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: !useMobile
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    JNMColors.neutral.withValues(alpha: 0.7 * 0.5),
                    JNMColors.neutral.withValues(alpha: 0.7),
                  ],
                )
              : null,
          color: useMobile ? const Color.fromRGBO(16, 24, 40, 0.35) : null,
        ),
        child: TapRegion(
          onTapOutside: (_) {
            if (isDismissible) {
              Navigator.of(context).pop();
            }
          },
          child: builder(context),
        ),
      ),
    );
  }
}

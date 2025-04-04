import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

class JNMAppBarSearchAndAction extends AppBar {
  /// [BuildContext] is used to give default callback on pressing back button
  final BuildContext context;

  /// Hint text in search input field
  final String? searchHintText;

  /// [List] of action widgets
  final List<Widget> actionWidgets;

  /// [VoidCallback] for pressing back button
  final VoidCallback? callbackPressingBack;

  /// Callback for submitting search
  final Function(String)? callbackSubmittingSearch;

  JNMAppBarSearchAndAction({
    required this.actionWidgets,
    required this.context,
    double? elevation,
    this.callbackPressingBack,
    this.callbackSubmittingSearch,
    this.searchHintText,
    super.key,
  }) : super(
          leading: JNMTertiaryNeutralButton.iconOnly(
            iconAssetName: JNMIcons.arrow_left,
            onPressed: callbackPressingBack ??
                () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                },
          ),
          centerTitle: true,
          elevation: elevation,
          titleSpacing: 0,
          title: JNMTextInputField(
            hintText: searchHintText,
            prefixIconAssetName: JNMIcons.search_md,
            onFieldSubmitted: callbackSubmittingSearch,
          ),
          actions: actionWidgets,
        );

  /// Predefined [JNMAppBarSearchAndAction]
  /// for search field and shopping cart action button
  factory JNMAppBarSearchAndAction.shoppingCart({
    required BuildContext context,
    required int badgeCount,
    required VoidCallback callbackPressingCartButton,
    double? elevation,
    String? searchHintText,
  }) =>
      JNMAppBarSearchAndAction(
        searchHintText: searchHintText,
        actionWidgets: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              JNMTertiaryNeutralButton.iconOnly(
                height: JNMButtonHeights.xl2,
                iconAssetName: JNMIcons.shopping_cart_01,
                onPressed: callbackPressingCartButton,
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  height: 16,
                  width: 16,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: JNMColors.danger,
                  ),
                  child: Center(
                    child: Text(
                      badgeCount.toString(),
                      style: JNMFontFamilies.inter(
                        fontSize: 10,
                        color: JNMColors.white,
                        fontWeight: JNMFontWeights.semibold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
        context: context,
        elevation: elevation,
      );
}

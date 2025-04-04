import 'package:jnm_ui/jnm_ui.dart';
import 'package:flutter/material.dart';

/// Wrapper [JNMDrawer] for desktop layout.
class JNMDesktopDrawer extends StatefulWidget {
  /// Currently active route path.
  final String currentRoutePath;

  /// Callback when route is changing.
  final void Function(
    BuildContext context,
    String? routePath,
  ) onChangedRoutePath;

  /// Animation duration.
  final Duration duration;

  /// Drawer main menus (below header).
  final List<JNMDrawerMenu> mainMenus;

  /// Drawer secondary menus (above profile).
  final List<JNMDrawerMenu> secondaryMenus;

  /// Profile title.
  final String profileTitle;

  /// Profile subtitle.
  final String profileSubtitle;

  /// Profile image provider.
  final ImageProvider? profileImageProvider;

  /// Callback when logout button is pressed.
  final void Function(BuildContext context) onPressedLogout;

  /// Logout button icon asset name.
  final IconData logoutIconAssetName;

  /// Chevron right icon asset name.
  final IconData chevronRightIconAssetName;

  /// JNM logo image asset name.
  final String jnmLogoImageAssetName;

  /// Whether to show JNM logo.
  final bool showHeaderLogo;

  /// Header title widget.
  final Widget headerTitle;

  /// Header subtitle widget.
  final Widget headerSubtitle;

  /// The drawer content widget.
  final Widget child;

  /// Whether to show profile
  final bool isShowProfile;

  const JNMDesktopDrawer({
    required this.currentRoutePath,
    required this.onChangedRoutePath,
    required this.profileTitle,
    required this.profileSubtitle,
    required this.onPressedLogout,
    required this.headerTitle,
    required this.headerSubtitle,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
    this.mainMenus = const [],
    this.secondaryMenus = const [],
    this.profileImageProvider,
    this.logoutIconAssetName = JNMIcons.log_out_01,
    this.chevronRightIconAssetName = JNMIcons.chevron_right,
    this.jnmLogoImageAssetName =
        'packages/jnm_ui/assets/images/jnm_logo_white.svg',
    this.showHeaderLogo = true,
    this.isShowProfile = true,
    super.key,
  });

  @override
  State<JNMDesktopDrawer> createState() => _JNMDesktopDrawerState();
}

class _JNMDesktopDrawerState extends State<JNMDesktopDrawer> {
  bool _isDrawerExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            JNMDrawer(
              currentRoutePath: widget.currentRoutePath,
              onExpandDrawer: () {
                _handleExpandDrawer(true);
              },
              isDrawerExpanded: _isDrawerExpanded,
              onChangedRoutePath: widget.onChangedRoutePath,
              profileTitle: widget.profileTitle,
              profileSubtitle: widget.profileSubtitle,
              profileImageProvider: widget.profileImageProvider,
              onPressedLogout: widget.onPressedLogout,
              mainMenus: widget.mainMenus,
              secondaryMenus: widget.secondaryMenus,
              logoutIconAssetName: widget.logoutIconAssetName,
              chevronRightIconAssetName: widget.chevronRightIconAssetName,
              jnmLogoImageAssetName: widget.jnmLogoImageAssetName,
              showHeaderLogo: widget.showHeaderLogo,
              headerTitle: widget.headerTitle,
              headerSubtitle: widget.headerSubtitle,
              isShowProfile: widget.isShowProfile,
            ),
            Expanded(
              child: widget.child,
            ),
          ],
        ),
        AnimatedPositioned(
          left: _isDrawerExpanded ? 304.0 - 10.0 : 82.0 - 10.0,
          top: 32.0,
          duration: const Duration(milliseconds: 200),
          child: Material(
            color: JNMColors.success,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: InkWell(
              onTap: () {
                _handleExpandDrawer(!_isDrawerExpanded);
              },
              child: AnimatedRotation(
                turns: _isDrawerExpanded ? 0.5 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: JNMIcon(
                  widget.chevronRightIconAssetName,
                  size: 20.0,
                  color: JNMColors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleExpandDrawer(bool newValue) {
    setState(() {
      _isDrawerExpanded = newValue;
    });
  }
}

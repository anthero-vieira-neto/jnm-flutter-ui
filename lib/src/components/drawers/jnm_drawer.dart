import 'package:jnm_ui/jnm_ui.dart';
import 'package:jnm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// [JNMDrawer] menu data class.
class JNMDrawerMenu {
  /// The menu title.
  final String title;

  /// The icon asset name if exist.
  final IconData? iconAssetName;

  /// The menu children if exist.
  final List<JNMDrawerMenu> children;

  /// The menu route path if exist.
  final String? routePath;

  const JNMDrawerMenu({
    required this.title,
    this.iconAssetName,
    this.children = const [],
    this.routePath,
  });

  bool isActive(String currentRoutePath) {
    return currentRoutePath == routePath ||
        children.any((childMenu) => childMenu.routePath == currentRoutePath);
  }
}

/// JNM UI's Drawer component widget.
class JNMDrawer extends StatelessWidget {
  /// Currently active route path.
  final String currentRoutePath;

  /// Whether the drawer is expanded.
  final bool isDrawerExpanded;

  /// Callback to expand the drawer.
  final VoidCallback? onExpandDrawer;

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

  /// Whether to show profile
  final bool isShowProfile;

  final Widget? profileSubtitleSuffix;

  final VoidCallback? onTapProfileSubtitleSuffix;

  const JNMDrawer({
    required this.currentRoutePath,
    required this.onChangedRoutePath,
    required this.profileTitle,
    required this.profileSubtitle,
    required this.onPressedLogout,
    required this.headerTitle,
    required this.headerSubtitle,
    this.isDrawerExpanded = true,
    this.onExpandDrawer,
    this.profileImageProvider,
    this.duration = const Duration(milliseconds: 200),
    this.mainMenus = const [],
    this.secondaryMenus = const [],
    this.logoutIconAssetName = JNMIcons.log_out_01,
    this.chevronRightIconAssetName = JNMIcons.chevron_right,
    this.jnmLogoImageAssetName =
        'packages/jnm_ui/assets/images/jnm_logo_white.svg',
    this.showHeaderLogo = true,
    this.isShowProfile = true,
    this.profileSubtitleSuffix,
    this.onTapProfileSubtitleSuffix,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String? profileInitial = StringUtils.getInitials(profileTitle);
    Widget? profileSubtitleSuffixWidget;

    if (profileSubtitleSuffix != null) {
      profileSubtitleSuffixWidget = profileSubtitleSuffix;
      profileSubtitleSuffixWidget = FittedBox(
        fit: BoxFit.scaleDown,
        child: InkWell(
          onTap: onTapProfileSubtitleSuffix,
          child: profileSubtitleSuffixWidget,
        ),
      );
    }
    return AnimatedContainer(
      color: JNMColors.primary,
      duration: duration,
      width: isDrawerExpanded ? 304 : 82,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32.0,
          horizontal: 16.0,
        ),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 32.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: mainMenus.map((menu) {
                    return _AppDrawerMenuListTile(
                      menu: menu,
                      duration: duration,
                      currentRoutePath: currentRoutePath,
                      isDrawerExpanded: isDrawerExpanded,
                      onExpandDrawer: onExpandDrawer,
                      onChangedRoutePath: onChangedRoutePath,
                      defaultIsChildrenExpanded:
                          menu.isActive(currentRoutePath),
                      chevronRightIconAssetName: chevronRightIconAssetName,
                    );
                  }).toList(),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: secondaryMenus.map((menu) {
                return _AppDrawerMenuListTile(
                  menu: menu,
                  duration: duration,
                  currentRoutePath: currentRoutePath,
                  isDrawerExpanded: isDrawerExpanded,
                  onExpandDrawer: onExpandDrawer,
                  onChangedRoutePath: onChangedRoutePath,
                  defaultIsChildrenExpanded: menu.isActive(currentRoutePath),
                  chevronRightIconAssetName: chevronRightIconAssetName,
                );
              }).toList(),
            ),
            ...(() {
              return isShowProfile
                  ? [
                      const JNMDivider(
                        height: 48,
                        color: JNMColors.primary400,
                      ),
                      _buildProfileListTile(
                        context,
                        profileInitial,
                        profileImageProvider,
                        profileSubtitleSuffixWidget,
                      ),
                    ]
                  : [];
            }()),
          ],
        ),
      ),
    );
  }

  /// Build header.
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        showHeaderLogo
            ? SizedBox(
                height: 20.0,
                child: AnimatedContainer(
                  duration: duration,
                  height: isDrawerExpanded ? 20.0 : 16.0,
                  child: SvgPicture.asset(jnmLogoImageAssetName),
                ),
              )
            : Container(),
        AnimatedOpacity(
          duration: duration,
          opacity: isDrawerExpanded ? 1.0 : 0.0,
          child: Column(
            children: [headerTitle, headerSubtitle],
          ),
        ),
      ],
    );
  }

  /// Build profile list tile.
  Widget _buildProfileListTile(
    BuildContext context,
    String? profileInitial,
    ImageProvider? profileImageProvider,
    Widget? profileSubtitleSuffixWidget,
  ) {
    return Theme(
      data: ThemeData(
        splashColor: JNMColors.primary600,
        highlightColor: JNMColors.primary600,
      ),
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: JNMColors.primary,
          borderRadius: BorderRadius.circular(6.0),
        ),
        duration: duration,
        width: isDrawerExpanded ? 400.0 : 48.0,
        child: Row(
          children: [
            JNMAvatar(
              initial: profileInitial,
              image: profileImageProvider,
            ),
            isDrawerExpanded
                ? Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profileTitle,
                                style: LibraryTextStyles.interSmSemiboldWhite,
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      profileSubtitle,
                                      style: LibraryTextStyles
                                          .interSmRegularPrimary300,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  if (profileSubtitleSuffixWidget != null) ...[
                                    const SizedBox(width: 8),
                                    profileSubtitleSuffixWidget,
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => onPressedLogout(context),
                          icon: JNMIcon(
                            logoutIconAssetName,
                            color: JNMColors.primary300,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

/// Custom expansion list tile wdget for [JNMDrawer].
class _AppDrawerMenuListTile extends StatefulWidget {
  /// The menu data.
  final JNMDrawerMenu menu;

  /// Whether the drawer is expanded.
  final bool isDrawerExpanded;

  /// Default value of whether children is expanded.
  final bool defaultIsChildrenExpanded;

  /// Currently active route path that is defined in [AppRoutes].
  final String currentRoutePath;

  /// Animation duration.
  final Duration duration;

  /// Callback to expand the drawer.
  final VoidCallback? onExpandDrawer;

  final void Function(BuildContext context, String? routePath)
      onChangedRoutePath;

  final IconData chevronRightIconAssetName;

  const _AppDrawerMenuListTile({
    required this.menu,
    required this.currentRoutePath,
    required this.duration,
    required this.onChangedRoutePath,
    required this.defaultIsChildrenExpanded,
    required this.chevronRightIconAssetName,
    this.onExpandDrawer,
    this.isDrawerExpanded = false,
  });

  @override
  State<_AppDrawerMenuListTile> createState() => _AppDrawerMenuListTileState();
}

class _AppDrawerMenuListTileState extends State<_AppDrawerMenuListTile> {
  bool _isChildrenExpanded = false;

  @override
  void initState() {
    super.initState();

    _isChildrenExpanded = widget.defaultIsChildrenExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AppDrawerMenuContentListTile(
          title: widget.menu.title,
          iconAssetName: widget.menu.iconAssetName,
          duration: widget.duration,
          isDrawerExpanded: widget.isDrawerExpanded,
          hasChildren: widget.menu.children.isNotEmpty,
          isActive: widget.menu.isActive(widget.currentRoutePath),
          isChildrenExpanded: _isChildrenExpanded,
          onTap: widget.menu.children.isNotEmpty
              ? () {
                  // If drawer is not expanded, expand drawer first.
                  if (!widget.isDrawerExpanded) {
                    if (widget.onExpandDrawer != null) {
                      widget.onExpandDrawer!();
                    } else {
                      throw Exception('onExpandDrawer() is not defined!');
                    }
                  } else {
                    setState(() {
                      _isChildrenExpanded = !_isChildrenExpanded;
                    });
                  }
                }
              : () {
                  widget.onChangedRoutePath(context, widget.menu.routePath);
                },
          chevronRightIconAssetName: widget.chevronRightIconAssetName,
        ),
        widget.menu.children.isNotEmpty
            ? AnimatedContainer(
                duration: widget.duration,
                height: _isChildrenExpanded && widget.isDrawerExpanded
                    ? 48.0 * widget.menu.children.length
                    : 0.0,
                child: SingleChildScrollView(
                  child: Column(
                    children: widget.menu.children
                        .map(
                          (childMenu) => _AppDrawerMenuContentListTile(
                            title: childMenu.title,
                            iconAssetName: childMenu.iconAssetName,
                            duration: widget.duration,
                            isDrawerExpanded: widget.isDrawerExpanded,
                            onTap: () {
                              widget.onChangedRoutePath(
                                context,
                                childMenu.routePath,
                              );
                            },
                            isActive:
                                widget.currentRoutePath == childMenu.routePath,
                            chevronRightIconAssetName:
                                widget.chevronRightIconAssetName,
                          ),
                        )
                        .toList(),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}

/// Content of [_AppDrawerMenuListTile] widget.
class _AppDrawerMenuContentListTile extends StatelessWidget {
  /// The icon displayed at the start of the tile.
  final IconData? iconAssetName;

  /// Animation duration.
  final Duration duration;

  /// Callback on tap.
  final VoidCallback onTap;

  /// Whether this menu is currently active or not.
  final bool isActive;

  /// The tile title.
  final String title;

  /// Whether the drawer is currently expanding.
  final bool isDrawerExpanded;

  /// Whether the menu is currently expanding its children.
  final bool isChildrenExpanded;

  /// Whether the menu has children.
  final bool hasChildren;

  final IconData chevronRightIconAssetName;

  const _AppDrawerMenuContentListTile({
    required this.title,
    required this.duration,
    required this.onTap,
    required this.chevronRightIconAssetName,
    this.iconAssetName,
    this.isActive = false,
    this.isDrawerExpanded = false,
    this.isChildrenExpanded = false,
    this.hasChildren = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        color: isActive ? JNMColors.primary600 : JNMColors.primary500,
        child: InkWell(
          borderRadius: BorderRadius.circular(6.0),
          onTap: onTap,
          onHover: (value) {},
          hoverColor: JNMColors.primary600,
          child: AnimatedContainer(
            duration: duration,
            width: isDrawerExpanded ? 400.0 : 48.0,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  iconAssetName == null
                      ? const SizedBox(width: 24)
                      : JNMIcon(
                          iconAssetName!,
                          size: 24.0,
                          color: isActive
                              ? Colors.white
                              : JNMColors.primary300,
                        ),
                  isDrawerExpanded
                      ? Flexible(
                          child: Row(
                            children: [
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: Text(
                                  title,
                                  style: JNMFontFamilies.inter(
                                    fontSize: JNMFontSizes.md,
                                    fontWeight: isActive
                                        ? JNMFontWeights.semibold
                                        : JNMFontWeights.medium,
                                    color: isActive
                                        ? Colors.white
                                        : JNMColors.primary100,
                                  ),
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                ),
                              ),
                              hasChildren
                                  ? AnimatedRotation(
                                      turns: isChildrenExpanded ? 0.25 : 0.0,
                                      duration: duration,
                                      child: JNMIcon(
                                        chevronRightIconAssetName,
                                        size: 16.0,
                                        color: JNMColors.primary300,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

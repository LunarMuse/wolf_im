import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fx_platform_adapter/fx_platform_adapter.dart';
import 'package:tolyui/tolyui.dart';
import 'package:wolf_im/config/toly_icon.dart';
import 'package:wolf_im/l10n/l10n.dart';

enum AppTab {
  chat('/chat', TolyIcon.icon_layout),
  user('/user', TolyIcon.icon_layout);

  final IconData icon;
  final String path;

  static List<AppTab> get mobileTabs => [chat, user];

  const AppTab(this.path, this.icon);

  String label(AppL10n l10n) {
    if (kAppEnv.isDesktopUI) {
      return switch (this) {
        AppTab.chat => l10n.deskTabWidgets,
        AppTab.user => l10n.deskTabWidgets,
      };
    }
    return switch (this) {
      AppTab.chat => l10n.mobileTabWidgets,
      AppTab.user => l10n.mobileTabWidgets,
    };
  }

  IconMenu menu(AppL10n l10n) =>
      IconMenu(icon, label: label(l10n), route: path);
}

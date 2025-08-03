import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:toly_ui/toly_ui.dart';
import 'package:tolyui/basic/basic.dart';
import 'package:wolf_im/config/toly_icon.dart';
import 'package:wolf_im/pages/desktop/locale_change_menu.dart';
import 'package:wolf_im/pages/desktop/theme_model_switch_icon.dart';

enum ActionType {
  settings(path: '/settings'),
  collection(path: '/collection');

  final String path;

  const ActionType({required this.path});
}

class MenuBarTail extends StatelessWidget {
  const MenuBarTail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(indent: 20, color: Colors.white, height: 1),
        const SizedBox(height: 8),
        const LocaleChangeMenu(),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 2),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            children: [
              const SettingIcon(),
              TolyAction(
                style: const ActionStyle.dark(),
                onTap: () => context.push(ActionType.collection.path),
                child: const Icon(
                  TolyIcon.icon_collect,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const ThemeModelSwitchIcon(),
            ],
          ),
        ),
      ],
    );
  }
}

class SettingIcon extends StatelessWidget {
  const SettingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    // UpdateState state = context.watch<UpgradeBloc>().state;
    Color tipColor = Colors.redAccent;
    Widget child = TolyAction(
      style: const ActionStyle.dark(),
      onTap: () => context.push(ActionType.settings.path),
      child: const Icon(Icons.settings, color: Colors.white, size: 22),
    );
    // return switch (state) {
    //   ShouldUpdateState() => Badge(backgroundColor: tipColor, child: child),
    //   _ => child,
    // };
    return child;
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tolyui/basic/basic.dart';
import 'package:wolf_im/config/toly_icon.dart';
import 'package:wolf_im/pages/desktop/theme_model_switch_icon.dart';
import 'package:wolf_im/widgets/desktop/locale_change_menu_widget.dart';

enum ActionType {
  // TODO：
  settings(path: '/settings'),
  collection(path: '/collection');

  final String path;

  const ActionType({required this.path});
}

class MenuBarTailWidget extends StatelessWidget {
  const MenuBarTailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // 垂直布局容器：按顺序排列子组件（分割线、语言切换、功能按钮组等）
    return Column(
      children: [
        // 分割线：分隔导航菜单与底部功能区；白色分割线（color: Colors.white），配合 indent: 20 实现左侧缩进，
        //  与深灰色导航栏背景（Color(0xff2C3036)）形成对比，清晰分隔上方的导航菜单和下方的功能区
        const Divider(indent: 20, color: Colors.white, height: 1),
        // 间距组件：在分割线和下方内容之间添加8px垂直间距（避免拥挤）
        const SizedBox(height: 8),
        // 语言切换菜单
        const LocaleChangeMenuWidget(),
        // 内边距容器：为功能按钮组添加边距（控制与父容器的距离）；功能按钮组：设置、收藏、主题切换
        Padding(
          padding: const EdgeInsets.only(
            left: 8, // 左内边距8px
            right: 8, // 右内边距8px
            bottom: 8, // 下内边距8px（避免贴底部边缘）
            top: 2, // 上内边距2px（与上方语言切换菜单保持近距）
          ),
          // 流式布局容器：水平排列功能按钮，支持自动换行（此处按钮少，实际为单行）
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center, // 子组件在垂直方向居中对齐
            spacing: 8, // 按钮之间的水平间距为8px（避免拥挤）
            children: [
              // 设置图标按钮
              const SettingIcon(),
              // 收藏功能按钮
              TolyAction(
                style: const ActionStyle.dark(), // 采用深色样式（适配深色背景）
                onTap: () => context.push(ActionType.collection.path),
                child: const Icon(
                  TolyIcon.icon_collect,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              // 主题切换图标按钮
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

import 'package:flutter/material.dart';
import 'package:fx_platform_adapter/fx_platform_adapter.dart';
import 'package:go_router/go_router.dart';
import 'package:tolyui_navigation/tolyui_navigation.dart';
import 'package:wolf_im/l10n/ext.dart';
import 'package:wolf_im/pages/desktop/menu_bar_leading.dart';
import 'package:wolf_im/pages/desktop/toly_unit_menu_cell.dart';
import 'package:wolf_im/routes/app_tab.dart';
import 'package:wolf_im/widgets/desktop/app_shortcuts_scope_widget.dart';
import 'package:wolf_im/widgets/desktop/menu_bar_tail_widget.dart';

class AppDeskNavigationPage extends StatelessWidget {
  final Widget content;

  const AppDeskNavigationPage({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppShortcutsScopeWidget 的核心作用是为应用添加全局快捷键 Ctrl+F
      body: AppShortcutsScopeWidget(
        child: Row(
          children: [
            // DragToMoveWrapper让child区域支持鼠标拖拽，实现窗口移动。
            // DeskNavigationRail 是一个桌面端应用的侧边导航栏组件，核心作用是提供固定在侧边的导航菜单。
            const DragToMoveWrapper(child: DeskNavigationRail()),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }
}

// DeskNavigationRail 是一个桌面端应用的侧边导航栏组件，核心作用是提供固定在侧边的导航菜单，
//  支持根据当前路由高亮激活项、点击菜单切换页面，并适配本地化语言，是桌面应用中实现页面间导航的核心组件。
class DeskNavigationRail extends StatefulWidget {
  const DeskNavigationRail({super.key});

  @override
  State<DeskNavigationRail> createState() => _DeskNavigationRailState();
}

class _DeskNavigationRailState extends State<DeskNavigationRail> {
  @override
  Widget build(BuildContext context) {
    // TolyRailMenuBar（推测是一个封装好的侧边栏菜单组件），通过参数配置导航栏的样式、数据和交互：
    return TolyRailMenuBar(
      cellBuilder: FlutterUnitMenuCell.create, // 菜单项的构建器（定义单个菜单项样式）
      width: 140, // 侧边栏宽度
      gap: 8, // 菜单项之间的间距
      padding: EdgeInsets.zero, // 内边距
      backgroundColor: const Color(0xff2C3036), // 侧边栏背景色（深灰色，适合桌面端）
      menus: deskNavBarMenus, // 导航菜单数据列表
      activeId: activePath, // 当前激活的菜单ID（用于高亮显示）
      enableWidthChange: false, // 禁用宽度动态变化（保持固定宽度）
      onSelected: context.go, // 菜单点击回调：使用GoRouter导航到对应路径
      tail: (_) => const MenuBarTailWidget(), // 侧边栏底部的附加组件（如用户信息、设置入口）
      leading: (_) => const MenuBarLeading(), // 侧边栏顶部的附加组件（如Logo、标题）
    );
  }

  late List<MenuMeta> deskNavBarMenus;

  // 在组件依赖的上下文（如本地化配置）变化时调用，确保菜单数据随本地化语言动态更新。
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppL10n l10n = AppL10n.of(context); // 获取当前上下文的本地化工具类
    deskNavBarMenus = AppTab.values
        .map((e) => e.menu(l10n))
        .toList(); // 将应用的页面标签（AppTab 枚举）转换为菜单数据（MenuMeta），每个菜单项的名称、路径等通过 e.menu(l10n) 结合本地化生成，确保菜单文本与当前语言一致。
  }

  // 匹配路由路径中以“/”开头的第一段（如“/home”）
  final RegExp _segReg = RegExp(r'/\w+');

  // 作用：根据当前路由路径，自动计算并返回当前激活的菜单 ID（即一级路由路径），使侧边栏中对应的菜单项高亮显示（通过 TolyRailMenuBar 的 activeId 参数实现）。
  // 实现逻辑：通过正则表达式提取当前路由的一级路径（如路由为 “/chat/detail” 时，提取 “/chat”），与菜单数据中的路径匹配，实现 “路由变化→激活项自动更新” 的联动效果。
  String? get activePath {
    final String path = GoRouterState.of(context).uri.toString(); // 获取当前路由路径
    RegExpMatch? match = _segReg.firstMatch(path); // 提取路径的第一段
    if (match == null) return null;
    String? target = match.group(0); // 得到当前路由的一级路径（如“/chat”“/contact”）
    return target;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tolyui/tolyui.dart';
import 'package:wolf_im/bloc/app_config_bloc.dart';
import 'package:wolf_im/config/toly_icon.dart';

// 1. ThemeModelSwitchIcon 是一个主题模式切换图标组件，核心功能是通过点击图标切换应用的深色 / 浅色主题，并根据当前主题动态显示对应的图标，适配桌面端交互体验。
class ThemeModelSwitchIcon extends StatelessWidget {
  const ThemeModelSwitchIcon({super.key});

  @override
  Widget build(BuildContext context) {
    // 通过 BuildContext 获取当前应用的主题亮度（Brightness.dark 为深色模式，Brightness.light 为浅色模式）。
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    // MouseRegion：监听鼠标状态，cursor: SystemMouseCursors.click 确保桌面端用户鼠标悬停时看到 “可点击” 光标，明确提示该图标可交互，提升桌面端体验。
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      // TolyAction：是 tolyui 库中的自定义可点击组件，类似 InkWell 但样式更统一，style: ActionStyle.dark() 使其背景和交互效果适配深色背景（如侧边栏的深灰色）。
      //
      // onTap 回调：核心交互逻辑，通过 context.read<AppConfigBloc>() 获取全局主题状态管理的 AppConfigBloc，调用 changeThemeMode 方法切换主题：
      //    若当前是深色模式（isDark = true），切换为浅色模式（ThemeMode.light）；
      //    若当前是浅色模式（isDark = false），切换为深色模式（ThemeMode.dark）。
      //
      // 此逻辑通过 Bloc 状态管理实现全局主题更新：AppConfigBloc 接收主题切换事件后，会更新全局状态，触发应用内所有依赖主题的组件重新构建（如颜色、字体样式等）。
      child: TolyAction(
        style: const ActionStyle.dark(), // 采用深色样式（适配侧边栏深色背景）
        onTap: () {
          context.read<AppConfigBloc>().changeThemeMode(
            isDark ? ThemeMode.light : ThemeMode.dark,
          );
        },

        // Icon 组件：根据当前主题模式显示不同图标，直观反馈当前主题状态：
        //    若当前是浅色模式（!isDark），显示 TolyIcon.dark（推测为 “深色模式图标”，如月亮图标，暗示 “点击切换到深色”）；
        //    若当前是深色模式（isDark），显示 TolyIcon.wb_sunny（推测为 “浅色模式图标”，如太阳图标，暗示 “点击切换到浅色”）。
        // 样式适配：白色图标（color: Colors.white）搭配侧边栏的深灰色背景（如 #2C3036），确保图标清晰可见；22px 大小平衡了视觉辨识度和布局紧凑性。
        child: Icon(
          !isDark ? TolyIcon.dark : TolyIcon.wb_sunny,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tolyui/tolyui.dart';
import 'package:wolf_im/bloc/app_config_bloc.dart';
import 'package:wolf_im/l10n/l10n.dart';

// 1. LocaleChangeMenuWidget是一个语言切换下拉组件，核心作用是：
//    展示当前选中的语言（通过 Bloc 状态获取）；
//    提供下拉菜单选择其他语言（选项来自Language枚举）；
//    选中语言后通过AppConfigBloc更新全局语言设置，触发应用本地化刷新。
class LocaleChangeMenuWidget extends StatelessWidget {
  const LocaleChangeMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> labels = Language.values.map((e) => e.label).toList();

    // DropMenuCellStyle：自定义下拉菜单单元格的样式类（推测来自tolyui库）。
    //  配置了菜单项的内边距、圆角、文本颜色、背景色、悬停状态样式等，适配应用的视觉风格（透明背景 + 小字体适合紧凑布局）。
    DropMenuCellStyle lightStyle = const DropMenuCellStyle(
      padding: EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 0,
      ), // 菜单项内边距（水平4px，垂直0）
      borderRadius: BorderRadius.all(Radius.circular(6)), // 菜单项圆角6px
      foregroundColor: Color(0xff1f1f1f), // 文本默认颜色（深灰色）
      backgroundColor: Colors.transparent, // 背景透明（继承父组件背景）
      disableColor: Color(0xffbfbfbf), // 禁用状态文本颜色（浅灰色）
      hoverBackgroundColor: Color(0xfff5f5f5), // 鼠标悬停时背景色（浅灰）
      hoverForegroundColor: Color(0xff1f1f1f), // 鼠标悬停时文本颜色（深灰）
      textStyle: TextStyle(
        fontFamily: '微软雅黑',
        fontSize: 12,
      ), // 文本样式（微软雅黑字体，12号大小）
    );

    // 从BuildContext中获取AppConfigBloc（全局状态管理），并监听其state中的language字段（当前选中的语言）。
    //    作用：实时获取当前应用的语言设置，确保下拉菜单的 “选中状态” 与实际语言一致
    Language language = context.select(
      (AppConfigBloc bloc) => bloc.state.language,
    );

    // 查找当前语言（language）在Language枚举中的位置索引（如中文是 0，英文是 1）。
    //  作用：用于设置下拉菜单的默认选中项（selectIndex），让用户直观看到当前语言。
    int index = Language.values.indexOf(language);

    // 层叠布局容器，用于将 “语言图标” 和 “下拉选择器” 叠加显示（图标在左，选择器覆盖在右侧）。
    return Stack(
      alignment: Alignment.centerLeft, // 子组件在垂直方向居中、水平方向靠左对齐
      children: [
        // 显示一个 “翻译” 图标（Icons.translate），固定在左侧，颜色为白色（适配深色背景，如侧边栏的深灰色），大小 14px（紧凑风格）。
        //  Padding确保图标不贴边，视觉更协调。
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 6.0,
          ), // 水平内边距6px（左右各留空隙）
          child: Icon(
            Icons.translate,
            color: Colors.white,
            size: 14,
          ), // 翻译图标（白色，14px大小）
        ),
        // IconTheme：确保下拉菜单内部的图标（如下拉箭头）颜色为白色，与深色背景对比明显。
        // DefaultTextStyle：确保下拉菜单的文本颜色为白色，避免因父组件样式继承导致的颜色错误。
        IconTheme(
          data: const IconThemeData(color: Colors.white), // 统一下拉菜单内图标的颜色为白色
          child: DefaultTextStyle(
            style: const TextStyle(color: Colors.white), // 统一下拉菜单内文本的颜色为白色
            // 下拉选择组件：配置下拉选择器的尺寸、样式、选项数据和选中状态，确保 UI 紧凑且与左侧图标不重叠。
            child: TolySelect(
              fontSize: 12, // 选中项文本大小12px
              cellStyle: lightStyle, // 下拉菜单项的样式（使用前面定义的lightStyle）
              data: labels, // 下拉选项的文本列表（如["中文", "English"]）
              selectIndex: index, // 当前选中项的索引（与当前语言匹配）
              iconSize: 16, // 下拉箭头图标的大小16px
              height: 26, // 选择器自身的高度26px（紧凑布局）
              width: 100, // 选择器宽度100px
              minWidth: 100, // 最小宽度100px（避免内容过短导致收缩）
              maxHeight: 180, // 下拉菜单的最大高度180px（超出可滚动）
              padding: const EdgeInsets.only(
                right: 6,
                left: 24,
              ), // 内边距：右6px，左24px（左24px预留图标位置，避免文字与左侧图标重叠）
              onSelected: (int index) async {
                Language type = Language.values[index];
                context.read<AppConfigBloc>().switchLanguage(type);
              },
            ),
          ),
        ),
      ],
    );
  }
}

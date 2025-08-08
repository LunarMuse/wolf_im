import 'package:flutter/material.dart';
import 'package:wolf_im/l10n/l10n.dart';
import 'package:wolf_im/routes/app_tab.dart';

// PureBottomBar 是一个无状态底部导航栏组件，依赖父组件传递的参数（点击回调和当前激活标签）来渲染 UI。
//    onTap：类型为 ValueChanged<int>?，当用户点击某个导航项时，会将该导航项的索引传递给父组件，由父组件处理切换逻辑（如切换页面）。
//    activeTab：类型为 AppTab（自定义的标签枚举），标识当前激活的标签，用于在 UI 上高亮显示对应的导航项。
class PureBottomBar extends StatelessWidget {
  // 点击导航项时的回调（参数为点击项的索引）
  final ValueChanged<int>? onTap;
  // 当前激活的标签（用于高亮显示）
  final AppTab activeTab;

  const PureBottomBar({
    super.key,
    this.onTap,
    required this.activeTab,
    // required this.labels,
    // required this.icons,
  });

  // onTap 与 currentIndex：
  //    两者配合实现导航交互：currentIndex 控制哪个导航项被高亮（通过 activeTab.index 关联当前激活的标签），onTap 接收点击事件并通知父组件切换标签，形成 “点击→父组件更新 activeTab→UI 重新渲染高亮新标签” 的闭环。
  // type: BottomNavigationBarType.fixed：
  //    当导航项数量较多（通常超过 3 个）时，设置为 fixed 可避免导航项自动折叠为滚动列表，确保所有标签固定显示在底部，适合移动端常见的 4-5 个标签场景。
  // 主题与样式适配：
  //    selectedItemColor 使用主题主色，确保选中项颜色与应用整体风格统一（如主题色为蓝色时，选中的导航项文本和图标均为蓝色）。
  //    selectedLabelStyle 加粗选中项文本，通过样式差异强化 “当前选中” 的视觉反馈，帮助用户快速识别当前页面。
  // 本地化与动态生成导航项：
  //    AppTab.mobileTabs 是一个包含所有移动端导航标签的列表（如 “首页”“消息”“我的” 等），通过 map 方法动态生成 BottomNavigationBarItem。
  //    每个导航项的文本 label 通过 tab.label(l10n) 获取，结合 AppL10n 实现多语言适配（如切换语言时，导航文本自动更新为对应语言）。
  @override
  Widget build(BuildContext context) {
    // 获取本地化工具类实例（用于导航项的文本本地化）
    AppL10n l10n = AppL10n.of(context);
    // 返回Flutter自带的底部导航组件
    return BottomNavigationBar(
      // 点击导航项时触发的回调（关联到父组件传递的onTap）
      onTap: onTap,
      // 当前激活项的索引（由activeTab的index属性决定，用于高亮）
      currentIndex: activeTab.index,
      // 导航栏的阴影高度（3px，增强立体感）
      elevation: 3,
      // fixedColor: themeColor.activeColor,
      // 导航栏类型：fixed表示导航项固定显示（即使数量多也不滚动，适合移动端固定标签）
      type: BottomNavigationBarType.fixed,
      iconSize: 22,
      // 选中项的颜色（使用应用主题的主色，保持主题一致性）
      selectedItemColor: Theme.of(context).primaryColor,
      // 选中项文本的样式（加粗，突出显示当前选中状态）
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      // 是否显示未选中项的文本（true：显示，确保用户能识别所有导航项）
      showUnselectedLabels: true,
      // 是否显示选中项的文本（true：显示，强化当前选中项的识别）
      showSelectedLabels: true,
      // backgroundColor: themeColor.itemColor,
      // 导航项列表（通过AppTab.mobileTabs生成）
      items: AppTab.mobileTabs
          .map(
            (AppTab tab) => BottomNavigationBarItem(
              // 导航项文本（通过tab的label方法结合本地化工具获取，支持多语言）
              label: tab.label(l10n),
              // 导航项图标（使用tab的icon属性，每个标签对应一个图标）
              icon: Icon(tab.icon),
            ),
          )
          .toList(),

      // labels
      //     .asMap()
      //     .keys
      //     .map((index) =>
      //
      //     .toList(),
    );
  }
}

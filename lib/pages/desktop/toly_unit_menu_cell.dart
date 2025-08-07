import 'package:flutter/material.dart';
import 'package:tolyui/tolyui.dart';
import 'package:tolyui_navigation/tolyui_navigation.dart';

// 1. Tween 是 Flutter 动画中的插值工具，用于在 begin 和 end 之间生成平滑过渡的值。
// 这三个插值器分别控制菜单单元格的宽度缩放、图标大小、文字大小的动画，使选中 /hover 状态变化更流畅。
//
// 宽度动画插值：从初始宽度（0.82×140）过渡到目标宽度（0.95×140）
final Tween<double> _widthTween = Tween(begin: 0.82, end: 0.95);
// 图标大小动画插值：从18px过渡到22px
final Tween<double> _sizeTween = Tween(begin: 18.0, end: 22.0);
// 文字大小动画插值：从14px过渡到15px
final Tween<double> _fontSizeTween = Tween(begin: 14.0, end: 15);

// 2. 带有动画效果的菜单单元格组件 FlutterUnitMenuCell，主要用于导航菜单（如侧边栏）中，通过动态样式变化（如背景色、大小、图标文字缩放）反馈选中状态，提升交互体验
class FlutterUnitMenuCell extends StatelessWidget {
  // MenuMeta 类型，存储菜单的基础信息（如标签 label、图标 icon 等）；
  final MenuMeta menu;
  // 是否启用tooltip提示;当菜单文本过长被截断时，显示完整标签。
  final bool enableTooltip;
  // DisplayMeta 类型，存储显示相关的状态（如是否选中 selected、动画进度 rate 等）；
  final DisplayMeta display;

  const FlutterUnitMenuCell.create(
    this.menu,
    this.display, {
    super.key,
    this.enableTooltip = false,
  });

  // 前景色（图标和文字颜色）：选中时为白色，未选中时为白色70%透明度
  Color? get foregroundColor =>
      display.selected ? Colors.white : Colors.white70;

  @override
  Widget build(BuildContext context) {
    double height = 42; // 单元格固定高度42px

    // 动画进度（0~1）：控制所有动画的过渡程度（如从0到1表示完成从“未选中”到“选中”的过渡）
    double anim = display.rate;

    // // 背景色动画：从“半透明白色”过渡到“主题主色”
    Color? color = ColorTween(
      begin: Colors.white.withAlpha(33), // 未选中时背景：白色，透明度33（接近透明）
      end: Theme.of(context).primaryColor, // 选中时背景：应用主题主色
    ).transform(anim); // 用动画进度计算当前颜色

    // 图标大小：通过_sizeTween和动画进度计算当前大小（18px → 22px）
    double iconSize = _sizeTween.transform(anim);
    // 文字大小：通过_fontSizeTween和动画进度计算当前大小（14px → 15px）
    double fontSize = _fontSizeTween.transform(anim);
    // menu 可能是一个基类 MenuMeta，IconMenu 是其派生类（包含 icon 属性），这里通过类型判断获取图标，确保只有图标菜单才显示图标。
    IconData? icon;
    if (menu is IconMenu) {
      icon = (menu as IconMenu).icon;
    }
    // 文本样式：使用动态计算的前景色和文字大小
    TextStyle style = TextStyle(color: foregroundColor, fontSize: fontSize);
    // 圆角配置：右侧上下角为半圆（半径=高度的一半，使右侧边缘呈弧形）
    Radius radius = Radius.circular(height / 2); // 半径=21px（42/2）
    BorderRadius br = BorderRadius.only(topRight: radius, bottomRight: radius);

    // 单元格主体：带背景和动画效果的容器
    Widget child = Container(
      padding: EdgeInsets.only(left: 12), // 左侧内边距12px（图标与左边缘间距）
      alignment: Alignment.centerLeft, // 内容靠左居中对齐
      decoration: BoxDecoration(color: color, borderRadius: br),
      // 宽度：通过_widthTween和动画进度计算（0.82×140 → 0.95×140，约114.8px → 133px）
      width: _widthTween.transform(anim) * 140,
      height: height, // 固定高度42px
      child: Row(
        spacing: 6,
        // crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(icon, color: foregroundColor, size: iconSize),
          Expanded(
            child: Text(
              menu.label,
              style: style,
              maxLines: 1,
              overflow: TextOverflow.ellipsis, // 超出部分显示省略号
            ),
          ),
          const SizedBox(width: 2), // 右侧预留2px间距，避免文本贴边
        ],
      ),
    );

    // 如果启用tooltip，当文本被截断时，鼠标悬停显示完整标签
    if (enableTooltip) {
      child = TolyTooltip(
        placement: Placement.right,
        message: menu.label,
        child: child,
      );
    }

    // 确保单元格整体靠左对齐（适应侧边栏布局）
    return Align(alignment: Alignment.centerLeft, child: child);
  }
}

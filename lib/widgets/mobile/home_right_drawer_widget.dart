import 'package:flutter/material.dart';
import 'package:wolf_im/widgets/circle.dart';
import 'package:wolf_im/widgets/mobile/edit_category_panel_widget.dart';
import 'package:wolf_im/widgets/mobile/home_drawer_header_widget.dart';

// HomeRightDrawerWidget 是一个右侧抽屉组件，通常通过移动端导航栏（如 Scaffold 的 endDrawer）触发显示，
//  主要功能是提供 “添加收藏集” 的交互入口，包含头部信息区、标题装饰区和编辑面板，整体样式适配应用主题。
class HomeRightDrawerWidget extends StatefulWidget {
  const HomeRightDrawerWidget({super.key});

  @override
  _HomeRightDrawerWidgetState createState() => _HomeRightDrawerWidgetState();
}

class _HomeRightDrawerWidgetState extends State<HomeRightDrawerWidget> {
  // 预留状态变量（当前未使用，可能用于未来扩展：如用户名、颜色配置、详情信息）
  String name = '';
  String color = '';
  String info = '';

  @override
  Widget build(BuildContext context) {
    // Drawer：Material 组件库中的抽屉容器，elevation:3 增加轻微阴影，区分抽屉与主页面，提升层次感。
    return Drawer(elevation: 3, child: _buildChild(context));
  }

  Widget _buildChild(BuildContext context) {
    // 获取当前主题的背景色（用于抽屉整体背景，实现与应用主题的统一）
    final Color color = Theme.of(context).scaffoldBackgroundColor;

    // 内容结构：从上到下依次为 “头部（HomeDrawerHeaderWidget）”→“标题（_buildTitle）”→“编辑面板（EditCategoryPanelWidget）”，形成清晰的功能分区。
    return Container(
      // 抽屉背景色：使用主题背景色，保持风格一致
      color: color,
      // 可滚动列表：确保内容超出屏幕时可滚动
      child: ListView(
        // 取消默认内边距，让内容贴边显示
        padding: EdgeInsets.zero,
        children: <Widget>[
          // 抽屉头部组件（如用户信息、标题）
          HomeDrawerHeaderWidget(color: color),
          // 装饰性标题栏（“添加收藏集”）
          _buildTitle(context),
          // 收藏集编辑面板（核心功能区）
          const EditCategoryPanelWidget(),
        ],
      ),
    );
  }

  // 功能：作为 “添加收藏集” 功能的视觉标题，通过对称设计增强美观度。
  // 设计细节：
  // 左右各一个 Circle 组件（主题主色，半径 5px），形成对称装饰，突出标题区域。
  // 文本 “添加收藏集” 居中显示，16px 字号适中，白色阴影在深色背景上提升可读性。
  // 整体通过 Padding 控制与上下内容的间距，避免拥挤。
  Widget _buildTitle(BuildContext context) {
    return Padding(
      // 上下内边距（控制与头部和面板的间距）
      padding: const EdgeInsets.only(top: 5.0, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // 左侧装饰圆点：使用主题主色，半径5px
          Circle(color: Theme.of(context).primaryColor, radius: 5),
          const Padding(
            // 左右间距8px（与圆点分隔）
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '添加收藏集',
              style: TextStyle(
                fontSize: 16,
                // 文字阴影：增强可读性（白色阴影在深色背景上更清晰）TODO:
                shadows: [
                  Shadow(
                    color: Colors.white,
                    offset: Offset(.5, .5), // 阴影偏移（右下0.5px）
                    blurRadius: 1, // 模糊半径1px
                  ),
                ],
              ),
            ),
          ),
          // 右侧装饰圆点：与左侧呼应，保持对称
          Circle(color: Theme.of(context).primaryColor, radius: 5),
        ],
      ),
    );
  }
}

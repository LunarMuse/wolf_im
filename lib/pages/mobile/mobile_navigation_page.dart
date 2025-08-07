import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wolf_im/pages/mobile/standard_home_page.dart';
import 'package:wolf_im/routes/app_tab.dart';
import 'package:wolf_im/widgets/mobile/home_right_drawer_widget.dart';
import 'package:wolf_im/widgets/mobile/pure_bottom_bar.dart';
import 'package:wolf_im/widgets/mobile/update_red_point.dart';

// 1. MobileNavigation是移动端导航组件，核心功能是实现移动端底部导航栏与页面切换的联动，
//  通过 PageController 控制页面跳转，用 ValueNotifier 管理当前激活的标签，同时适配移动端交互习惯（如禁止滑动切换页面，仅通过底部按钮切换）。
class MobileNavigationPage extends StatefulWidget {
  const MobileNavigationPage({super.key});

  @override
  State createState() => _MobileNavigationState();
}

class _MobileNavigationState extends State<MobileNavigationPage> {
  // PageController 是 Flutter 中控制 PageView 页面切换的核心工具（页面控制器）。
  //  用于控制 PageView 的页面切换（如跳转指定页面）；通过代码（而非手势）跳转页面；初始 0
  final PageController _controller = PageController();
  // ValueNotifier<AppTab> 是轻量状态管理工具，当 _activeTab.value 变化时，监听它的组件（如底部导航栏）会自动重建，同步显示当前激活状态。
  // AppTab 是页面标签枚举，如 chat、contact 等
  final ValueNotifier<AppTab> _activeTab = ValueNotifier(AppTab.chat);

  // NeverScrollableScrollPhysics 禁用 PageView 的滑动功能，确保页面切换只能通过底部导航按钮触发，符合部分移动端应用的交互设计（如微信底部导航不支持滑动切换）。
  // ==> 禁止 PageView 通过手势滑动切换页面（仅允许通过底部按钮切换）
  final ScrollPhysics _neverScroll = const NeverScrollableScrollPhysics();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid || Platform.isIOS) {}
    // String locale = context
    //     .read<AppConfigBloc>()
    //     .state
    //     .language
    //     .locale
    //     .toString();
    // context.read<UpgradeBloc>().add(CheckUpdate(appId: 1, locale: locale));
  }

  @override
  void dispose() {
    _controller.dispose(); //释放控制器
    _activeTab.dispose();
    super.dispose();
  }

  /// extendBody = true 凹嵌透明，需要处理底部 边距
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 关键：让页面内容延伸到底部导航栏下方（适合底部导航栏透明/半透明时，避免内容被遮挡）
      extendBody: true,
      // 右侧抽屉菜单（如个人中心、设置入口）
      endDrawer: const HomeRightDrawerWidget(),
      // PageView作为页面容器，其 children 是各个标签对应的页面（目前仅显示 StandardHomePage，其他为预留）。
      //  由于设置了 _neverScroll，用户无法通过左右滑动切换这些页面,通过 _controller 控制显示哪个。
      body: PageView(
        physics: _neverScroll, // 禁用滑动切换
        controller: _controller, // 绑定页面控制器
        children: [
          StandardHomePage(heard: Text("heard")),
          // GalleryUnit(),
          // AlgoScope(child: ArtifactPage()),
          // ArtSysScope(child: MobileArticlePage()),
          // // MobileToolPage(),
          // UserPage(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context), // 底部导航栏
    );
  }

  // 判断当前主题是否为深色模式（可能用于底部导航栏的样式适配）
  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  // 构建底部导航栏; 逻辑流程：用户点击底部导航的第 index 个按钮
  //   → 调用 _controller.jumpToPage(index) 切换到对应页面
  //   → 更新 _activeTab.value 为对应标签
  //   → ValueListenableBuilder 感知变化，让 PureBottomBar 高亮当前按钮，实现 “点击→切换页面→同步高亮” 的完整联动。
  //
  // 由于 bottomNavigationBar 颜色需要随 点击头部栏 状态而改变，
  // 使用 BlocBuilder 构建
  Widget _buildBottomNav(BuildContext context) {
    // 层叠布局：底部导航栏 + 右上角更新红点
    return Stack(
      children: [
        // ValueListenableBuilder: 监听 _activeTab 变化，当 _activeTab.value 改变时，会重新构建 PureBottomBar，确保底部导航栏的高亮状态与当前激活的标签一致。
        // PureBottomBar：自定义底部导航栏组件（推测包含多个标签按钮），通过 activeTab 接收当前激活标签，通过 onTap 回调处理点击事件。
        ValueListenableBuilder(
          valueListenable: _activeTab,
          builder: (_, value, __) =>
              PureBottomBar(onTap: _onTapBottomNav, activeTab: value),
        ),
        // Positioned + UpdateRedPoint：在底部导航栏右上角叠加一个红点提示（如 “有更新”“未读消息”），通过绝对定位固定位置。
        const Positioned(right: 22, top: 8, child: UpdateRedPoint()),
      ],
    );
  }

  // 点击底部导航按钮时触发：切换页面并更新激活状态
  void _onTapBottomNav(int index) {
    // 通过 PageController 跳转到对应索引的页面
    _controller.jumpToPage(index);
    // 更新激活标签（触发底部导航栏重新构建，高亮当前按钮）
    _activeTab.value = AppTab.values[index];
    // 当点击索引为3的按钮时（如“我的”页面），加载对应数据
    if (index == 3) {
      // BlocProvider.of<LikeWidgetBloc>(context).add(const EventLoadLikeData());
    }
  }
}

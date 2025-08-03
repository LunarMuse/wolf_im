import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wolf_im/pages/mobile/home_right_drawer.dart';
import 'package:wolf_im/pages/mobile/pure_bottom_bar.dart';
import 'package:wolf_im/pages/mobile/standard_home_page.dart';
import 'package:wolf_im/pages/mobile/update_red_point.dart';
import 'package:wolf_im/routes/app_tab.dart';

class UnitPhoneNavigation extends StatefulWidget {
  const UnitPhoneNavigation({super.key});

  @override
  State createState() => _UnitPhoneNavigationState();
}

class _UnitPhoneNavigationState extends State<UnitPhoneNavigation> {
  //页面控制器，初始 0
  final PageController _controller = PageController();
  final ValueNotifier<AppTab> _activeTab = ValueNotifier(AppTab.chat);

  // 禁止 PageView 滑动
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
      extendBody: true,
      endDrawer: const HomeRightDrawer(),
      body: PageView(
        physics: _neverScroll,
        controller: _controller,
        children: [
          StandardHomePage(heard: Text("heard")),
          // GalleryUnit(),
          // AlgoScope(child: ArtifactPage()),
          // ArtSysScope(child: MobileArticlePage()),
          // // MobileToolPage(),
          // UserPage(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  // 由于 bottomNavigationBar 颜色需要随 点击头部栏 状态而改变，
  // 使用 BlocBuilder 构建
  Widget _buildBottomNav(BuildContext context) {
    return Stack(
      children: [
        ValueListenableBuilder(
          valueListenable: _activeTab,
          builder: (_, value, __) =>
              PureBottomBar(onTap: _onTapBottomNav, activeTab: value),
        ),
        const Positioned(right: 22, top: 8, child: UpdateRedPoint()),
      ],
    );
  }

  // 点击底部按钮事件，切换页面
  void _onTapBottomNav(int index) {
    _controller.jumpToPage(index);
    _activeTab.value = AppTab.values[index];
    if (index == 3) {
      // BlocProvider.of<LikeWidgetBloc>(context).add(const EventLoadLikeData());
    }
  }
}

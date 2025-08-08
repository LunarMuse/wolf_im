import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wolf_im/l10n/ext.dart';
import 'package:wolf_im/pages/mobile/home_drawer_page.dart';
import 'package:wolf_im/widgets/mobile/round_rect_rab_indicator.dart';
import 'package:wolf_im/widgets/mobile/sliver_pinned_header.dart';
import 'package:wolf_im/widgets/mobile/standard_home_search.dart';

// 1. StandardHomePage 是一个支持多标签切换、嵌套滚动和状态保持的首页组件，
//    主要用于展示分类内容（如不同类型的组件、功能模块），并提供搜索、自定义头部等扩展功能，适配多语言和主题模式，是应用的核心页面之一。
class StandardHomePage extends StatefulWidget {
  // heard 参数：允许父组件传入自定义头部（如轮播图），增强页面扩展性。
  final Widget? heard;
  const StandardHomePage({super.key, this.heard});

  @override
  State<StandardHomePage> createState() => _StandardHomePageState();
}

// 2. SingleTickerProviderStateMixin：
//    提供动画帧回调，为 TabController（标签控制器）提供 vsync 支持，vsync绑定当前状态类（提供动画时钟）
// 3. AutomaticKeepAliveClientMixin：
//    通过 wantKeepAlive = true 实现页面状态保持，避免标签切换或页面跳转后重建，提升性能（如保留滚动位置、输入内容等）。
class _StandardHomePageState extends State<StandardHomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  // 4. _tabs 是标签文本列表，通过 context.l10n 获取本地化字符串（如中文 / 英文），支持多语言适配。
  //    标签内容暗示页面用于展示分类内容（如 “无状态组件”“有状态组件” 等不同类别的功能模块），是用户快速切换内容类别的入口。
  List<String> get _tabs => [context.l10n.stateless, context.l10n.stateful];

  // 5. TabController 是标签切换的核心控制器，关联 _tabs，负责同步标签选中状态和切换动画。
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    // TODO:fixed
    tabController = TabController(length: 2, vsync: this);
  }

  int maxCount = 60;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  // 当用户点击标签时触发，原计划用于切换页面内容分类（如从 “无状态组件” 切换到 “有状态组件”），当前为预留逻辑。
  void _switchTab(int index) {
    // WidgetFamily widgetFamily = WidgetFamily.values[index];
    // WidgetsBloc bloc = context.read<WidgetsBloc>();
    // if (bloc.state.filter.family == widgetFamily) return;
    // PrimaryScrollController.of(context).jumpTo(0);
    // context.switchWidgetFamily(widgetFamily);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // 必须调用，确保AutomaticKeepAliveClientMixin生效
    final AppBarTheme appBarTheme = AppBarTheme.of(context);
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    double bottom = MediaQuery.of(
      context,
    ).padding.bottom; // 获取底部安全区高度（如全面屏底部留白）
    return Scaffold(
      extendBody: true, // 内容延伸到底部安全区（避免底部留白）
      drawer: const HomeDrawerPage(), // 左侧抽屉菜单（如全局导航）
      body: Column(
        // 垂直布局：包含状态栏、主内容区、底部安全区
        children: [
          // a. 状态栏样式适配
          // AnnotatedRegion 通过关联 SystemUiOverlayStyle 类，实现对系统级 UI 元素（如 Android 的状态栏、iOS 的顶部状态栏和底部安全区）的样式定制。
          // 它是 “区域性” 的：仅影响其包裹的 child 所在的屏幕区域，不会全局生效（区别于在 MaterialApp 中全局设置的样式）。
          // 优先级高于全局样式：如果局部 AnnotatedRegion 定义了样式，会覆盖全局设置的系统 UI 样式。
          AnnotatedRegion<SystemUiOverlayStyle>(
            value: appBarTheme.systemOverlayStyle!,
            child: Container(
              color: isDark ? Colors.black : Colors.white,
              height: MediaQuery.of(context).padding.top,
            ),
          ),
          const Divider(color: Colors.red, height: 1), // only debug
          // b. 主内容区（可滚动）
          Expanded(
            // NestedScrollView 是 Flutter 中用于处理 “嵌套滚动” 场景的核心组件，专门解决 “外层滚动容器包含内层滚动容器时的滚动协同问题”，让多层滚动区域（如顶部固定 / 浮动的头部 + 可滚动的主体内容）实现无缝、协调的滚动体验。
            // 核心作用：协调多层滚动区域
            // 当页面存在 “多层可滚动内容” 时（例如：顶部有可滚动的搜索栏 / 标签栏 + 下方有可滚动的列表），普通的 SingleChildScrollView 或 ListView 会出现滚动冲突（内外层各自滚动，体验割裂）。
            //
            // NestedScrollView 的核心价值在于：将外层滚动（如头部区域）和内层滚动（如主体列表）的滚动行为 “绑定”，实现 “一次滚动操作同时影响多层内容”，例如：
            //
            // 向上滚动时，顶部头部区域先收缩 / 隐藏，然后主体列表开始滚动；
            // 向下滚动时，主体列表先滚动到顶部，然后顶部头部区域再展开。
            child: NestedScrollView(
              // 头部是否随滚动“浮动”（不被顶部遮挡）
              floatHeaderSlivers: true,
              // 构建外层头部（必须返回 sliver 组件，如 SliverAppBar、SliverPinnedHeader 等）（搜索栏、标签栏等）
              headerSliverBuilder: _buildHeader,
              // body: const WidgetPage(),
              //内层主体内容（通常是可滚动组件，如 ListView、GridView 等）
              body: Text("Chat Page"),
            ),
          ),
          // c. 底部安全区适配
          SizedBox(height: bottom),
        ],
      ),
    );
  }

  // headerSliverBuilder必须返回 sliver 类型组件（如 SliverAppBar、SliverPinnedHeader、SliverFloatingHeader 等），
  //    这些组件专门用于滚动容器中，支持随滚动进行拉伸、收缩、固定等动画。
  // 第二个参数 innerBoxIsScrolled 是布尔值，标识 “内层主体内容是否已滚动”（可用于动态调整头部样式，如滚动时改变头部背景透明度）。
  List<Widget> _buildHeader(BuildContext context, bool innerBoxIsScrolled) {
    Color themeColor = Theme.of(context).primaryColor;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return [
      // 搜索栏通过 SliverFloatingHeader 实现,浮动搜索栏（随滚动保持可见）
      const SliverFloatingHeader(
        snapMode: FloatingHeaderSnapMode.scroll, // 滚动时“吸附”效果（避免半隐藏）
        child: StandardHomeSearch(), // 左侧头像 + 中间搜索框 + 右侧收藏图标
      ),

      // 支持通过 heard 参数传入自定义头部组件（如轮播图、活动公告），增强页面扩展性。
      if (widget.heard != null)
        // 将普通Widget包装为sliver组件（用于列表头部）
        // 普通 Widget（如 Container、Text）不属于 Sliver 类型，无法直接作为 CustomScrollView 的子组件。
        //    而 SliverToBoxAdapter 的核心功能就是：将一个普通的 “Box 类型 Widget”（即占用水平面空间的 Widget）包装成 Sliver 类型，
        //    使其能被 CustomScrollView 识别并渲染。
        SliverToBoxAdapter(
          child: Container(
            height: 68,
            color: isDark ? Colors.black : Colors.white,
            child: widget.heard,
          ),
        ),

      // 标签栏通过 SliverPinnedHeader 固定在顶部，确保用户随时可以切换标签；支持横向滚动（isScrollable: true），适配标签数量较多的场景；
      // 指示器样式（圆角矩形、主题色）增强选中状态的视觉反馈(使TabBar固定在顶部，滚动时不消失，确保用户随时可切换标签。)。
      SliverPinnedHeader(
        color: isDark ? Colors.black : Colors.white,
        // TabBar 是 Flutter 提供的标签切换组件，这里通过一系列属性定制了其样式和交互，适配业务需求
        child: TabBar(
          onTap: _switchTab, // 点击标签时触发的回调（调用_switchTab方法）
          tabAlignment: TabAlignment.start, // 标签左对齐
          // 确保指示器宽度与标签文本完全匹配（而非占满整个标签栏宽度），精准突出选中的标签。
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: true, // 标签可横向滚动
          // 指示器样式（选中标签下方的高亮条）,RoundRectTabIndicator（圆角矩形指示器），替代默认的下划线，视觉更柔和
          indicator: RoundRectTabIndicator(
            // 主题色边框，3px宽
            borderSide: BorderSide(color: themeColor, width: 3),
          ),
          // 文本样式
          // 选中标签：14px 字号 + 加粗 + 主题色，视觉权重更高，用户能快速识别当前选中项。
          // 未选中标签：灰色文本，与选中状态形成明显对比，减少视觉干扰。
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          // tabController：绑定 TabController（之前定义的标签控制器），用于同步标签的选中状态（如代码切换标签时，UI 会同步高亮对应标签）。
          controller: tabController,
          labelColor: themeColor,
          indicatorWeight: 3,
          unselectedLabelColor: Colors.grey,
          indicatorColor: themeColor,
          tabs: _tabs.map((String name) => Tab(text: name)).toList(),
        ),
      ),
      // handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      // ),
    ];
  }

  // 开启状态保持：页面切换时不销毁，保留状态（如滚动位置）
  @override
  bool get wantKeepAlive => true;
}

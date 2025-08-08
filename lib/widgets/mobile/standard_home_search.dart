import 'package:flutter/material.dart';
import 'package:wolf_im/config/toly_icon.dart';
import 'package:wolf_im/l10n/ext.dart';
import 'package:wolf_im/widgets/feedback_widget.dart';

// 1. StandardHomeSearch 是一个顶部搜索栏组件，集成了头像（打开抽屉）、搜索框（跳转搜索页）、收藏图标（跳转收藏页）三大功能；
//    同时适配深色 / 浅色主题，并通过 PreferredSizeWidget 提供固定高度，适合作为页面顶部的核心交互入口。
//
// 2. implements PreferredSizeWidget：实现该接口意味着组件有固定的 “首选大小”，
//    通常用于需要明确高度的场景（如作为 AppBar 的子组件或顶部固定栏），确保布局时不会因内容变化导致高度波动。
class StandardHomeSearch extends StatelessWidget
    implements PreferredSizeWidget {
  const StandardHomeSearch({super.key});

  // preferredSize：固定高度为 51px（35px 搜索框高度 + 上下各 8px 外边距），
  //    宽度占满父容器（Size.fromHeight 中宽度默认为 double.infinity），保证搜索栏在不同设备上高度一致。
  @override
  Size get preferredSize => const Size.fromHeight(35 + 8 * 2);

  @override
  Widget build(BuildContext context) {
    // 判断当前主题是否为深色模式（用于后续样式适配）
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    // 背景容器：根据主题设置背景色，包裹整个搜索栏
    return ColoredBox(
      color: isDark ? Colors.black : Colors.white,
      // 横向排列：左侧头像 + 中间搜索框 + 右侧收藏图标
      child: Row(
        children: [
          // 左侧：用户头像（点击打开抽屉）
          _buildHead(context),
          // 中间：搜索框（占满剩余空间，点击跳转搜索页）
          //    搜索框采用 “不可编辑” 模式（enabled: false），仅作为点击区域，点击后通过 _toSearchPage 跳转到真正的搜索页面，
          //    避免直接在当前组件中处理输入逻辑，简化设计。
          Expanded(
            child: GestureDetector(
              onTap: () => _toSearchPage(context), // 点击搜索框跳转到搜索页
              child: Container(
                // 上下各8px外边距（总高度51px的由来）
                margin: const EdgeInsets.symmetric(vertical: 8),
                height: 35,
                child: TextField(
                  autofocus: false, // 不自动获取焦点（避免打开页面时弹出键盘）
                  enabled: false, // 禁用输入（仅作为点击区域，实际跳转搜索页）
                  cursorColor: Colors.blue,
                  maxLines: 1,
                  decoration: _topSearchInputDecoration(isDark, context),
                ),
              ),
            ),
          ),
          // 右侧：收藏图标（点击跳转收藏页）
          _buildCollectIcon(context),
        ],
      ),
    );
  }

  // 搜索框的样式配置
  InputDecoration _topSearchInputDecoration(bool isDark, BuildContext context) {
    String hintText = context.l10n.searchWidget; // 本地化提示文本（如“搜索组件”）
    return InputDecoration(
      filled: true, // 启用填充色
      // 填充色：深色模式深灰，浅色模式浅灰
      fillColor: isDark ? const Color(0xff292929) : const Color(0xffF3F6F9),
      // 左侧搜索图标（灰色，20px）
      prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20),
      // 图标约束：最大高度24px，最小宽度36px（避免图标变形）
      prefixIconConstraints: const BoxConstraints(maxHeight: 24, minWidth: 36),
      // 紧凑模式（减少默认内边距，让输入框更紧凑）
      isCollapsed: true,
      // 内边距：上下4px（垂直居中），右8px（避免文本贴右）
      contentPadding: const EdgeInsets.only(top: 4, bottom: 4, right: 8),
      // 边框样式
      border: const UnderlineInputBorder(
        borderSide: BorderSide.none, // 去掉边框线
        // 圆角6px（搜索框呈圆角矩形）
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      // 提示文本（本地化）
      hintText: hintText,
      // 提示文本样式（14px，默认灰色）
      hintStyle: const TextStyle(fontSize: 14),
    );
  }

  Widget _buildHead(BuildContext context) {
    return Padding(
      // 左右各12px边距（避免头像贴左边缘）
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      // 带点击反馈的组件（如点击时的水波纹或缩放效果）
      child: FeedbackWidget(
        // 打开左侧抽屉菜单
        onPressed: () => _openDrawer(context),
        // 圆形头像
        child: const CircleAvatar(
          radius: 16,
          backgroundImage: AssetImage('assets/images/icon_head.webp'),
        ),
      ),
    );
  }

  Widget _buildCollectIcon(BuildContext context) {
    return IconButton(
      // onPressed: () => context.push(AppRoute.collection.url),
      onPressed: () {
        debugPrint("跳转收藏页面");
      },
      icon: const Icon(TolyIcon.icon_collect, size: 22),
    );
  }

  void _toSearchPage(BuildContext context) {
    // Navigator.of(
    //   context,
    // ).push(FadePageRoute(child: const StandardSearchPageProvider()));
    debugPrint("跳转搜索页面");
  }

  void _openDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }
}

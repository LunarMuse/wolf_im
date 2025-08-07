import 'package:flutter/material.dart';
import 'package:tolyui/tolyui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wolf_im/config/app/app_const_field.dart';
import 'package:wolf_im/config/toly_icon.dart';
import 'package:wolf_im/widgets/desktop/circle_image_widget.dart';

// MenuBarLeading 是侧边导航栏的 “顶部标识区”，核心功能是：
//
//    展示用户信息（头像 + 名称），增强应用的个人化属性；
//    提供外部平台快捷入口（GitHub、掘金等），方便用户访问相关资源；
//    通过布局和样式设计（深色背景 + 白色元素、统一缩进和间距），与侧边栏整体风格保持一致，提升 UI 协调性。
class MenuBarLeading extends StatelessWidget {
  const MenuBarLeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 8,
      ), // 顶部20px、底部8px内边距（与顶部边缘和下方内容分隔）
      child: Column(
        // 垂直排列子组件（用户信息→链接图标→分割线→间距）
        children: [
          // 1. 用户信息区（头像+名称）
          Wrap(
            direction: Axis.vertical, // 垂直排列子组件
            spacing: 8, // 头像与名称的垂直间距8px
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // 可双击的头像
              GestureDetector(
                onDoubleTap: () {
                  // sendEvent(1);
                },
                // 圆形头像组件
                child: const CircleImageWidget(
                  image: AssetImage(AppConstField.appMenuBarLeadingCircleImage),
                  size: AppConstField.appMenuBarLeadingCircleImageSize,
                ),
              ),
              const Text(
                AppConstField.appMenuBarLeadingName,
                style: TextStyle(
                  color: Colors.white70,
                ), // 文本样式：白色70%透明度（适配深色背景）
              ),
            ],
          ),
          // 2. 外部平台链接图标区
          _buildIcons(),
          // 3. 分割线（分隔顶部个人区与下方导航菜单）;分割线右侧缩进20px（避免贴边，与左侧头像对齐）
          const Divider(color: Colors.white, height: 1, endIndent: 20),
          // 4. 底部间距（与下方导航菜单保持距离）
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // TODO:
  final List<LinkIconMenu> menus = const [
    LinkIconMenu(
      TolyIcon.icon_github,
      "https://github.com/toly1994328/FlutterUnit",
    ),
    LinkIconMenu(
      TolyIcon.icon_juejin,
      'https://juejin.im/user/5b42c0656fb9a04fe727eb37',
    ),
    LinkIconMenu(TolyIcon.icon_item, 'http://toly1994.com'),
  ];

  Widget _buildIcons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 8),
      child: Wrap(
        spacing: 8,
        children: menus
            .map(
              (menu) => TolyAction(
                style: const ActionStyle.dark(),
                onTap: menu.launch,
                child: Icon(menu.icon, color: Colors.white, size: 22),
              ),
            )
            .toList(),
      ),
    );
  }
}

// 外部链接数据模型与跳转工具类
class LinkIconMenu {
  final IconData icon;
  final String url;

  const LinkIconMenu(this.icon, this.url);

  void launch() => _launchUrl(url);

  void _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {}
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wolf_im/config/toly_icon.dart';
import 'package:wolf_im/widgets/mobile/home_drawer_header_widget.dart';
import 'package:wolf_im/widgets/mobile/no_div_expansion_tile.dart';

class HomeDrawerPage extends StatelessWidget {
  const HomeDrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(elevation: 3, child: _buildChild(context));
  }

  Widget _buildChild(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;

    return Container(
      color: color.withAlpha(33),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // 头像、简介
          HomeDrawerHeaderWidget(color: color),
          _buildItem(context, TolyIcon.icon_them, '应用设置', '/settings'),
          const Divider(height: 1),
          _buildFlutterUnit(context),
          const Divider(height: 1),
          _buildItem(context, TolyIcon.icon_kafei, '联系本王', '/about_me'),
        ],
      ),
    );
  }

  Widget _buildFlutterUnit(BuildContext context) => NoBorderExpansionTile(
    backgroundColor: Colors.white70,
    leading: Icon(Icons.extension, color: Theme.of(context).primaryColor),
    title: const Text('Flutter ITEM'),
    children: <Widget>[
      _buildItem(context, TolyIcon.icon_tag, '属性集录', ''),
      _buildItem(context, Icons.palette, '绘画集录', ''),
      _buildItem(context, Icons.widgets, '布局集录', ''),
      _buildItem(context, TolyIcon.icon_bug, '要点集录', ''),
    ],
  );

  Widget _buildItem(
    BuildContext context,
    IconData icon,
    String title,
    String linkTo, {
    VoidCallback? onTap,
  }) => ListTile(
    leading: Icon(icon, color: Theme.of(context).primaryColor),
    title: Text(title),
    trailing: Icon(Icons.chevron_right, color: Theme.of(context).primaryColor),
    onTap: () {
      if (linkTo.isNotEmpty) {
        context.push(linkTo);
        if (onTap != null) onTap();
      }
    },
  );
}

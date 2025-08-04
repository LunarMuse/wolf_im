import 'package:flutter/material.dart';
import 'package:fx_platform_adapter/fx_platform_adapter.dart';
import 'package:go_router/go_router.dart';
import 'package:wolf_im/pages/mobile/unit_navigation.dart';
import 'package:wolf_im/routes/app_route.dart';

GoRoute get chatRoute => GoRoute(
  path: AppRoute.chat.path,
  builder: (_, __) {
    if (kAppEnv.isDesktopUI) {
      // return const DeskWidgetPanel(header: NewsHeader());
      // PreferredDragToMoveWrapper窗口按钮：首选 拖动 移动 最大化/最小化 关闭等
      return PreferredDragToMoveWrapper(
        child: AppBar(
          title: const Text("chatRoute", style: TextStyle(fontFamily: '宋体')),
          actions: const [WindowButtons()],
        ),
      );
      // Center(child: Text("chatRoute"));
    }
    return const UnitPhoneNavigation();
  },
  // routes: [
  //   GoRoute(path: AppRoute.widgetDetail.path, builder: widgetDetailBuilder),
  // ],
);

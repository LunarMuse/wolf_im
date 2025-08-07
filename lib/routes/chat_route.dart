import 'package:flutter/material.dart';
import 'package:fx_platform_adapter/fx_platform_adapter.dart';
import 'package:go_router/go_router.dart';
import 'package:wolf_im/pages/mobile/mobile_navigation_page.dart';
import 'package:wolf_im/routes/app_route.dart';

GoRoute get chatRoute => GoRoute(
  path: AppRoute.chat.path,
  builder: (_, __) {
    if (kAppEnv.isDesktopUI) {
      // return const DeskWidgetPanel(header: NewsHeader());
      return const Text("chatRoute", style: TextStyle(fontFamily: '宋体'));
      // Center(child: Text("chatRoute"));
    }
    return const MobileNavigationPage();
  },
  // routes: [
  //   GoRoute(path: AppRoute.widgetDetail.path, builder: widgetDetailBuilder),
  // ],
);

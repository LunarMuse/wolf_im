import 'package:flutter/material.dart';
import 'package:fx_platform_adapter/fx_platform_adapter.dart';
import 'package:go_router/go_router.dart';
import 'package:wolf_im/pages/desktop/app_desk_navigation_page.dart';
import 'package:wolf_im/routes/chat_route.dart';
import 'package:wolf_im/routes/global_route.dart';
import 'package:wolf_im/routes/router.dart';
import 'package:wolf_im/routes/settings_route.dart';

RouteBase get appRoute {
  List<RouteBase> body = [
    // widgetsRoute,
    // noteRoute,
    // collectRoute,
    settingsRoute,
    // GoRoute(
    //   path: AppRoute.moreNews.path,
    //   builder: (ctx, __) => NewsPage(title: AppL10n.of(ctx).news),
    // ),
    // ...systemRoutes,
    chatRoute,
    ...globalRoutes, // TODO
  ];
  return GoRoute(
    // 是父路由的路径，它的作用是为嵌套在其 routes 中的子路由提供 “基准路径”，
    //  通过拼接形成完整路径，这是路由嵌套结构的自然结果（而非强制要求），这种设计能让路由结构更清晰、模块化更强。
    // 例如：父路由路径：AppRoute.home.path = '/home'；子路由 routes 中包含一个 GoRoute(path: 'dashboard')；
    //  则该子路由的完整路径为：/home/dashboard（父路径 + 子路径）。
    path: AppRoute.home.path,
    redirect: (_, __) => null,
    routes: [
      ...globalRoutes,
      if (kAppEnv.isDesktopUI)
        // ShellRoute：GoRouter 中的 “外壳路由”，作用是定义一个固定的父布局（外壳），所有子路由的内容会作为 child 嵌入到这个外壳中。
        // AppDeskNavigationPage(content: child)：桌面端的导航外壳组件，通常包含固定的导航元素（如左侧侧边栏菜单、顶部标题栏、底部状态栏等），
        //  child 是当前激活的子路由页面（即 body 中的某个页面），会显示在外壳的 “内容区域”。
        ShellRoute(
          builder: (_, __, Widget child) =>
              AppDeskNavigationPage(content: child),
          routes: body,
        ),
      if (!kAppEnv.isDesktopUI) ...body,
    ],
  );
}

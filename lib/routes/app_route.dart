import 'package:flutter/material.dart';
import 'package:fx_platform_adapter/fx_platform_adapter.dart';
import 'package:go_router/go_router.dart';
import 'package:wolf_im/pages/desktop/app_desk_navigation_page.dart';
import 'package:wolf_im/routes/chat_route.dart';
import 'package:wolf_im/routes/global_route.dart';

enum AppRoute {
  home('/', url: '/'),
  splash('splash', url: '/splash'),
  startError('start_error', url: '/start_error'),
  globalError('404', url: '/404'),

  /// chat widget
  chat('chat', url: '/chat');

  // /// widget module
  // widget('widget', url: '/widget'),
  // widgetDetail('detail/:name', url: '/widget/detail/'),
  // collection('collection', url: '/collection'),
  // collectionDetail('widgets/:id', url: '/collection/widgets/'),

  // // note('note', url: '/note'),
  // moreNews('more_news', url: '/more_news'),
  // painter('painter', url: '/painter'),
  // knowledge('knowledge', url: '/knowledge'),
  // tools('tools', url: '/tools'),

  // /// user/app
  // aboutApp('about_app', url: '/about_app'),
  // account('account', url: '/account'),
  // dataManage('data_manage', url: '/data_manage'),
  // aboutMe('about_me', url: '/about_me'),
  // supportMe('support_me', url: '/support_me'),

  // /// settings
  // settings('settings', url: '/settings'),
  // darkModel('dark_mode', url: '/setting/dark_mode'),
  // codeStyle('code_style', url: '/setting/code_style'),
  // themeColor('theme_color', url: '/setting/theme_color'),
  // fontSetting('font_setting', url: '/setting/font_setting'),

  // version('version', url: '/settings/version');

  final String path;
  final String url;

  const AppRoute(this.path, {required this.url});
}

RouteBase get appRoute {
  List<RouteBase> body = [
    // widgetsRoute,
    // noteRoute,
    // collectRoute,
    // settingsRoute,
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

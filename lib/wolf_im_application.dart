import 'package:flutter/material.dart';
import 'package:fx_boot_starter/fx_boot_starter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wolf_im/bloc/app_bloc_provider.dart';
import 'package:wolf_im/bloc/app_config_bloc.dart';
import 'package:wolf_im/bloc/app_start_repository.dart';
import 'package:wolf_im/config/app_config.dart';
import 'package:wolf_im/routes/app_route.dart';
import 'package:wolf_im/wolf_im.dart';

class WolfIMApplication with FxStarter<AppConfig> {
  const WolfIMApplication();

  // AppBlocProvider 是一个 “Bloc 注册与传递的封装器”，核心作用是：在应用的 Widget 树顶层集中注册 Bloc（如 AppConfigBloc），
  //  并将这些 Bloc 实例传递给子 Widget 树，使整个应用的组件能便捷地访问和管理共享状态。
  @override
  Widget get app => const AppBlocProvider(child: WolfIM());

  // AppStartRepo 的核心职责是封装应用启动阶段的初始化逻辑，具体包括：
  //    确保 Flutter 框架核心绑定初始化，为后续操作提供基础环境；
  //    配置性能优化参数（如手势重采样），提升应用运行体验；
  //    为桌面平台设置窗口尺寸，保证 UI 显示合理性；
  //    提供初始的应用配置对象（AppConfig），作为应用启动后的基础配置数据源。
  // 未来资源初始化等操作可以放在这里
  @override
  AppStartRepository<AppConfig> get repository => const AppStartRepo();

  @override
  void onLoaded(BuildContext context, int cost, AppConfig state) {
    debugPrint("App启动耗时:$cost ms");
    context.read<AppConfigBloc>().init(state);
  }

  @override
  void onStartSuccess(BuildContext context, AppConfig state) {
    debugPrint("App启动成功");
    // 应用启动过程初始是在闪屏页面，当程序启动成功后，会触发到此回调，最后跳转到主界面
    context.go(AppRoute.chat.url);
  }

  @override
  void onStartError(BuildContext context, Object error, StackTrace trace) {
    debugPrint("App启动失败");
    // 应用启动过程失败，跳转到异常界面
    context.go(AppRoute.startError.url, extra: error);
  }

  @override
  void onGlobalError(Object error, StackTrace stack) {
    // 程序运行过程，捕获到异常
    debugPrint("App启动存在异常;error:${error}, stack:${stack}");
  }
}

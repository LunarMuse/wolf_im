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

  @override
  Widget get app => const AppBlocProvider(child: WolfIM());

  @override
  AppStartRepository<AppConfig> get repository => const FlutterUnitStartRepo();

  @override
  void onLoaded(BuildContext context, int cost, AppConfig state) {
    debugPrint("App启动耗时:$cost ms");
    context.read<AppConfigBloc>().init(state);
  }

  @override
  void onStartSuccess(BuildContext context, AppConfig state) {
    debugPrint("App启动成功");
    context.go(AppRoute.chat.url);
  }

  @override
  void onStartError(BuildContext context, Object error, StackTrace trace) {
    debugPrint("App启动失败");
    context.go(AppRoute.startError.url, extra: error);
  }

  @override
  void onGlobalError(Object error, StackTrace stack) {
    debugPrint("App启动存在异常;error:${error}, stack:${stack}");
  }
}

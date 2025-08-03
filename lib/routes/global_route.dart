import 'package:go_router/go_router.dart';
import 'package:wolf_im/pages/home/app_start_error_page.dart';
import 'package:wolf_im/pages/home/splash_page.dart';
import 'package:wolf_im/routes/app_route.dart';

List<GoRoute> get globalRoutes => [
  GoRoute(path: AppRoute.splash.path, builder: (_, __) => const WolfIMSplash()),
  GoRoute(
    path: AppRoute.startError.path,
    builder: (_, GoRouterState state) => AppStartErrorPage(error: state.extra),
  ),
  GoRoute(
    path: AppRoute.globalError.path,
    builder: (_, GoRouterState state) => AppStartErrorPage(error: state.extra),
  ),
];

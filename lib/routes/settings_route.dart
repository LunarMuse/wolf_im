import 'package:go_router/go_router.dart';
import 'package:wolf_im/pages/settings/dark_theme_model_setting.dart';
import 'package:wolf_im/pages/settings/font_setting.dart';
import 'package:wolf_im/pages/settings/setting_page.dart';
import 'package:wolf_im/pages/settings/version_info.dart';
import 'package:wolf_im/routes/router.dart';

GoRoute get settingsRoute => GoRoute(
  path: AppRoute.settings.path,
  builder: (_, __) => const SettingPage(),
  routes: [
    GoRoute(
      path: AppRoute.darkModel.path,
      builder: (_, __) => const DarkThemeModelSetting(),
    ),
    // GoRoute(
    //   path: AppRoute.codeStyle.path,
    //   builder: (_, __) => const CodeStyleSettingPage(),
    // ),
    // GoRoute(
    //   path: AppRoute.themeColor.path,
    //   builder: (_, __) => const ThemeColorSettingPage(),
    // ),
    GoRoute(
      path: AppRoute.fontSetting.path,
      builder: (_, __) => const FontSettingPage(),
    ),
    GoRoute(
      path: AppRoute.version.path,
      builder: (_, __) => const VersionInfo(),
    ),
  ],
);

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/src/l10n/generated/quill_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:tolyui/app/toly_ui.dart';
import 'package:wolf_im/bloc/app_config_bloc.dart';
import 'package:wolf_im/config/app_config.dart';
import 'package:wolf_im/config/str_unit.dart';
import 'package:wolf_im/config/theme/app_theme.dart';
import 'package:wolf_im/l10n/l10n.dart';
import 'package:wolf_im/routes/app_route.dart';

class WolfIM extends StatefulWidget {
  const WolfIM({super.key});

  @override
  State<WolfIM> createState() => _WolfIMState();
}

class _WolfIMState extends State<WolfIM> {
  final GoRouter _router = GoRouter(
    initialLocation: AppRoute.splash.url,
    routes: <RouteBase>[appRoute],
    onException: (BuildContext ctx, GoRouterState state, GoRouter router) {
      router.go(AppRoute.globalError.url, extra: state.uri.toString());
    },
  );

  @override
  void initState() {
    super.initState();
  }

  void _onLocaleChange(BuildContext context, AppConfig state) {
    // context.read<WidgetsBloc>().changeLocale(state.language.locale);
  }

  @override
  Iterable<LocalizationsDelegate>? get localizationsDelegates => const [
    AppL10n.delegate,
    // AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    FlutterQuillLocalizations.delegate,
  ];

  @override
  List<Locale> get supportedLocales => l10nLocales;

  @override
  Widget build(BuildContext context) {
    AppConfig state = context.watch<AppConfigBloc>().state;
    ThemeData dark = darkTheme(state);
    ThemeData light = lightTheme(state);
    return BlocListener<AppConfigBloc, AppConfig>(
      listenWhen: (p, n) => p.language != n.language,
      listener: _onLocaleChange,
      child: DefaultTextStyle(
        style: TextStyle(fontFamily: state.fontFamily),
        child: TolyUiApp.router(
          routerConfig: _router,
          showPerformanceOverlay: state.showPerformanceOverlay,
          title: StrUnit.appName,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: localizationsDelegates,
          supportedLocales: supportedLocales,
          locale: state.language.locale,
          themeMode: state.themeMode,
          darkTheme: dark,
          theme: light,
        ),
      ),
    );
  }
}

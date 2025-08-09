import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/src/l10n/generated/quill_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:tolyui/app/toly_ui.dart';
import 'package:wolf_im/bloc/app_config_bloc.dart';
import 'package:wolf_im/config/app/app_config.dart';
import 'package:wolf_im/config/app/app_const_field.dart';
import 'package:wolf_im/config/theme/app_theme.dart';
import 'package:wolf_im/l10n/l10n.dart';
import 'package:wolf_im/routes/app_route.dart';
import 'package:wolf_im/routes/router.dart';

class WolfIM extends StatefulWidget {
  const WolfIM({super.key});

  @override
  State<WolfIM> createState() => _WolfIMState();
}

class _WolfIMState extends State<WolfIM> with LocalProvider {
  // initialLocation: 初始页面为启动闪屏页面
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
    AppL10n.delegate, // 应用自定义的本地化代理，负责加载应用自身业务相关的多语言资源（如页面标题、按钮文本、提示信息等）。
    GlobalMaterialLocalizations
        .delegate, // 为 Material Design 组件库 提供本地化支持，负责处理 Material 组件自带的文本和行为适配。
    GlobalCupertinoLocalizations
        .delegate, // 为 Cupertino 组件库（iOS 风格组件）提供本地化支持，类似 GlobalMaterialLocalizations，但针对 iOS 风格的组件，确保 iOS 风格组件在不同语言下的一致性。
    GlobalWidgetsLocalizations
        .delegate, // 处理 Widget 布局方向 等基础本地化配置，核心是控制文本和 UI 元素的排列方向（左到右 / 右到左），不同语言的阅读习惯不同（如英语、中文是左到右（LTR），阿拉伯语、希伯来语是右到左（RTL）），该代理会根据当前语言环境自动调整 Widget 的布局方向，当语言切换为阿拉伯语时，Row 中的子组件会从右到左排列，文本也会右对齐。
    FlutterQuillLocalizations
        .delegate, // 为第三方库 FlutterQuill（一个富文本编辑器）提供本地化支持，负责翻译该库内置的 UI 文本。
  ];

  @override
  List<Locale> get supportedLocales => l10nLocales;

  @override
  Widget build(BuildContext context) {
    AppConfig state = context.watch<AppConfigBloc>().state;
    ThemeData dark = darkTheme(state);
    ThemeData light = lightTheme(state);

    // BlocListener：用于监听AppConfig状态，当状态发生变化时，触发一些 “一次性” 的操作（如导航、弹窗、修改语种等），而不负责 UI 的构建。

    // DefaultTextStyle 是一个用于为子树（子组件层级）中的文本组件（如 Text、RichText 等）提供默认文本样式的组件。
    //    统一文本样式：
    //      当页面中有多个文本组件（如 Text）且样式（字体大小、颜色、粗细、字体家族等）基本一致时，
    //        无需在每个 Text 组件中重复设置样式，只需用 DefaultTextStyle 包裹它们，即可为所有子文本组件应用统一的默认样式。
    //    简化代码：
    //      减少重复的样式代码，提高代码复用性和可维护性。如果需要修改整体文本风格，只需修改 DefaultTextStyle 的样式，所有子文本组件会自动同步更新。
    //    样式继承规则：
    //      子文本组件如果没有显式设置自己的样式，会自动继承 DefaultTextStyle 的样式；
    //      如果子文本组件自己设置了样式（如 Text.style），则会覆盖 DefaultTextStyle 的对应属性（即子组件样式优先级更高）。

    // TolyUiApp类似于MaterialApp/GetMaterialApp：配置应用的核心行为：路由管理、性能调试、多语言支持、主题样式、系统标识等。
    //    MaterialApp.router 返回的根 Widget 是整个应用的容器（包含导航系统、主题等）；
    //    这个容器会根据 routerConfig 中的 initialLocation，在启动时自动加载并显示该路径对应的路由 Widget。
    //    简单说：MaterialApp.router 是 “舞台”，initialLocation 决定了 “舞台上的第一个演员”。

    // 1. supportedLocales：划定 “语言支持范围”
    //    supportedLocales 是一个 Locale 列表，用于声明应用能够处理的语言 / 地区（如 [Locale('en'), Locale('zh')] 表示支持英语和中文）。
    //    它是 “准入条件”：任何不在此列表中的语言 / 地区，应用都无法直接适配（即使系统语言是该语言，也会 fallback 到默认语言）。
    //    例如：若 supportedLocales 只包含 Locale('en')，则无论 locale 设置为哪种非英语语言，应用最终都会使用英语资源。
    // 2. locale：指定 “当前活跃语言”
    //    locale 是一个 Locale 对象，用于明确应用当前要使用的语言 / 地区（如 Locale('zh', 'CN') 表示简体中文）。
    //
    //    它的来源有两种：
    //      显式设置：通过状态管理（如 Bloc）保存用户手动切换的语言（如用户在设置中选择 “中文”）；
    //      隐式跟随系统：若 locale 为 null，应用会自动读取设备系统语言。
    //      它必须 “在 supportedLocales 范围内” 才能生效：如果 locale 指定的语言不在 supportedLocales 中，应用会尝试匹配最接近的支持语言（如系统语言是 Locale('zh', 'TW')，但 supportedLocales 只有 Locale('zh')，则会使用 zh 对应的资源）。
    // 3. localizationsDelegates：执行 “资源加载工作”
    //    localizationsDelegates 是本地化代理列表，负责根据 locale 指定的当前语言，加载对应的本地化资源（如字符串、组件文本、布局规则等）。
    //
    //    它是 “执行者”：当 locale 确定后，系统会遍历这些代理，调用它们的 load(locale) 方法，加载该语言对应的资源。
    //    不同代理分工不同（如 AppL10n.delegate 加载自定义文本，GlobalMaterialLocalizations.delegate 加载 Material 组件文本），但都依赖 locale 来确定加载哪种语言的资源。
    // 4. 三者协作流程：
    //    应用启动时，supportedLocales 声明支持的语言范围（如英语、中文）；
    //    确定 locale（可能是用户设置的中文，或系统默认的英语）；
    //    检查 locale 是否在 supportedLocales 中：
    //    若在，则通知 localizationsDelegates 加载该 locale 对应的资源；
    //    若不在，则 fallback 到 supportedLocales 中的默认语言（通常是列表第一个）；
    //    所有代理加载完成后，应用中所有依赖本地化的文本（自定义文本、组件文本等）都会显示 locale 对应的语言。
    // 5. 总结：三者的关系是 “范围（supportedLocales）→ 目标（locale）→ 执行（localizationsDelegates）”，共同支撑起 Flutter 应用的本地化能力。

    return BlocListener<AppConfigBloc, AppConfig>(
      listenWhen: (p, n) => p.language != n.language,
      listener: _onLocaleChange,
      child: DefaultTextStyle(
        style: TextStyle(fontFamily: state.fontFamily), // 统一字体
        child: TolyUiApp.router(
          routerConfig: _router, // 配置应用的路由系统，用于管理页面导航逻辑（如深层链接、路由栈管理、动态路由等）。
          // 控制是否显示性能叠加层（Performance Overlay）,会在屏幕上显示两个图表:上方图表：GPU 渲染帧率（GPU 绘制 UI 的效率）;下方图表：UI 线程帧率（Dart 代码执行的效率）。
          showPerformanceOverlay: state.showPerformanceOverlay,
          // 定义应用的 “官方名称”，主要用于系统级展示，而非 UI 直接显示的标题。(在 Android 的 “最近任务” 列表中显示应用名称；在 iOS 的多任务界面或系统弹窗中作为应用标识)
          title: AppConstField.appName,
          // 控制是否显示调试模式的 “DEBUG” 横幅。
          debugShowCheckedModeBanner: false,
          // 配置本地化代理，用于实现应用的多语言支持;本地化代理（LocalizationsDelegate）负责加载不同语言的资源（如字符串、日期格式、数字格式等）。
          localizationsDelegates: localizationsDelegates,
          // 指定应用支持的语言 / 地区列表。
          // 配合 localizationsDelegates 使用，定义应用能响应的语言（如中文、英文、日文等）。当系统语言或 locale 属性匹配列表中的语言时，应用会加载对应语言的资源。
          supportedLocales: supportedLocales,
          // 强制指定应用当前使用的语言 / 地区，优先级高于系统语言。
          // 通常从状态管理中获取用户手动设置的语言（如用户在应用内切换到英文），而非依赖系统语言。
          // 若为 null，应用会自动跟随系统语言（需在 supportedLocales 中包含系统语言）。
          locale: state.language.locale,
          // 控制应用使用的主题模式（亮色 / 暗色 / 跟随系统）。
          // ThemeMode.light：强制使用亮色主题；
          // ThemeMode.dark：强制使用暗色主题；
          // ThemeMode.system：跟随系统的主题设置（系统切换亮色 / 暗色时，应用自动同步）。
          // 通常通过状态管理保存用户的主题偏好，动态切换模式。
          themeMode: state.themeMode,
          // 定义暗色主题的样式配置（如颜色、字体、组件样式）。
          darkTheme: dark,
          // 作用：定义亮色主题的样式配置，是应用的默认主题。
          theme: light,
        ),
      ),
    );
  }
}

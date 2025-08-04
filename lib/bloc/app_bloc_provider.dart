import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolf_im/bloc/app_config_bloc.dart';

// 1. AppBlocProvider 类是一个自定义的 Bloc 状态管理提供者，主要作用是在 Widget 树中集中注册和提供 Bloc 实例，
//    方便子 Widget 树中的组件通过上下文（context）访问这些 Bloc，实现状态的共享和管理。

// 2. AppBlocProvider 接收一个 child 参数（需要被包裹的子 Widget），并通过 MultiBlocProvider 将注册的 Bloc 实例 “注入” 到子 Widget 树中。
//    这意味着：子 Widget 树中的任何组件（如页面、按钮等）都可以通过 BlocProvider.of<AppConfigBloc>(context) 或 context.read<AppConfigBloc>() 直接获取 AppConfigBloc 实例，无需手动传递。
//    例如，子组件中可以通过 context.read<AppConfigBloc>().add(ChangeThemeEvent()) 发送事件，或通过 BlocBuilder 监听 AppConfigBloc 的状态变化（如主题切换、语言切换等）。

// 3. 这样做的好处是：将 “Bloc 注册” 这一状态管理逻辑与 “UI 根组件”（如 MaterialApp）解耦，使代码结构更清晰，职责更单一（AppBlocProvider 专注于提供 Bloc，MaterialApp 专注于应用全局配置）。
class AppBlocProvider extends StatefulWidget {
  final Widget child;

  const AppBlocProvider({super.key, required this.child});

  @override
  State createState() => _AppBlocProviderState();
}

class _AppBlocProviderState extends State<AppBlocProvider> {
  @override
  Widget build(BuildContext context) {
    // MultiBlocProvider 是 Flutter Bloc 库提供的组件，用于同时注册多个 Bloc 实例（通过 providers 列表）。
    return MultiBlocProvider(
      providers: [BlocProvider<AppConfigBloc>(create: (_) => AppConfigBloc())],
      child: widget.child,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

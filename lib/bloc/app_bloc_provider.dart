import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolf_im/bloc/app_config_bloc.dart';

class AppBlocProvider extends StatefulWidget {
  final Widget child;

  const AppBlocProvider({Key? key, required this.child}) : super(key: key);

  @override
  State createState() => _AppBlocProviderState();
}

class _AppBlocProviderState extends State<AppBlocProvider> {
  @override
  Widget build(BuildContext context) {
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

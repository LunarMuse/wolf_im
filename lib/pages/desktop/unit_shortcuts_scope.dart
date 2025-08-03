import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fx_trace/fx_trace.dart';
import 'package:wolf_im/widgets/desktop/desk_search_bar_v2.dart';

class GlobalFind extends Intent {
  const GlobalFind();
}

class UnitShortcutsScope extends StatefulWidget {
  final Widget child;

  const UnitShortcutsScope({super.key, required this.child});

  @override
  State<UnitShortcutsScope> createState() => _UnitShortcutsScopeState();
}

class _UnitShortcutsScopeState extends State<UnitShortcutsScope>
    with FxEmitterMixin {
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyF):
            const GlobalFind(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          GlobalFind: CallbackAction<GlobalFind>(onInvoke: _onGlobalSearch),
        },
        child: widget.child,
      ),
    );
  }

  @override
  void onEvent(FxEvent event) {
    // if (event is SelectWidgetEvent) {
    //   context.push('/widget/detail/${event.name}', extra: event.model);
    // }
  }

  Object? _onGlobalSearch(GlobalFind intent) {
    showDialog(context: context, builder: (_) => const GlobalFindDialog());
    return null;
  }
}

import 'package:flutter/material.dart';
import 'package:fx_platform_adapter/fx_platform_adapter.dart';
import 'package:tolyui/basic/basic.dart';

class AppStartErrorPage extends StatelessWidget {
  final Object? error;
  const AppStartErrorPage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    final List<Widget> barActions = <Widget>[];
    if (kAppEnv.isDesktop) {
      barActions.add(WindowButtons());
    }

    return Scaffold(
      appBar: PreferredDragToMoveWrapper(
        child: AppBar(
          title: const Text("App 启动异常", style: TextStyle(fontFamily: '宋体')),
          actions: barActions,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    const Text('应用启动异常:'),
                    Text(
                      error.toString(),
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  ],
                ),
              ),
            ),
            TolyLink(
              href: 'https://github.com/LunarMuse/wolf_im',
              text: 'Github 开源地址: wolf im',
              onTap: (l) {},
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

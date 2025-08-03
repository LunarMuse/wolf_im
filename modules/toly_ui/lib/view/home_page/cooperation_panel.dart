import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tolyui/tolyui.dart';

class CooperationPanel extends StatelessWidget {
  final bool isDense;

  const CooperationPanel({super.key, this.isDense = false});

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry padding = isDense
        ? const EdgeInsets.only(top: 46, bottom: 12)
        : const EdgeInsets.only(bottom: 46.0, top: 72);

    Palette foreground = const Palette(
        normal: Color(0xff606266), hover: Color(0xff096dd9), pressed: Color(0xff096dd9));
    Palette border = const Palette(
        normal: Color(0xffd9d9d9), hover: Color(0x44409eff), pressed: Color(0xff096dd9));
    Palette bg = const Palette(
        normal: Color(0xff1890ff), hover: Color(0xffecf5ff), pressed: Color(0xffecf5ff));
    return Center(
        child: Padding(
      padding: padding,
      child: Column(
        children: [
          const Text(
            '合作与赞助',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff606266)),
          ),
          SizedBox(height: isDense ? 24 : 48),
          Wrap(
            runSpacing: 24,
            spacing: 24,
            children: [
              SizedBox(
                width: 240,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/fx.png',
                      width: 42,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Fx 架构",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Flutter 全平台开发框架",
                          style: TextStyle(color: Color(0xff606266)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 240,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/plcki.jpg',
                      width: 42,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "PLCKI",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "编程语言通用知识接口",
                          style: TextStyle(color: Color(0xff606266)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: isDense ? 24 : 48),
          TolyTooltip(
            richMessage: TextSpan(children: [
              TextSpan(
                text: '请通过此邮箱联系我们\n ',
              ),
              TextSpan(
                style: TextStyle(color: Colors.blue),
                text: '1981462002@qq.com ',
              )
            ]),
            placement: Placement.top,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            gap: 12,
            textAlign: TextAlign.center,
            child: ElevatedButton(
                style: OutlineButtonPalette(
                  borderRadius: BorderRadius.circular(20),
                  foregroundPalette: foreground,
                  borderPalette: border,
                  backgroundPalette: bg,
                ).style,
                onPressed: () {
                  context.go('/sponsor');
                },
                child: const Text('成为赞助商!')),
          )
        ],
      ),
    ));
  }
}

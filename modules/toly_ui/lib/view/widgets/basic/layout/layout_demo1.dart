import 'package:flutter/material.dart';
import 'package:tolyui/tolyui.dart';

import '../../display_nodes/display_nodes.dart';

@DisplayNode(
  title: '基础布局',
  desc:  '通过基础的 24 分栏，迅速简便地创建布局。',
)
class LayoutDemo1 extends StatelessWidget {
  const LayoutDemo1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row$(
          cells: [
            Cell(span: 24.rx, child: const Box(color: Color(0xff99a9bf)))
          ],
        ),
        const SizedBox(height: 12),
        Row$(
          cells: [
            Cell(span: 12.rx, child: const Box(color: Color(0xffd3dce6))),
            Cell(span: 12.rx, child: const Box(color: Color(0xffe5e9f2))),
          ],
        ),
        const SizedBox(height: 12),
        Row$(
          cells: [
            Cell(span: 8.rx, child: const Box(color: Color(0xffd3dce6))),
            Cell(span: 8.rx, child: const Box(color: Color(0xffe5e9f2))),
            Cell(span: 8.rx, child: const Box(color: Color(0xffd3dce6))),
          ],
        ),
        const SizedBox(height: 12),
        Row$(
          cells: [
            Cell(span: 6.rx, child: const Box(color: Color(0xffd3dce6))),
            Cell(span: 6.rx, child: const Box(color: Color(0xffe5e9f2))),
            Cell(span: 6.rx, child: const Box(color: Color(0xffd3dce6))),
            Cell(span: 6.rx, child: const Box(color: Color(0xffe5e9f2))),
          ],
        ),
      ],
    );
  }
}

class Box extends StatelessWidget {
  final Color color;
  final String? text;

  const Box({super.key, required this.color, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: text != null ? Text(text!) : null,
    );
  }
}

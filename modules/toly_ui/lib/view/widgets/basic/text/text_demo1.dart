import 'package:flutter/material.dart';
import '../../display_nodes/display_nodes.dart';

@DisplayNode(
  title: '基础用法',
  desc: '文字的展示基于 Flutter 框架内置的 Text 组件。它可以通过 style 设置文字样式，Text 组件展示的文本默认不能被选择操作。',
)
class TextDemo1 extends StatelessWidget {
  const TextDemo1({super.key});

  @override
  Widget build(BuildContext context) {
    const String info = 'TolyUI 是张风捷特烈打造的 Flutter 全平台应用开发 UI 框架。具备全平台、组件化、源码开放、响应式四大特点。提供大量 Flutter 框架内部之外的常用组件，帮助开发者迅速构建具有响应式的全平台应用软件。';
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text('介绍',style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
        ),
        Text(info,style:  TextStyle(color: Color(0xff606266)),),
      ],
    );
  }
}

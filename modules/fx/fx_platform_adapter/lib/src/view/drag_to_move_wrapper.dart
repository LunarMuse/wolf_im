import 'package:flutter/material.dart';

import '../data/global.dart';

class PreferredDragToMoveWrapper extends StatelessWidget
    implements PreferredSizeWidget {
  final PreferredSizeWidget child;
  final bool canDouble;

  const PreferredDragToMoveWrapper(
      {super.key, required this.child, this.canDouble = false});

  @override
  Widget build(BuildContext context) {
    return DragToMoveWrapper(
      canDouble: canDouble,
      child: child,
    );
  }

  @override
  Size get preferredSize => child.preferredSize;
}

class DragToMoveWrapper extends StatelessWidget {
  final Widget child;
  final bool canDouble;

  const DragToMoveWrapper(
      {super.key, required this.child, this.canDouble = false});

  // 在桌面端，通过 GestureDetector 为子组件添加手势监听：
  //    onPanStart: (details) => windowManager.startDragging()
  //    作用：当用户在子组件区域按下并开始拖动（pan 手势开始）时，触发窗口拖拽。
  //    原理：windowManager 是一个桌面窗口管理库（如 flutter_window_manager），startDragging() 方法会通知操作系统：当前窗口进入拖拽状态，跟随鼠标 / 触摸移动。
  //
  //    onDoubleTap: ...
  //    作用：当 canDouble 为 true 时，双击子组件区域会切换窗口的最大化状态。
  //    逻辑：
  //    通过 windowManager.isMaximized() 判断当前窗口是否为最大化状态；
  //    若已最大化，则调用 windowManager.unmaximize() 恢复到原来尺寸；
  //    若未最大化，则调用 windowManager.maximize() 将窗口放大到全屏。

  //    behavior: HitTestBehavior.translucent
  //    确保手势监听对 “透明区域” 也生效（例如子组件是透明背景时，依然能响应拖拽和双击），避免交互失效。

  @override
  Widget build(BuildContext context) {
    if (!kAppEnv.isDesktop) return child;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onDoubleTap: !canDouble
          ? null
          : () async {
              bool isMax = await windowManager.isMaximized();
              if (isMax) {
                windowManager.unmaximize();
              } else {
                windowManager.maximize();
              }
            },
      onPanStart: (details) {
        windowManager.startDragging();
      },
      child: child,
    );
  }
}

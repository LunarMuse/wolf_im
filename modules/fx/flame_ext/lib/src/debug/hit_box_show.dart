import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

extension HitBoxShow on Component {
  void toggleHitBoxTree({Color color = Colors.orange}) {
    // ComponentSet children = this.children;
    // for (int i = 0; i < children.length; i++) {
    //   Component c = children.elementAt(i);
    //   if (c.children.isEmpty) {
    //     if (c is RectangleHitbox) {
    //       c.debugMode = !c.debugMode;
    //       c.debugColor = color;
    //     }
    //   } else {
    //     c.toggleHitBoxTree();
    //   }
    // }

    for (final child in this.children) {
      // 如果是矩形碰撞盒，切换调试模式并设置颜色
      if (child.children.isEmpty) {
        if (child is RectangleHitbox) {
          child.debugMode = !child.debugMode;
          child.debugColor = color;
        }
      } else {
        // 递归处理子组件
        child.toggleHitBoxTree(color: color);
      }
    }
  }
}

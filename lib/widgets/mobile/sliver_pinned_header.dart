import 'package:flutter/material.dart';

// 1. SliverPinnedHeader 是一个自定义的 Sliver 组件，
//    核心功能是实现 “滚动时固定在顶部的头部”（如固定的标签栏、筛选栏），
//    通过封装 SliverPersistentHeader 和自定义 delegate，简化了 “固定头部” 的实现逻辑。
class SliverPinnedHeader extends StatelessWidget {
  // 子组件：必须是 PreferredSizeWidget（有固定高度的组件，如 TabBar、AppBar），
  //    因为这类组件有 preferredSize 属性（固定高度），确保头部高度可预测。
  final PreferredSizeWidget child;
  final Color color;

  SliverPinnedHeader({required this.child, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    // 返回系统的 SliverPersistentHeader（持久化头部组件）
    return SliverPersistentHeader(
      // 关键：设为 true 表示头部滚动时会固定在顶部
      pinned: true,
      // 关联自定义的代理类，定义头部的样式和行为
      delegate: _SliverPinnedHeaderDelegate(child: child, color: color),
    );
  }
}

// shrinkOffset：头部滚动时的偏移量（0 表示完全展开，maxExtent 表示完全收缩）。
//    在当前实现中，由于 minExtent 和 maxExtent 相等（见下文），该值始终为 0，头部不会收缩。
// overlapsContent：标识头部是否与下方内容重叠（如滚动时头部覆盖列表项），可用于动态调整透明度（当前未使用）。
// 功能：返回一个带背景色的容器，内部包裹传入的 child（如标签栏），确保头部有统一的背景色。
class _SliverPinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSizeWidget child;
  final Color color;

  _SliverPinnedHeaderDelegate({required this.child, required this.color});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset, // 滚动时的收缩偏移量（0 → 最大偏移）
    bool overlapsContent, // 是否与下方内容重叠（通常用于调整透明度）
  ) {
    // 用 ColoredBox 设置背景色，包裹子组件
    return ColoredBox(color: color, child: child);
  }

  // 这两个值决定了头部的高度范围：
  // 当 minExtent == maxExtent 时，头部高度固定不变（等于子组件的 preferredSize.height），不会随滚动收缩或拉伸。
  // 例如：如果 child 是 TabBar（默认高度 46px），则头部高度固定为 46px。
  //
  // 头部的最大高度（滚动时不会超过此值）
  @override
  double get maxExtent => child.preferredSize.height;

  // 头部的最小高度（滚动时不会小于此值）
  @override
  double get minExtent => child.preferredSize.height;

  // 当子组件或背景色变化时，需要重建头部
  @override
  bool shouldRebuild(covariant _SliverPinnedHeaderDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.color != color;
  }
}

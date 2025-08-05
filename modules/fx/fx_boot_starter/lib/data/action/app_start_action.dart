import 'package:flutter/material.dart';

// AppStartAction定义应用启动过程的 “生命周期接口”，规范启动流程中关键节点的行为。
// 通过三个抽象方法，规定了应用启动的三个核心阶段的处理逻辑（泛型 S 表示启动过程中处理的核心状态数据，如 AppConfig）：
//  onStartError：启动初始化失败时的回调（如初始化本地存储失败），用于处理错误（如跳转错误页面、提示用户）；
//  onLoaded：初始化加载完成（但未完全启动成功）时的回调，用于处理初始化结果（如用加载的配置数据初始化 Bloc、预加载资源）；
//  onStartSuccess：初始化成功且满足启动条件（如达到最低延迟）时的回调，用于执行启动完成后的操作（如跳转到主界面）。
abstract class AppStartAction<S> {
  const AppStartAction();

  /// 初始化加载失败
  /// 可跳转失败界面, 引导用户处理启动异常
  void onStartError(BuildContext context, Object error, StackTrace trace);

  /// 初始化加载成功
  /// 可在回调中获得异步加载的 App 配置数据处理
  /// 并做一些首页预加载的逻辑
  void onLoaded(BuildContext context, int cost, S state);

  /// 初始化成功，且达到最低延迟毫秒数
  /// 可跳转应用主界面,正常使用应用
  void onStartSuccess(BuildContext context, S state);
}

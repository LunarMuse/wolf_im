import 'dart:async';

import 'package:flutter/material.dart';

import '../fx_boot_starter.dart';

// FxStarter提供应用启动的 “通用骨架实现”，封装启动流程的共性逻辑（如启动入口、异常捕获、根组件构建）。
// 实现 AppStartAction<T> 接口，要求使用它的类（如 WolfIMApplication）必须实现启动生命周期的回调方法；
// 定义抽象成员 app（应用根 Widget）和 repository（启动初始化仓库），强制具体应用提供核心依赖；
// run 方法：作为应用启动入口，使用 runZonedGuarded 包裹启动逻辑，实现全局异常捕获（通过 onGlobalError 处理）；
// _runApp 方法：构建应用根组件 AppStartScope，将 repository（初始化逻辑）、appStartAction（当前混入类实例，即启动回调）和 app（根 Widget）关联起来，形成完整的启动上下文。
mixin FxStarter<T> implements AppStartAction<T> {
  Widget get app;

  AppStartRepository<T> get repository;

  void run(List<String> args) {
    runZonedGuarded(_runApp, onGlobalError);
  }

  void _runApp() {
    runApp(
      AppStartScope<T>(
        repository: repository,
        appStartAction: this,
        child: app,
      ),
    );
  }

  void onGlobalError(Object error, StackTrace stack);
}

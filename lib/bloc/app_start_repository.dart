import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fx_boot_starter/fx_boot_starter.dart';
import 'package:fx_platform_adapter/fx_platform_adapter.dart';
import 'package:path/path.dart' as path;
import 'package:wolf_im/config/app_config.dart';
import 'package:wolf_im/config/app_config_po.dart';
import 'package:wolf_im/config/sp_storage.dart';

// 1. AppStartRepo 类是一个应用启动初始化仓库（Repository），主要负责在应用启动阶段执行必要的初始化任务，并提供初始的应用配置信息。
//  它遵循了 “仓储模式（Repository Pattern）”，将应用启动的初始化逻辑封装起来，便于管理和复用。

// 2. 该类实现了泛型接口 AppStartRepository<AppConfig>，这意味着它需要遵循接口定义的规范（必须实现 initApp() 方法）。
class AppStartRepo implements AppStartRepository<AppConfig> {
  const AppStartRepo();

  // 这是类的核心方法，返回 Future<AppConfig>，是一个异步初始化方法，负责执行应用启动前的必要操作，并最终返回初始配置。
  @override
  Future<AppConfig> initApp() async {
    // 作用：确保 Flutter 框架的核心绑定（WidgetsFlutterBinding）已初始化。
    // 背景：Flutter 应用启动时，需要先初始化与引擎交互的绑定层（负责渲染、输入等核心功能）。
    //  在执行需要访问 Flutter 引擎的代码（如插件初始化、窗口配置）前，必须调用此方法，否则可能导致崩溃。
    WidgetsFlutterBinding.ensureInitialized();

    // 作用：启用手势事件的 “重采样” 优化，提升滚动性能。
    // 细节：这是 Flutter 1.22.0 及以上版本提供的滚动性能优化选项，通过调整手势事件的采样频率，减少快速滚动时的卡顿，让滑动体验更流畅。
    GestureBinding.instance.resamplingEnabled = true;

    // 作用：配置应用窗口的尺寸（主要针对桌面平台，如 Windows、macOS、Linux）。
    // 具体配置：
    //    minimumSize: const Size(1080, 680)：限制窗口最小尺寸为 1080x680，避免用户将窗口缩放到过小导致 UI 错乱。
    //    size: const Size(1180, 680)：设置应用启动时的初始窗口尺寸为 1180x680。
    // 说明：WindowSizeAdapter 是一个封装了桌面窗口尺寸操作的工具类，这行代码确保桌面应用启动时的窗口大小符合预期。
    WindowSizeAdapter.setSize(
      minimumSize: const Size(1080, 680),
      size: const Size(1180, 680),
    );

    await SpStorage().initSp();

    // 作用：返回一个初始的 AppConfig 实例。
    // 说明：AppConfig 是存储应用基础配置的模型类（如默认主题、语言、是否首次启动等），
    //  这里返回的实例可能包含默认配置，后续可结合本地存储（如 SharedPreferences）加载持久化的用户配置。
    // return AppConfig();
    AppConfigPo po = await SpStorage().appConfig.read();
    AppConfig state = AppConfig.fromPo(po);
    return state;
  }

  Future<void> initDb() async {
    //数据库不存在，执行拷贝
  }

  Future<void> _doCopyAssetsDb(String dbPath) async {
    Directory dir = Directory(path.dirname(dbPath));
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }
    ByteData data = await rootBundle.load("assets/flutter.db");
    List<int> bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );
    await File(dbPath).writeAsBytes(bytes, flush: true);
  }
}

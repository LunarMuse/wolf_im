import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fx_boot_starter/fx_boot_starter.dart';
import 'package:fx_platform_adapter/fx_platform_adapter.dart';
import 'package:path/path.dart' as path;
import 'package:wolf_im/config/app_config.dart';

class FlutterUnitStartRepo implements AppStartRepository<AppConfig> {
  const FlutterUnitStartRepo();

  /// 初始化 app 的异步任务
  /// 返回本地持久化的 AppConfig 对象
  @override
  Future<AppConfig> initApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    // 滚动性能优化 1.22.0
    GestureBinding.instance.resamplingEnabled = true;
    WindowSizeAdapter.setSize(
      minimumSize: const Size(1080, 680),
      size: const Size(1180, 680),
    );

    debugPrint("FlutterUnitStartRepo init app");
    // await SpStorage().initSp();
    // await initAppMeta();
    //
    // registerHttpClient();
    // NoteEnv().attachBridge(UnitNoteBridge());
    // if (!kAppEnv.isWeb) await initDb();
    // HttpUtil.instance.rebase(PathUnit.baseUrl);
    // AppConfigPo po = await SpStorage().appConfig.read();
    return AppConfig();
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

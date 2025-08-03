import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolf_im/config/app_config.dart';
import 'package:wolf_im/config/app_config_cao.dart';
import 'package:wolf_im/config/cons.dart';
import 'package:wolf_im/config/sp_storage.dart';
import 'package:wolf_im/l10n/l10n.dart';

class AppConfigBloc extends Cubit<AppConfig> {
  AppConfigBloc() : super(const AppConfig());

  @override
  Future<void> close() async {
    // _subscription.cancel();
    super.close();
  }

  void init(AppConfig state) {
    emit(state);
  }

  AppConfigCao get cao => SpStorage().appConfig;

  // 切换字体事件处理 : 固化索引 + 产出新状态
  void switchFontFamily(String family) async {
    AppConfig newState = state.copyWith(fontFamily: family);
    cao.write(newState.toAppConfigPo());
    emit(newState);
  }

  // 切换语言事件处理 : 固化索引 + 产出新状态
  void switchLanguage(Language language) async {
    AppConfig newState = state.copyWith(language: language);
    cao.write(newState.toAppConfigPo());
    emit(newState);
  }

  // 切换主题色事件处理 : 固化索引 + 产出新状态
  void switchThemeColor(ThemeColor color) async {
    AppConfig newState = state.copyWith(themeColor: color);
    cao.write(newState.toAppConfigPo());
    emit(newState);
  }

  // 切换背景显示事件处理 : 固化数据 + 产出新状态
  void switchShowBg(bool show) async {
    AppConfig newState = state.copyWith(showBackGround: show);
    cao.write(newState.toAppConfigPo());
    emit(newState);
  }

  // 切换背景显示事件处理 : 产出新状态
  void switchShowOver(bool show) async {
    AppConfig newState = state.copyWith(showPerformanceOverlay: show);
    cao.write(newState.toAppConfigPo());
    emit(newState);
  }

  // 切换code样式事件处理 : 固化索引 + 产出新状态
  void switchCoderTheme(int codeStyleIndex) async {
    AppConfig newState = state.copyWith(codeStyleIndex: codeStyleIndex);
    cao.write(newState.toAppConfigPo());
    emit(newState);
  }

  // 切换item样式事件处理 : 固化索引 + 产出新状态
  void changeItemStyle(int index) async {
    AppConfig newState = state.copyWith(itemStyleIndex: index);
    cao.write(newState.toAppConfigPo());
    emit(newState);
  }

  void changeThemeMode(ThemeMode style) async {
    AppConfig newState = state.copyWith(themeMode: style);
    cao.write(newState.toAppConfigPo());
    emit(newState);
  }

  void switchShowTool(bool show) async {
    AppConfig newState = state.copyWith(showOverlayTool: show);
    cao.write(newState.toAppConfigPo());
    emit(newState);
  }
}

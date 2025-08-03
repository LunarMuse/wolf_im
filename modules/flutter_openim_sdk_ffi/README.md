# flutter_openim_sdk_ffi

支持 windows、ios、android、macos、linux 对应 openim v3.8.3

## 警告！！

当前为测试版本可能面对不兼容修改
受包大小限制 macos 和 ios 只提供 arm64 所以只能跑真机

```
  当前可能存在个别方法无返回结果 欢迎提出issue 或者贡献代码
```

# init

```dart
  await OpenIMManager.init(
    apiAddr: 'https://web.muka.site/api',
    wsAddr: 'wss://web.muka.site/msg_gateway',
  );
```

# Listener

```dart
  class ImController extends GetxController with OpenIMListener {
   @override
  void onInit() {
    super.onInit();
    OpenIMManager.addListener(this);
  }

  @override
  void onClose() {
    OpenIMManager.removeListener(this);
    super.onClose();
  }

  @override
  void onConnecting() {
    utils.logger.w('onConnecting');
  }

  @override
  void onConnectSuccess() {
    utils.logger.w('onConnectSuccess');
  }

  @override
  void onConnectFailed(int code, String errorMsg) {
    utils.logger.w('onConnectFailed');
  }

  @override
  void onKickedOffline() {
    utils.logger.w('onKickedOffline');
  }

  @override
  void onUserTokenExpired() {
    utils.logger.w('onUserTokenExpired');
  }

  @override
  void onSyncServerStart(bool reinstalled) {
    utils.logger.w('onSyncServerFinish--$reinstalled');
  }

  @override
  void onSyncServerFailed(bool reinstalled) {
    utils.logger.w('onSyncServerFinish--$reinstalled');
  }

  @override
  void onSyncServerFinish(bool reinstalled) {
    utils.logger.w('onSyncServerFinish--$reinstalled');
  }

  @override
  void onSyncServerProgress(int progress) {
    utils.logger.w('onSyncServerProgress--$progress');
  }

  ...
}

```

# Other

```dart
  UserInfo userInfo = await OpenIM.iMManager.login(userID: userID, token: token);
```

to [OpenIMDoc](https://doc.rentsoft.cn/sdks/introduction)

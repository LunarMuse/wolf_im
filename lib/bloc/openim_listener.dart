import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_openim_sdk_ffi/flutter_openim_sdk_ffi.dart';

class ImController with OpenIMListener {
  Future<Response> postData(
    String path,
    Map<String, dynamic> headers,
    Map<String, dynamic> body,
  ) async {
    // 创建Dio实例
    final dio = Dio();

    try {
      // 配置请求头
      final options = Options(method: 'POST', headers: headers);

      // 发起POST请求
      final response = await dio.post(
        'http://127.0.0.1:10002/${path}', // 替换为实际的API地址
        data: body,
        options: options,
      );

      return response;

      // 处理成功响应
      print('请求成功，状态码: ${response.statusCode}');
      print('响应数据: ${response.data}');
    } catch (e) {
      // 处理错误
      print('请求失败: $e');
      // if (e is DioError) {
      //   // 详细错误信息
      //   print('错误类型: ${e.type}');
      //   print('错误信息: ${e.message}');
      //   if (e.response != null) {
      //     print('错误响应状态码: ${e.response?.statusCode}');
      //     print('错误响应数据: ${e.response?.data}');
      //   }
      // }
      throw Exception('请求发生未知错误: $e');
    }
  }

  void onInit() async {
    bool isSuccess = await OpenIMManager.init(
      apiAddr: "http://127.0.0.1:10002",
      wsAddr: "ws://127.0.0.1:10001",
    );
    debugPrint("ImController InitSDK isSuccess:${isSuccess}");
    debugPrint(
      "ImController InitSDK IMPlatform:${OpenIMManager.getIMPlatform()}",
    );

    OpenIMManager.addListener(this);

    final headers = {
      'Content-Type': 'application/json',
      'operationID': '1646445464564',
    };
    final body = {"secret": "openIM123", "userID": "imAdmin"};
    final path = "auth/get_admin_token";
    Response resp = await postData(path, headers, body);
    debugPrint("get_admin_token:${resp}");

    final responseData = resp.data as Map<String, dynamic>;
    final data = responseData['data'] as Map<String, dynamic>;

    final userHeaders = {
      'Content-Type': 'application/json',
      'operationID': '1646445464564',
      'token': data['token'] as String?,
    };

    final userBody = {"platformID": 7, "userID": "4639008761"};
    final userPath = "auth/get_user_token";
    Response useResp = await postData(userPath, userHeaders, userBody);
    debugPrint("get_user_token: header ${userHeaders} ${useResp}");

    final userResponseData = useResp.data as Map<String, dynamic>;
    final userData = userResponseData['data'] as Map<String, dynamic>;

    // await Future.delayed(Duration(seconds: 3));

    debugPrint(
      "ImController wait init:isLogined:${OpenIM.iMManager.isLogined};hasListeners:${OpenIMManager.hasListeners}\n\n\n",
    );

    UserInfo userInfo = await OpenIM.iMManager.login(
      userID: "4639008761",
      token: userData['token'] as String,
    );
    debugPrint("ImController OpenIM UserInfo:${userInfo.toJson()}");
  }

  void onClose() {
    debugPrint("ImController onClose");
    OpenIMManager.removeListener(this);
  }

  @override
  void onConnecting() {
    debugPrint("ImController OpenIM onConnecting");
  }

  @override
  void onConnectSuccess() async {
    debugPrint("OpenIM onConnectSuccess");
    String sdkVersion = await OpenIM.version();
    print("ImController OpenIM SDK Version: ${sdkVersion}");
  }

  @override
  void onConnectFailed(int code, String errorMsg) {
    debugPrint(
      "ImController OpenIM onConnectFailed; code:${code}; errMsg:${errorMsg}",
    );
  }

  @override
  void onUserTokenExpired() {
    // TODO: implement onUserTokenExpired
    print("ImController onUserTokenExpired");
  }

  @override
  void onUserTokenInvalid(String error) {
    // TODO: implement onUserTokenInvalid
    print("ImController onUserTokenInvalid");
  }
}

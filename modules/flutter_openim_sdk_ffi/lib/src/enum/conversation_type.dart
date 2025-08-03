part of '../../flutter_openim_sdk_ffi.dart';

/// 会话类型
enum ConversationType {
  single(1),
  group(2),
  superGroup(3),
  notification(4);

  final int rawValue;

  const ConversationType(this.rawValue);
}

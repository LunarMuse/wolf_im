import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'fx_emitter.dart';
import 'fx_event.dart';

// 1. FxEmitter 是一个全局单例的事件总线（类似 EventBus 库），内部维护一个 Stream<FxEvent>，支持：
//    发布事件：通过 FxEmitter().emit(event) 向全局发送 FxEvent 类型的事件；
//    订阅事件：通过 FxEmitter().stream 监听所有事件，或通过 FxEmitter().on<E>() 监听特定类型的事件。
mixin FxEmitterMixin<T extends StatefulWidget> on State<T> {
  StreamSubscription<FxEvent>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = FxEmitter().stream.listen(onEvent);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void onEvent(FxEvent event);
}

/// 只监听 [E] 类型的事件
/// 用于让 State 类只订阅特定类型 E 的事件（E 是 FxEvent 的子类），进一步简化单一事件类型的处理逻辑。
mixin FxSingleEventMixin<T extends StatefulWidget, E extends FxEvent>
    on State<T> {
  StreamSubscription<FxEvent>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = FxEmitter().on<E>(onEvent);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void onEvent(E event);
}

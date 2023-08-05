import 'dart:async';

import 'package:flutter/material.dart';

class StreamListener<T> extends StatefulWidget {
  const StreamListener({
    required this.stream,
    required this.listener,
    required this.child,
    super.key,
  });

  final Stream<T> stream;
  final void Function(BuildContext context, T data) listener;
  final Widget? child;

  @override
  State<StreamListener<T>> createState() => _StreamListenerState<T>();
}

class _StreamListenerState<T> extends State<StreamListener<T>> {
  late final StreamSubscription<T> _subscription;

  @override
  void initState() {
    _subscription = widget.stream.listen(_streamListener);
    super.initState();
  }

  void _streamListener(T data) => widget.listener(context, data);

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}

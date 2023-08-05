import 'dart:async';

mixin EventStreamMixin<T> {
  final StreamController<T> _controller = StreamController<T>.broadcast();

  Stream<T> get eventStream => _controller.stream;

  void addEvent(T event) {
    _controller.add(event);
  }

  Future<void> closeEventStream() {
    return _controller.close();
  }
}

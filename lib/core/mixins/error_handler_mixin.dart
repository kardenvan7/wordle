mixin ErrorHandlerMixin {
  bool get safeMode;

  void handleError(String message) {
    if (safeMode) return;
    throw Exception(message);
  }
}

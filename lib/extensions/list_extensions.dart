extension ListExtensions<T> on List<T> {
  List<T> withReplacedAt(int index, T newElement) {
    return [...this]
      ..removeAt(index)
      ..insert(index, newElement);
  }
}

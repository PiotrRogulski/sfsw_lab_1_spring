extension IterableX<T> on Iterable<T> {
  Iterable<T> intersperse(T value) {
    return expand((element) sync* {
      yield value;
      yield element;
    }).skip(1);
  }
}

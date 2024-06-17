extension ListExtension on List {
  List<E> xy2i<E>(int x, int y, int width) => this[x * width + y];
}

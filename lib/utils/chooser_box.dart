class ChooserBox<T> {
  final double width;
  final double height;
  final double x;
  final double y;
  final double angle;
  final T value;
  final String image;

  bool selected = false;

  ChooserBox({
    required this.value,
    required this.width,
    required this.height,
    required this.image,
    this.angle = 0,
    this.x = 0,
    this.y = 0,
  });
}

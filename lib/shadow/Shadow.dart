import 'dart:ui';

class Shadow {
  final double radius;
  final Offset offset;
  final Color color;
  final double alpha;
  final BlendMode blendMode;

  const Shadow({
    this.radius = 24.0,
    this.offset = const Offset(0.0, 4.0),
    this.color = const Color(0x1A000000),
    this.alpha = 1.0,
    this.blendMode = BlendMode.srcOver,
  });

  static const Shadow defaults = Shadow();
}

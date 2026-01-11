import 'dart:ui';

class InnerShadow {
  final double radius;
  final Offset offset;
  final Color color;
  final double alpha;
  final BlendMode blendMode;

  const InnerShadow({
    this.radius = 24.0,
    this.offset = const Offset(0.0, 24.0),
    this.color = const Color(0x26000000),
    this.alpha = 1.0,
    this.blendMode = BlendMode.srcOver,
  });

  static const InnerShadow defaults = InnerShadow();
  
  static InnerShadow lerp(InnerShadow start, InnerShadow stop, double t) {
     return InnerShadow(
        radius: lerpDouble(start.radius, stop.radius, t)!,
        offset: Offset.lerp(start.offset, stop.offset, t)!,
        color: Color.lerp(start.color, stop.color, t)!,
        alpha: lerpDouble(start.alpha, stop.alpha, t)!,
        blendMode: t < 0.5 ? start.blendMode : stop.blendMode,
     );
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'Shadow.dart';
import '../ShapeProvider.dart';

class ShadowModifier extends SingleChildRenderObjectWidget {
  final ShapeProvider shapeProvider;
  final Shadow? Function() shadow;

  const ShadowModifier({
    Key? key,
    required Widget child,
    required this.shapeProvider,
    required this.shadow,
  }) : super(key: key, child: child);

  @override
  RenderShadowModifier createRenderObject(BuildContext context) {
    return RenderShadowModifier(
      shapeProvider: shapeProvider,
      shadow: shadow,
      direction: Directionality.maybeOf(context) ?? TextDirection.ltr,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderShadowModifier renderObject) {
    renderObject
      ..shapeProvider = shapeProvider
      ..shadow = shadow
      ..direction = Directionality.maybeOf(context) ?? TextDirection.ltr;
  }
}

class RenderShadowModifier extends RenderProxyBox {
  ShapeProvider _shapeProvider;
  Shadow? Function() _shadow;
  TextDirection _direction;

  RenderShadowModifier({
    required ShapeProvider shapeProvider,
    required Shadow? Function() shadow,
    required TextDirection direction,
  })  : _shapeProvider = shapeProvider,
        _shadow = shadow,
        _direction = direction;

  set shapeProvider(ShapeProvider value) {
    _shapeProvider = value;
    markNeedsPaint();
  }

  set shadow(Shadow? Function() value) {
    _shadow = value;
    markNeedsPaint();
  }

  set direction(TextDirection value) {
    _direction = value;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final s = _shadow();
    if (s != null) {
      final canvas = context.canvas;
      final size = this.size;
      final rect = offset & size;
      final path = _shapeProvider.shape.getOuterPath(rect, textDirection: _direction);

      canvas.save();
      // Drop shadow should be behind content
      // Translate by offset
      canvas.translate(s.offset.dx, s.offset.dy);
      
      final paint = Paint()
        ..color = s.color.withValues(alpha: s.alpha)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, s.radius);
      
      canvas.drawPath(path, paint);
      
      // Mask out the content area if needed (matching Android's ShadowMaskPaint)
      canvas.translate(-s.offset.dx, -s.offset.dy);
      canvas.drawPath(path, Paint()..blendMode = BlendMode.clear);
      
      canvas.restore();
    }

    super.paint(context, offset);
  }
}

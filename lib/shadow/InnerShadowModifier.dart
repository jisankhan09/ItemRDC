import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'InnerShadow.dart';
import '../ShapeProvider.dart';

class InnerShadowModifier extends SingleChildRenderObjectWidget {
  final ShapeProvider shapeProvider;
  final InnerShadow? Function() shadow;

  const InnerShadowModifier({
    Key? key,
    required Widget child,
    required this.shapeProvider,
    required this.shadow,
  }) : super(key: key, child: child);

  @override
  RenderInnerShadowModifier createRenderObject(BuildContext context) {
    return RenderInnerShadowModifier(
      shapeProvider: shapeProvider,
      shadow: shadow,
      direction: Directionality.maybeOf(context) ?? TextDirection.ltr,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderInnerShadowModifier renderObject) {
    renderObject
      ..shapeProvider = shapeProvider
      ..shadow = shadow
      ..direction = Directionality.maybeOf(context) ?? TextDirection.ltr;
  }
}

class RenderInnerShadowModifier extends RenderProxyBox {
  ShapeProvider _shapeProvider;
  InnerShadow? Function() _shadow;
  TextDirection _direction;

  RenderInnerShadowModifier({
    required ShapeProvider shapeProvider,
    required InnerShadow? Function() shadow,
    required TextDirection direction,
  })  : _shapeProvider = shapeProvider,
        _shadow = shadow,
        _direction = direction;

  set shapeProvider(ShapeProvider value) {
    _shapeProvider = value;
    markNeedsPaint();
  }

  set shadow(InnerShadow? Function() value) {
    _shadow = value;
    markNeedsPaint();
  }

  set direction(TextDirection value) {
    _direction = value;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);

    final s = _shadow();
    if (s != null) {
      final canvas = context.canvas;
      final size = this.size;
      final rect = offset & size;
      final path = _shapeProvider.shape.getOuterPath(rect, textDirection: _direction);

      canvas.save();
      canvas.clipPath(path);

      final layerPaint = Paint()
        ..colorFilter = ColorFilter.mode(s.color.withValues(alpha: s.alpha), BlendMode.srcIn)
        ..imageFilter = ImageFilter.blur(sigmaX: s.radius, sigmaY: s.radius, tileMode: TileMode.decal);

      context.canvas.saveLayer(rect, layerPaint);
      
      canvas.drawPath(path, Paint()..color = s.color);
      canvas.translate(s.offset.dx, s.offset.dy);
      canvas.drawPath(path, Paint()..blendMode = BlendMode.clear);
      
      context.canvas.restore();
      canvas.restore();
    }
  }
}

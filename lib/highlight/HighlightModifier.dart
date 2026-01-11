import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'Highlight.dart';
import '../ShapeProvider.dart';
import '../BackdropEffectScope.dart';

class HighlightModifier extends SingleChildRenderObjectWidget {
  final ShapeProvider shapeProvider;
  final Highlight? Function() highlight;

  const HighlightModifier({
    Key? key,
    required Widget child,
    required this.shapeProvider,
    required this.highlight,
  }) : super(key: key, child: child);

  @override
  RenderHighlightModifier createRenderObject(BuildContext context) {
    return RenderHighlightModifier(
      shapeProvider: shapeProvider,
      highlight: highlight,
      density: MediaQuery.maybeOf(context)?.devicePixelRatio ?? 1.0,
      direction: Directionality.maybeOf(context) ?? TextDirection.ltr,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderHighlightModifier renderObject) {
    renderObject
      ..shapeProvider = shapeProvider
      ..highlight = highlight
      ..density = MediaQuery.maybeOf(context)?.devicePixelRatio ?? 1.0
      ..direction = Directionality.maybeOf(context) ?? TextDirection.ltr;
  }
}

class RenderHighlightModifier extends RenderProxyBox {
  ShapeProvider _shapeProvider;
  Highlight? Function() _highlight;
  double _density;
  TextDirection _direction;

  final BackdropEffectScopeImpl _effectScope = BackdropEffectScopeImpl();

  RenderHighlightModifier({
    required ShapeProvider shapeProvider,
    required Highlight? Function() highlight,
    required double density,
    required TextDirection direction,
  })  : _shapeProvider = shapeProvider,
        _highlight = highlight,
        _density = density,
        _direction = direction {
    _effectScope.onShaderLoaded = markNeedsPaint;
  }

  set shapeProvider(ShapeProvider value) {
    _shapeProvider = value;
    markNeedsPaint();
  }

  set highlight(Highlight? Function() value) {
    _highlight = value;
    markNeedsPaint();
  }

  set density(double value) {
    _density = value;
    markNeedsPaint();
  }

  set direction(TextDirection value) {
    _direction = value;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);

    final h = _highlight();
    if (h == null || h.width <= 0) return;

    final canvas = context.canvas;
    final size = this.size;
    final rect = offset & size;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = h.style.color.withValues(alpha: h.alpha)
      ..strokeWidth = (h.width * _density).clamp(0.0, size.shortestSide / 2.0) * 2.0;

    if (h.blurRadius > 0) {
      paint.maskFilter = MaskFilter.blur(BlurStyle.normal, h.blurRadius * _density);
    }

    final path = _shapeProvider.shape.getOuterPath(rect, textDirection: _direction);

    canvas.save();
    canvas.clipPath(path);
    
    // Attempt to use shader from style
    _effectScope.update(_density, 1.0, size, _direction);
    _effectScope.shape = _shapeProvider.shape;
    
    final shader = h.style.createShader(
      size,
      _shapeProvider.shape,
      _direction,
      _density,
      _effectScope,
      _effectScope.onShaderAvailable,
    );
    if (shader != null) {
      paint.shader = shader;
    }
    
    canvas.drawPath(path, paint);
    canvas.restore();
  }
}

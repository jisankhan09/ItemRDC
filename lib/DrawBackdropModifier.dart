import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'Backdrop.dart';
import 'BackdropEffectScope.dart';
import 'ShapeProvider.dart';
import 'highlight/Highlight.dart';
import 'highlight/HighlightModifier.dart';
import 'shadow/Shadow.dart';
import 'shadow/ShadowModifier.dart';
import 'shadow/InnerShadow.dart';
import 'shadow/InnerShadowModifier.dart';
import 'backdrops/LayerBackdrop.dart';
import 'InverseLayerScope.dart';
import 'LayerRecorder.dart';

class DrawBackdrop extends StatelessWidget {
  final Widget child;
  final Backdrop backdrop;
  final ShapeBorder Function() shape;
  final void Function(BackdropEffectScope) effects;
  final Highlight? Function()? highlight;
  final Shadow? Function()? shadow;
  final InnerShadow? Function()? innerShadow;
  final void Function(InverseLayerScope)? layerBlock;
  final LayerBackdrop? exportedBackdrop;
  final void Function(Canvas, Size)? onDrawBehind;
  final void Function(Canvas, Size, void Function(Canvas))? onDrawBackdrop;
  final void Function(Canvas, Size)? onDrawSurface;
  final void Function(Canvas, Size)? onDrawFront;

  const DrawBackdrop({
    Key? key,
    required this.child,
    required this.backdrop,
    required this.shape,
    required this.effects,
    this.highlight,
    this.shadow,
    this.innerShadow,
    this.layerBlock,
    this.exportedBackdrop,
    this.onDrawBehind,
    this.onDrawBackdrop,
    this.onDrawSurface,
    this.onDrawFront,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget result = DrawBackdropInternal(
      backdrop: backdrop,
      shape: shape,
      effects: effects,
      layerBlock: layerBlock,
      exportedBackdrop: exportedBackdrop,
      onDrawBehind: onDrawBehind,
      onDrawBackdrop: onDrawBackdrop,
      onDrawSurface: onDrawSurface,
      onDrawFront: onDrawFront,
      child: child,
    );

    final innerShadowVal = innerShadow?.call();
    if (innerShadowVal != null) {
      result = InnerShadowModifier(
        shapeProvider: ShapeProvider(shape),
        shadow: innerShadow!,
        child: result,
      );
    }

    final shadowVal = shadow?.call();
    if (shadowVal != null) {
      result = ShadowModifier(
        shapeProvider: ShapeProvider(shape),
        shadow: shadow!,
        child: result,
      );
    }

    final highlightVal = highlight?.call();
    if (highlightVal != null) {
      result = HighlightModifier(
        shapeProvider: ShapeProvider(shape),
        highlight: highlight!,
        child: result,
      );
    }

    return result;
  }
}

class DrawBackdropInternal extends SingleChildRenderObjectWidget {
  final Backdrop backdrop;
  final ShapeBorder Function() shape;
  final void Function(BackdropEffectScope) effects;
  final void Function(InverseLayerScope)? layerBlock;
  final LayerBackdrop? exportedBackdrop;
  final void Function(Canvas, Size)? onDrawBehind;
  final void Function(Canvas, Size, void Function(Canvas))? onDrawBackdrop;
  final void Function(Canvas, Size)? onDrawSurface;
  final void Function(Canvas, Size)? onDrawFront;

  const DrawBackdropInternal({
    Key? key,
    required Widget child,
    required this.backdrop,
    required this.shape,
    required this.effects,
    this.layerBlock,
    this.exportedBackdrop,
    this.onDrawBehind,
    this.onDrawBackdrop,
    this.onDrawSurface,
    this.onDrawFront,
  }) : super(key: key, child: child);

  @override
  RenderDrawBackdrop createRenderObject(BuildContext context) {
    return RenderDrawBackdrop(
      backdrop: backdrop,
      shape: shape,
      effects: effects,
      layerBlock: layerBlock,
      exportedBackdrop: exportedBackdrop,
      onDrawBehind: onDrawBehind,
      onDrawBackdrop: onDrawBackdrop,
      onDrawSurface: onDrawSurface,
      onDrawFront: onDrawFront,
      density: MediaQuery.maybeOf(context)?.devicePixelRatio ?? 1.0,
      fontScale: MediaQuery.maybeOf(context)?.textScaler.scale(1.0) ?? 1.0,
      direction: Directionality.maybeOf(context) ?? TextDirection.ltr,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderDrawBackdrop renderObject) {
    renderObject
      ..backdrop = backdrop
      ..shapeBlock = shape
      ..effects = effects
      ..layerBlock = layerBlock
      ..exportedBackdrop = exportedBackdrop
      ..onDrawBehind = onDrawBehind
      ..onDrawBackdrop = onDrawBackdrop
      ..onDrawSurface = onDrawSurface
      ..onDrawFront = onDrawFront
      ..density = MediaQuery.maybeOf(context)?.devicePixelRatio ?? 1.0
      ..fontScale = MediaQuery.maybeOf(context)?.textScaler.scale(1.0) ?? 1.0
      ..direction = Directionality.maybeOf(context) ?? TextDirection.ltr;
  }
}

class RenderDrawBackdrop extends RenderProxyBox {
  Backdrop _backdrop;
  ShapeBorder Function() _shapeBlock;
  void Function(BackdropEffectScope) _effects;
  void Function(InverseLayerScope)? _layerBlock;
  LayerBackdrop? _exportedBackdrop;
  void Function(Canvas, Size)? _onDrawBehind;
  void Function(Canvas, Size, void Function(Canvas))? _onDrawBackdrop;
  void Function(Canvas, Size)? _onDrawSurface;
  void Function(Canvas, Size)? _onDrawFront;
  double _density;
  double _fontScale;
  TextDirection _direction;

  final BackdropEffectScopeImpl _effectScope = BackdropEffectScopeImpl();
  late ShapeProvider _shapeProvider;

  RenderDrawBackdrop({
    required Backdrop backdrop,
    required ShapeBorder Function() shape,
    required void Function(BackdropEffectScope) effects,
    void Function(InverseLayerScope)? layerBlock,
    LayerBackdrop? exportedBackdrop,
    void Function(Canvas, Size)? onDrawBehind,
    void Function(Canvas, Size, void Function(Canvas))? onDrawBackdrop,
    void Function(Canvas, Size)? onDrawSurface,
    void Function(Canvas, Size)? onDrawFront,
    required double density,
    required double fontScale,
    required TextDirection direction,
  })  : _backdrop = backdrop,
        _shapeBlock = shape,
        _effects = effects,
        _layerBlock = layerBlock,
        _exportedBackdrop = exportedBackdrop,
        _onDrawBehind = onDrawBehind,
        _onDrawBackdrop = onDrawBackdrop,
        _onDrawSurface = onDrawSurface,
        _onDrawFront = onDrawFront,
        _density = density,
        _fontScale = fontScale,
        _direction = direction {
    _shapeProvider = ShapeProvider(_shapeBlock);
  }

  // Setters
  set backdrop(Backdrop value) {
    if (_backdrop != value) {
      _backdrop = value;
      markNeedsPaint();
    }
  }
  
  set shapeBlock(ShapeBorder Function() value) {
     // Check if same function? Hard. Assuming changed.
     _shapeBlock = value;
     _shapeProvider = ShapeProvider(_shapeBlock);
     markNeedsPaint();
  }

  set effects(void Function(BackdropEffectScope) value) {
    _effects = value;
    markNeedsPaint();
  }
  
  set layerBlock(void Function(InverseLayerScope)? value) { _layerBlock = value; markNeedsPaint(); }
  set exportedBackdrop(LayerBackdrop? value) { _exportedBackdrop = value; markNeedsPaint(); }
  set onDrawBehind(void Function(Canvas, Size)? value) { _onDrawBehind = value; markNeedsPaint(); }
  set onDrawBackdrop(void Function(Canvas, Size, void Function(Canvas))? value) { _onDrawBackdrop = value; markNeedsPaint(); }
  set onDrawSurface(void Function(Canvas, Size)? value) { _onDrawSurface = value; markNeedsPaint(); }
  set onDrawFront(void Function(Canvas, Size)? value) { _onDrawFront = value; markNeedsPaint(); }
  set density(double value) { _density = value; markNeedsPaint(); }
  set fontScale(double value) { _fontScale = value; markNeedsPaint(); }
  set direction(TextDirection value) { _direction = value; markNeedsPaint(); }

  @override
  void performLayout() {
    super.performLayout();
    if (_exportedBackdrop != null) {
      _exportedBackdrop!.layerCoordinates = this;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    final size = this.size;
    
    // Update effect scope
    _effectScope.update(_density, _fontScale, size, _direction);
    _effectScope.shape = _shapeProvider.shape;
    _effectScope.apply(_effects);
    
    final padding = _effectScope.padding;
    final renderEffect = _effectScope.renderEffect;

    // Drawing
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    
    // 1. Draw Behind
    _onDrawBehind?.call(canvas, size);

    // 2. Draw Backdrop
    // Setup layer for backdrop if needed (padding, effects)
    
    // Note: RenderEffect in Android applies to the drawing commands in the layer.
    // In Flutter, we can use saveLayer with ImageFilter.
    
    if (renderEffect != null) {
      final rect = Rect.fromLTWH(
          -padding, -padding, size.width + padding * 2, size.height + padding * 2);
      canvas.saveLayer(rect, Paint()
        ..imageFilter = renderEffect);
    }
    
    if (padding != 0) {
      canvas.translate(padding, padding);
    }
    
    final drawBackdropBlock = (Canvas c) {
       _backdrop.drawBackdrop(
         c, 
         size, 
         density: _density,
         coordinates: _backdrop.isCoordinatesDependent ? this : null,
         layerBlock: _layerBlock
       );
    };

    if (_onDrawBackdrop != null) {
       _onDrawBackdrop!(canvas, size, drawBackdropBlock);
    } else {
       drawBackdropBlock(canvas);
    }

    if (padding != 0) {
      canvas.translate(-padding, -padding);
    }

    if (renderEffect != null) {
      canvas.restore();
    }
    
    // 4. Draw Surface (Child?)
    _onDrawSurface?.call(canvas, size);
    
    // Draw child
    super.paint(context, Offset.zero); // Child is already offset by paint method wrapper but we translated.
    // Wait, super.paint expects offset.
    // We translated context.canvas.
    // So we should pass Offset.zero?
    // Yes.
    
    // 5. Draw Front
    _onDrawFront?.call(canvas, size);
    
    canvas.restore();

    if (_exportedBackdrop != null) {
      _exportedBackdrop!.picture = recordLayer(size, (c) {
        _onDrawBehind?.call(c, size);

        if (renderEffect != null) {
          final rect = Rect.fromLTWH(
              -padding, -padding, size.width + padding * 2, size.height + padding * 2);
          c.saveLayer(rect, Paint()..imageFilter = renderEffect);
        }

        if (padding != 0) {
          c.translate(padding, padding);
        }

        final drawBackdropBlock = (Canvas cb) {
          _backdrop.drawBackdrop(
              cb,
              size,
              density: _density,
              coordinates: _backdrop.isCoordinatesDependent ? this : null,
              layerBlock: _layerBlock
          );
        };

        if (_onDrawBackdrop != null) {
          _onDrawBackdrop!(c, size, drawBackdropBlock);
        } else {
          drawBackdropBlock(c);
        }

        if (padding != 0) {
          c.translate(-padding, -padding);
        }

        if (renderEffect != null) {
          c.restore();
        }

        _onDrawSurface?.call(c, size);
        _onDrawFront?.call(c, size);
      });
    }
  }
}

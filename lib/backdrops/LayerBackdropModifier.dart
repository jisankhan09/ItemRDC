import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'LayerBackdrop.dart';

class LayerBackdropModifier extends SingleChildRenderObjectWidget {
  final LayerBackdrop backdrop;
  final void Function(Canvas, Size, void Function())? onDraw;

  const LayerBackdropModifier({
    Key? key,
    required Widget child,
    required this.backdrop,
    this.onDraw,
  }) : super(key: key, child: child);

  @override
  RenderLayerBackdropModifier createRenderObject(BuildContext context) {
    return RenderLayerBackdropModifier(backdrop: backdrop, onDraw: onDraw);
  }

  @override
  void updateRenderObject(BuildContext context, RenderLayerBackdropModifier renderObject) {
    renderObject
      ..backdrop = backdrop
      ..onDraw = onDraw;
  }
}

class RenderLayerBackdropModifier extends RenderProxyBox {
  LayerBackdrop _backdrop;
  void Function(Canvas, Size, void Function())? _onDraw;

  RenderLayerBackdropModifier({
    required LayerBackdrop backdrop,
    void Function(Canvas, Size, void Function())? onDraw,
  })  : _backdrop = backdrop,
        _onDraw = onDraw;

  set backdrop(LayerBackdrop value) {
    if (_backdrop != value) {
      _backdrop = value;
      markNeedsPaint();
    }
  }

  set onDraw(void Function(Canvas, Size, void Function())? value) {
    _onDraw = value;
    markNeedsPaint();
  }

  @override
  void performLayout() {
    super.performLayout();
    _backdrop.layerCoordinates = this;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final layer = OffsetLayer();
    context.pushLayer(layer, (context, offset) {
      if (_onDraw != null) {
        _onDraw!(context.canvas, size, () {
          super.paint(context, offset);
        });
      } else {
        super.paint(context, offset);
      }
    }, offset);

    // Try to find the picture layer in the newly created layer tree
    Layer? childLayer = layer.firstChild;
    while (childLayer != null) {
      if (childLayer is PictureLayer) {
        _backdrop.picture = childLayer.picture;
        break;
      }
      childLayer = childLayer.nextSibling;
    }
  }
}
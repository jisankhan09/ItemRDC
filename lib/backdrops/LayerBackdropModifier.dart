import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'LayerBackdrop.dart';

class LayerBackdropModifier extends SingleChildRenderObjectWidget {
  final LayerBackdrop backdrop;

  const LayerBackdropModifier({
    Key? key,
    required Widget child,
    required this.backdrop,
  }) : super(key: key, child: child);

  @override
  RenderLayerBackdropModifier createRenderObject(BuildContext context) {
    return RenderLayerBackdropModifier(backdrop: backdrop);
  }

  @override
  void updateRenderObject(BuildContext context, RenderLayerBackdropModifier renderObject) {
    renderObject.backdrop = backdrop;
  }
}

class RenderLayerBackdropModifier extends RenderProxyBox {
  LayerBackdrop _backdrop;

  RenderLayerBackdropModifier({
    required LayerBackdrop backdrop,
  }) : _backdrop = backdrop;

  @override
  bool get isRepaintBoundary => true;

  set backdrop(LayerBackdrop value) {
    if (_backdrop != value) {
      _backdrop = value;
      markNeedsPaint();
    }
  }

  @override
  void performLayout() {
    super.performLayout();
    _backdrop.layerCoordinates = this;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    
    // After painting, we can try to extract the picture from our layer
    final layer = this.layer as OffsetLayer?;
    if (layer != null) {
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
}
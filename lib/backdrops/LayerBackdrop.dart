import 'dart:ui';
import 'package:flutter/rendering.dart';
import '../Backdrop.dart';
import '../InverseLayerScope.dart';

class LayerBackdrop implements Backdrop {
  Picture? picture;
  RenderBox? layerCoordinates;

  LayerBackdrop({this.picture});

  @override
  bool get isCoordinatesDependent => true;

  final InverseLayerScope _inverseLayerScope = InverseLayerScope();

  @override
  void drawBackdrop(
    Canvas canvas,
    Size size, {
    required double density,
    RenderBox? coordinates,
    void Function(InverseLayerScope)? layerBlock,
  }) {
    if (coordinates == null || layerCoordinates == null || picture == null) return;

    Offset offset = Offset.zero;
    try {
       if (coordinates.attached && layerCoordinates!.attached) {
         final globalDest = coordinates.localToGlobal(Offset.zero);
         offset = layerCoordinates!.globalToLocal(globalDest);
       } else {
         return;
       }
    } catch (e) {
       return;
    }

    canvas.save();
    if (layerBlock != null) {
      _inverseLayerScope.inverseTransform(canvas, layerBlock);
    }

    canvas.translate(-offset.dx, -offset.dy);
    canvas.drawPicture(picture!);
    canvas.restore();
  }
}

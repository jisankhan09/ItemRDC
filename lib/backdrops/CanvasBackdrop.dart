import 'package:flutter/rendering.dart';
import '../Backdrop.dart';
import '../InverseLayerScope.dart';

class CanvasBackdrop implements Backdrop {
  final void Function(Canvas, Size) onDraw;

  CanvasBackdrop(this.onDraw);

  @override
  bool get isCoordinatesDependent => false;

  @override
  void drawBackdrop(
    Canvas canvas,
    Size size, {
    required double density,
    RenderBox? coordinates,
    void Function(InverseLayerScope)? layerBlock,
  }) {
    onDraw(canvas, size);
  }
}

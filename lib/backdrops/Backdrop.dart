import 'package:flutter/rendering.dart';
import '../Backdrop.dart';
import '../InverseLayerScope.dart';

class CustomBackdrop implements Backdrop {
  final Backdrop backdrop;
  final void Function(Canvas, Size, void Function(Canvas)) onDraw;

  CustomBackdrop({required this.backdrop, required this.onDraw});

  @override
  bool get isCoordinatesDependent => backdrop.isCoordinatesDependent;

  @override
  void drawBackdrop(
    Canvas canvas,
    Size size, {
    required double density,
    RenderBox? coordinates,
    void Function(InverseLayerScope)? layerBlock,
  }) {
    onDraw(canvas, size, (c) {
      backdrop.drawBackdrop(
        c,
        size,
        density: density,
        coordinates: coordinates,
        layerBlock: layerBlock,
      );
    });
  }
}

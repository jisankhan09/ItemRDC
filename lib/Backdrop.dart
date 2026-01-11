import 'package:flutter/rendering.dart';
import 'InverseLayerScope.dart';

abstract class Backdrop {
  bool get isCoordinatesDependent;

  void drawBackdrop(
    Canvas canvas,
    Size size, {
    required double density,
    RenderBox? coordinates,
    void Function(InverseLayerScope)? layerBlock,
  });
}
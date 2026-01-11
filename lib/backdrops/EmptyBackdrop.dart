import 'package:flutter/rendering.dart';
import '../Backdrop.dart';
import '../InverseLayerScope.dart';

class EmptyBackdrop implements Backdrop {
  const EmptyBackdrop();

  @override
  bool get isCoordinatesDependent => false;

  @override
  void drawBackdrop(
    Canvas canvas,
    Size size, {
    required double density,
    RenderBox? coordinates,
    void Function(InverseLayerScope)? layerBlock,
  }) {}
}

const emptyBackdrop = EmptyBackdrop();

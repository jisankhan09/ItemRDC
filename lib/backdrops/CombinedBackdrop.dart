import 'package:flutter/rendering.dart';
import '../Backdrop.dart';
import '../InverseLayerScope.dart';

class CombinedBackdrop implements Backdrop {
  final List<Backdrop> backdrops;

  CombinedBackdrop(this.backdrops);

  @override
  bool get isCoordinatesDependent =>
      backdrops.any((b) => b.isCoordinatesDependent);

  @override
  void drawBackdrop(
    Canvas canvas,
    Size size, {
    required double density,
    RenderBox? coordinates,
    void Function(InverseLayerScope)? layerBlock,
  }) {
    for (var backdrop in backdrops) {
      backdrop.drawBackdrop(
        canvas,
        size,
        density: density,
        coordinates: coordinates,
        layerBlock: layerBlock,
      );
    }
  }
}

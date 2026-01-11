import 'package:flutter/painting.dart';

class ShapeProvider {
  final ShapeBorder Function() shapeBlock;

  ShapeProvider(this.shapeBlock);

  ShapeBorder get innerShape => shapeBlock();

  ShapeBorder get shape => innerShape;

  Path getPath(Rect rect, TextDirection direction) {
    return shape.getOuterPath(rect, textDirection: direction);
  }
}

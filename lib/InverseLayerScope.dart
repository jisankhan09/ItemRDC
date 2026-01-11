import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

class InverseLayerScope {
  Size size = Size.zero;
  double density = 1.0;
  double fontScale = 1.0;

  double scaleX = 1.0;
  double scaleY = 1.0;
  double alpha = 1.0;
  double translationX = 0.0;
  double translationY = 0.0;
  double shadowElevation = 0.0;
  Color ambientShadowColor = const Color(0xFF000000);
  Color spotShadowColor = const Color(0xFF000000);
  double rotationX = 0.0;
  double rotationY = 0.0;
  double rotationZ = 0.0;
  double cameraDistance = 8.0;
  // transformOrigin is omitted for now as it maps to specific layer properties
  ShapeBorder shape = const RoundedRectangleBorder();
  bool clip = false;
  ImageFilter? renderEffect;
  BlendMode blendMode = BlendMode.srcOver;
  ColorFilter? colorFilter;
  
  void inverseTransform(Canvas canvas, void Function(InverseLayerScope) layerBlock) {
    // Reset defaults
    scaleX = 1.0;
    scaleY = 1.0;
    rotationZ = 0.0;
    
    layerBlock(this);
    
    if (rotationZ == 0.0) {
      if (scaleX != 0.0 && scaleY != 0.0) {
        canvas.scale(1.0 / scaleX, 1.0 / scaleY);
      }
      return;
    }

    final m = Matrix4.identity();
    m.rotateZ(rotationZ * math.pi / 180.0);
    m.scaleByDouble(scaleX, scaleY, 1.0, 1.0);
    
    final inv = Matrix4.zero();
    if (inv.copyInverse(m) != 0.0) {
       canvas.transform(inv.storage);
    }
  }
}
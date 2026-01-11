import 'dart:ui';
import '../BackdropEffectScope.dart';
import 'RenderEffect.dart';

extension BlurExtension on BackdropEffectScope {
  void blur({double radius = 0.0, TileMode edgeTreatment = TileMode.clamp}) {
    if (radius <= 0) return;
    
    if (radius > padding) {
       padding = radius;
    }
    
    effect(ImageFilter.blur(sigmaX: radius, sigmaY: radius, tileMode: edgeTreatment));
  }
}

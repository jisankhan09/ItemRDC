import 'dart:ui';
import '../BackdropEffectScope.dart';

extension RenderEffectExtensions on BackdropEffectScope {
  void effect(ImageFilter newEffect) {
    final current = renderEffect;
    if (current != null) {
      renderEffect = ImageFilter.compose(outer: newEffect, inner: current);
    } else {
      renderEffect = newEffect;
    }
  }
}

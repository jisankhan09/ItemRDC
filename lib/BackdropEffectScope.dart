import 'dart:ui';
import 'package:flutter/painting.dart';
import 'RuntimeShaderCache.dart';

abstract class BackdropEffectScope implements RuntimeShaderCache {
  Size get size;
  TextDirection get layoutDirection;
  ShapeBorder get shape;
  
  double get padding;
  set padding(double value);

  ImageFilter? get renderEffect;
  set renderEffect(ImageFilter? value);

  double get density;
  double get fontScale;
}

class BackdropEffectScopeImpl extends RuntimeShaderCacheImpl implements BackdropEffectScope {
  @override
  double density = 1.0;
  @override
  double fontScale = 1.0;
  @override
  Size size = Size.zero;
  @override
  TextDirection layoutDirection = TextDirection.ltr;
  
  @override
  double padding = 0.0;
  @override
  ImageFilter? renderEffect;

  ShapeBorder? _shape;
  @override
  ShapeBorder get shape => _shape ?? const RoundedRectangleBorder();
  set shape(ShapeBorder s) => _shape = s;

  bool update(
    double newDensity,
    double newFontScale,
    Size newSize,
    TextDirection newLayoutDirection,
  ) {
    final changed = density != newDensity ||
        fontScale != newFontScale ||
        size != newSize ||
        layoutDirection != newLayoutDirection;

    if (changed) {
      density = newDensity;
      fontScale = newFontScale;
      size = newSize;
      layoutDirection = newLayoutDirection;
    }
    return changed;
  }

  void apply(void Function(BackdropEffectScope) effects) {
    padding = 0.0;
    renderEffect = null;
    effects(this);
  }
  
  void reset() {
     density = 1.0;
     fontScale = 1.0;
     size = Size.zero;
     layoutDirection = TextDirection.ltr;
     padding = 0.0;
     renderEffect = null;
     clear();
  }
}
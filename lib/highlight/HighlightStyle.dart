import 'dart:ui';
import 'package:flutter/painting.dart';
import '../Shaders.dart';
import '../RuntimeShaderCache.dart';
import 'dart:math' as math;

abstract class HighlightStyle {
  Color get color;
  BlendMode get blendMode;

  FragmentShader? createShader(
    Size size,
    ShapeBorder shape,
    TextDirection layoutDirection,
    double density,
    RuntimeShaderCache runtimeShaderCache,
    void Function() onShaderLoaded,
  );
}

class HighlightStylePlain implements HighlightStyle {
  @override
  final Color color;
  @override
  final BlendMode blendMode;

  const HighlightStylePlain({
    this.color = const Color(0x61FFFFFF),
    this.blendMode = BlendMode.plus,
  });

  @override
  FragmentShader? createShader(
    Size size,
    ShapeBorder shape,
    TextDirection layoutDirection,
    double density,
    RuntimeShaderCache runtimeShaderCache,
    void Function() onShaderLoaded,
  ) => null;
}

class HighlightStyleDefault implements HighlightStyle {
  @override
  final Color color;
  @override
  final BlendMode blendMode;
  final double angle;
  final double falloff;

  const HighlightStyleDefault({
    this.color = const Color(0x80FFFFFF),
    this.blendMode = BlendMode.plus,
    this.angle = 45.0,
    this.falloff = 1.0,
  });

  @override
  FragmentShader? createShader(
    Size size,
    ShapeBorder shape,
    TextDirection layoutDirection,
    double density,
    RuntimeShaderCache runtimeShaderCache,
    void Function() onShaderLoaded,
  ) {
    final program = runtimeShaderCache.getCachedShader(Shaders.defaultHighlight);
    if (program == null) {
      runtimeShaderCache.requestShader(Shaders.defaultHighlight, onShaderLoaded);
      return null;
    }
    final shader = program.fragmentShader();
    
    final radii = getCornerRadii(shape, size, layoutDirection);
    
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, radii[0]);
    shader.setFloat(3, radii[1]);
    shader.setFloat(4, radii[2]);
    shader.setFloat(5, radii[3]);
    shader.setFloat(6, color.r);
    shader.setFloat(7, color.g);
    shader.setFloat(8, color.b);
    shader.setFloat(9, color.a);
    shader.setFloat(10, angle * (math.pi / 180.0));
    shader.setFloat(11, falloff);

    return shader;
  }
}

class HighlightStyleAmbient implements HighlightStyle {
  final double intensity;
  @override
  final Color color;
  @override
  final BlendMode blendMode;

  HighlightStyleAmbient({this.intensity = 0.38})
      : color = Color.fromARGB((255 * intensity).round(), 255, 255, 255),
        blendMode = BlendMode.srcOver;

  @override
  FragmentShader? createShader(
    Size size,
    ShapeBorder shape,
    TextDirection layoutDirection,
    double density,
    RuntimeShaderCache runtimeShaderCache,
    void Function() onShaderLoaded,
  ) {
    final program = runtimeShaderCache.getCachedShader(Shaders.ambientHighlight);
    if (program == null) {
      runtimeShaderCache.requestShader(Shaders.ambientHighlight, onShaderLoaded);
      return null;
    }
    final shader = program.fragmentShader();

    final radii = getCornerRadii(shape, size, layoutDirection);

    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, radii[0]);
    shader.setFloat(3, radii[1]);
    shader.setFloat(4, radii[2]);
    shader.setFloat(5, radii[3]);
    shader.setFloat(6, 45.0 * (math.pi / 180.0));
    shader.setFloat(7, 1.0);

    return shader;
  }
}

List<double> getCornerRadii(ShapeBorder shape, Size size, TextDirection layoutDirection) {
  double tl = 0, tr = 0, br = 0, bl = 0;
  final maxRadius = math.min(size.width, size.height) / 2.0;

  if (shape is RoundedRectangleBorder) {
    final r = shape.borderRadius.resolve(layoutDirection);
    tl = r.topLeft.x.clamp(0.0, maxRadius);
    tr = r.topRight.x.clamp(0.0, maxRadius);
    br = r.bottomRight.x.clamp(0.0, maxRadius);
    bl = r.bottomLeft.x.clamp(0.0, maxRadius);
  } else if (shape is CircleBorder) {
    tl = tr = br = bl = maxRadius;
  } else if (shape is StadiumBorder) {
    tl = tr = br = bl = maxRadius;
  }

  return [tl, tr, br, bl];
}
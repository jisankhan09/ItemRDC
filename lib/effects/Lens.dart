import 'dart:ui';
import '../BackdropEffectScope.dart';
import '../Shaders.dart';
import 'RenderEffect.dart';
import '../highlight/HighlightStyle.dart';

extension LensExtension on BackdropEffectScope {
  Future<void> lens({
    required double refractionHeight,
    required double refractionAmount,
    bool depthEffect = false,
    bool chromaticAberration = false,
  }) async {
    if (refractionHeight <= 0 || refractionAmount <= 0) return;

    if (padding > 0) {
      padding = (padding - refractionHeight).clamp(0.0, double.infinity);
    }

    final radii = getCornerRadii(shape, size, layoutDirection);

    final key = chromaticAberration 
       ? Shaders.roundedRectRefractionWithDispersion 
       : Shaders.roundedRectRefraction;

    final program = await obtainRuntimeShader(key);
    final shader = program.fragmentShader();
    
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, -padding);
    shader.setFloat(3, -padding);
    shader.setFloat(4, radii[0]);
    shader.setFloat(5, radii[1]);
    shader.setFloat(6, radii[2]);
    shader.setFloat(7, radii[3]);
    shader.setFloat(8, refractionHeight);
    shader.setFloat(9, -refractionAmount);
    shader.setFloat(10, depthEffect ? 1.0 : 0.0);
    
    if (chromaticAberration) {
       shader.setFloat(11, 1.0);
    }
    
    effect(ImageFilter.shader(shader));
  }
}

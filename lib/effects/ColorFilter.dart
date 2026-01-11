import 'dart:ui' as ui;
import 'dart:math' as math;
import '../BackdropEffectScope.dart';
import '../Shaders.dart';
import 'RenderEffect.dart';

extension ColorFilterExtension on BackdropEffectScope {
  void colorFilter(ui.ColorFilter filter) {
    effect((ui.ImageFilter as dynamic).colorFilter(filter));
  }

  void opacity(double alpha) {
    colorFilter(ui.ColorFilter.matrix([
      1, 0, 0, 0, 0,
      0, 1, 0, 0, 0,
      0, 0, 1, 0, 0,
      0, 0, 0, alpha, 0,
    ]));
  }

  void colorControls({
    double brightness = 0.0,
    double contrast = 1.0,
    double saturation = 1.0,
  }) {
    if (brightness == 0.0 && contrast == 1.0 && saturation == 1.0) {
      return;
    }
    colorFilter(_colorControlsColorFilter(brightness, contrast, saturation));
  }

  void vibrancy() {
    colorControls(saturation: 1.5);
  }

  void exposureAdjustment(double ev) {
    final scale = math.pow(2.0, ev / 2.2);
    colorFilter(ui.ColorFilter.matrix([
      scale.toDouble(), 0, 0, 0, 0,
      0, scale.toDouble(), 0, 0, 0,
      0, 0, scale.toDouble(), 0, 0,
      0, 0, 0, 1, 0,
    ]));
  }

  Future<void> gammaAdjustment(double power) async {
    final program = await obtainRuntimeShader(Shaders.gammaAdjustment);
    final shader = program.fragmentShader();
    shader.setFloat(0, power);
    shader.setFloat(1, size.width);
    shader.setFloat(2, size.height);

    effect(ui.ImageFilter.shader(shader));
  }

  ui.ColorFilter _colorControlsColorFilter(
    double brightness,
    double contrast,
    double saturation,
  ) {
    final invSat = 1.0 - saturation;
    final r = 0.213 * invSat;
    final g = 0.715 * invSat;
    final b = 0.072 * invSat;

    final c = contrast;
    final t = (0.5 - c * 0.5 + brightness) * 255.0;
    final s = saturation;

    final cr = c * r;
    final cg = c * g;
    final cb = c * b;
    final cs = c * s;

    return ui.ColorFilter.matrix([
      cr + cs, cg, cb, 0, t,
      cr, cg + cs, cb, 0, t,
      cr, cg, cb + cs, 0, t,
      0, 0, 0, 1, 0,
    ]);
  }
}
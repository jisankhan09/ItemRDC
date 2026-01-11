import 'HighlightStyle.dart';

class Highlight {
  final double width;
  final double blurRadius;
  final double alpha;
  final HighlightStyle style;

  const Highlight({
    this.width = 0.5,
    double? blurRadius,
    this.alpha = 1.0,
    this.style = const HighlightStyleDefault(),
  }) : blurRadius = blurRadius ?? width / 2.0;

  static const Highlight defaults = Highlight();
  static final Highlight ambient = Highlight(style: HighlightStyleAmbient());
  static const Highlight plain = Highlight(style: HighlightStylePlain());
}

import 'package:flutter_test/flutter_test.dart';
import 'package:backdrop/backdrops/EmptyBackdrop.dart';
import 'package:backdrop/BackdropEffectScope.dart';
import 'package:backdrop/highlight/HighlightStyle.dart';
import 'package:backdrop/highlight/Highlight.dart';
import 'package:backdrop/shadow/Shadow.dart';
import 'package:backdrop/shadow/InnerShadow.dart';

void main() {
  test('Backdrop components can be instantiated', () {
    const backdrop = EmptyBackdrop();
    expect(backdrop.isCoordinatesDependent, isFalse);

    final scope = BackdropEffectScopeImpl();
    expect(scope.padding, 0.0);
    expect(scope.density, 1.0);

    const highlightStyle = HighlightStyleDefault();
    expect(highlightStyle.angle, 45.0);

    const highlight = Highlight();
    expect(highlight.width, 0.5);

    const shadow = Shadow();
    expect(shadow.radius, 24.0);

    const innerShadow = InnerShadow();
    expect(innerShadow.radius, 24.0);
  });
}

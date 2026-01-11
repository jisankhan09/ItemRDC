import 'dart:ui';

Picture recordLayer(Size size, void Function(Canvas) block) {
  final recorder = PictureRecorder();
  final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, size.width, size.height));
  block(canvas);
  return recorder.endRecording();
}

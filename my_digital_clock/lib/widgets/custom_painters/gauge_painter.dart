import 'package:flutter/material.dart';

import 'dart:math';
import 'dart:ui';

class GaugePainter extends CustomPainter {
  final Animation<double> animation;
  final DateTime time;
  final num temperature;
  Offset center;
  Rect position = Rect.zero;
  final double fullCircle = pi * 2;
  final double startAngle = pi * 1.5;

  GaugePainter({@required this.animation, this.time, this.temperature})
      : super(repaint: animation);

  double _progressFromMilliseconds() => (1.0 - (1.0 - animation.value));
  double progressFromSeconds() => (1.0 / 60) * (time.second + animation.value);

  double progressFromMinutes() =>
      (1.0 / (60 * 60)) * ((time.minute * 60) + time.second + animation.value);

  double progressFromHours() {
    if (time.hour == 0) {
      return (1.0 / (60 * 60 * 24)) *
          ((time.minute * 60) + time.second + animation.value);
    }
    return (1.0 / (60 * 60 * 24)) *
        ((time.hour * 60 * 60) + time.second + animation.value);
  }

  drawGaugeRing(Canvas canvas, Size size, Paint paint, double sizeRatio,
      Function progress) {
    position = Rect.fromCenter(
        center: center,
        width: size.height / sizeRatio,
        height: size.height / sizeRatio);
    canvas.drawArc(position, startAngle, progress() * fullCircle, false, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    center = new Offset(size.width / 2, size.height / 2);

    paint.style = PaintingStyle.stroke;
    paint.color = Colors.white12;
    drawGaugeRing(canvas, size, paint, 2.2, _progressFromMilliseconds);

    paint.color = Colors.white24;
    drawGaugeRing(canvas, size, paint, 2, progressFromSeconds);

    paint.color = Colors.white38;
    drawGaugeRing(canvas, size, paint, 1.85, progressFromMinutes);

    paint.color = Colors.white54;
    drawGaugeRing(canvas, size, paint, 1.72, progressFromHours);
  }

  @override
  bool shouldRepaint(GaugePainter oldDelegate) {
    return animation.value != oldDelegate.animation.value;
  }
}

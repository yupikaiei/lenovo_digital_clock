import 'dart:math';

import 'package:flutter/material.dart';

class Particle {
  Color color;
  double direction;
  double speed;
  double radius;
  double x;
  double y;
  double maxSize;

  Particle({this.color, this.maxSize}) {
    this.direction = Random().nextDouble() * 360;
    this.speed = Random().nextDouble();
    this.radius = Random().nextDouble() * maxSize;
  }

  void assignRandomPositionIfUninitialized(Size canvasSize) {
    if (x == null) {
      this.x = Random().nextDouble() * canvasSize.width;
    }

    if (y == null) {
      this.y = Random().nextDouble() * canvasSize.height;
    }
  }

  updatePosition() {
    var a = 180 - (direction + 90);
    direction > 0 && direction < 180
        ? x += speed * sin(direction) / sin(speed)
        : x -= speed * sin(direction) / sin(speed);
    direction > 90 && direction < 270
        ? y += speed * sin(a) / sin(speed)
        : y -= speed * sin(a) / sin(speed);
  }

  randomlyChangeDirectionIfEdgeReached(Size canvasSize) {
    if (x > canvasSize.width || x < 0 || y > canvasSize.height || y < 0) {
      direction = Random().nextDouble() * 360;
    }
  }

  double distanceTo(Particle p) {
    var dx = this.x - p.x;
    var dy = this.y - p.y;
    return sqrt(dx * dx + dy * dy);
  }

  void draw(Canvas canvas, Size canvasSize) {
    Paint paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    assignRandomPositionIfUninitialized(canvasSize);

    randomlyChangeDirectionIfEdgeReached(canvasSize);

    canvas.drawCircle(Offset(x, y), radius + (radius / 2), paint);

    paint.color = color.withOpacity(1.0);
    canvas.drawCircle(Offset(x, y), radius, paint);
  }

  Offset get pos => Offset(this.x, this.y);
}

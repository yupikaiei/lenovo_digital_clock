import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/particle.dart';

class ParticleSystemPainter extends CustomPainter {
  List<Particle> particles;
  AnimationController controller;
  var d;
  Offset offset1 = Offset.zero;
  Offset offset2 = Offset.zero;

  ParticleSystemPainter({this.particles, this.controller});

  @override
  void paint(Canvas canvas, Size canvasSize) {
//    particles.forEach((it) => it.draw(canvas, canvasSize));
    Paint paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < particles.length; i++) {
      particles[i].draw(canvas, canvasSize);
      for (int j = 0; j < particles.length; j++) {
        if (i > j) {
          d = particles[i].distanceTo(particles[j]);
          if (d <= canvasSize.width / 10) {
            canvas.drawLine(particles[i].pos, particles[j].pos, paint);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

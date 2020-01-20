import 'package:analog_clock/constants.dart';
import 'package:analog_clock/widgets/custom_painters/particle_system.dart';
import 'package:flutter/material.dart';
import '../models/particle.dart';

class Particles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ParticlesState();
  }
}

class _ParticlesState extends State<Particles> with TickerProviderStateMixin {
  AnimationController _controller;
  List<Particle> particles;

  @override
  void initState() {
    super.initState();

    // Initialize particles
    particles = List();

    int i = kNumberOfParticles;
    while (i > 0) {
      particles.add(Particle(color: kParticleColor, maxSize: kMaxParticleSize));
      i--;
    }

    // Init animation controller
    _controller = new AnimationController(
        duration: const Duration(seconds: 1000),
        vsync: this,
        reverseDuration: const Duration(seconds: 1000),
        animationBehavior: AnimationBehavior.preserve);

    _controller.addListener(() {
      updateParticlePosition();
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomPaint(
        foregroundPainter: ParticleSystemPainter(
            particles: particles, controller: _controller),
        size: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
      ),
    );
  }

  void updateParticlePosition() {
    particles.forEach((it) => it.updatePosition());
    setState(() {});
  }
}

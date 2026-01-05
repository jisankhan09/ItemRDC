import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ParticleScene extends StatefulWidget {
  const ParticleScene({super.key});

  @override
  State<ParticleScene> createState() => _ParticleSceneState();
}

class _ParticleSceneState extends State<ParticleScene>
    with SingleTickerProviderStateMixin {
  late final Ticker ticker;
  final List<Particle> particles = [];
  final Random rand = Random();

  static const int maxParticles = 100;
  static const double speed = 0.55;
  static const double connectDistance = 130;

  @override
  void initState() {
    super.initState();
    ticker = createTicker(_tick)..start();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = context.findRenderObject() as RenderBox?;
      if (box != null) {
        _spawnRandomFar(box.size, 35);
      }
    });
  }

  void _tick(Duration _) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;

    final size = box.size;

    setState(() {
      for (final p in particles) {
        p.update();
      }

      particles.removeWhere((p) => p.dead(size));
      _spawnRandomFar(size, 5);
    });
  }

  void _spawn(Offset pos, int amount) {
    for (int i = 0;
        i < amount && particles.length < maxParticles;
        i++) {
      final a = rand.nextDouble() * pi * 2;
      final v = Offset(cos(a), sin(a)) *
          ((rand.nextDouble() * 0.5 + 0.6) * speed);

      particles.add(Particle(pos, v));
    }
  }

  void _spawnRandomFar(Size s, int amount) {
    int tries = 0;
    while (particles.length < maxParticles && tries < amount * 10) {
      final p = Offset(
        rand.nextDouble() * s.width,
        rand.nextDouble() * s.height,
      );

      final close = particles.any((e) => (e.pos - p).distance < 80);
      if (!close) _spawn(p, 1);

      tries++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: false,
      child: Listener(
        onPointerDown: (e) {
          final pos = e.localPosition;

          particles.removeWhere(
            (p) => (p.pos - pos).distance < 50,
          );

          _spawn(pos, 2);
        },
        child: CustomPaint(
          size: Size.infinite,
          painter: ParticlePainter(particles),
        ),
      ),
    );
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }
}

class Particle {
  Offset pos;
  Offset vel;
  double alpha;
  final int birth;

  Particle(this.pos, this.vel)
      : alpha = 0.9,
        birth = DateTime.now().millisecondsSinceEpoch;

  void update() {
    vel *= 0.995;
    pos += vel;

    if (DateTime.now().millisecondsSinceEpoch - birth > 40000) {
      alpha -= 0.01;
    }
  }

  bool dead(Size s) {
    return alpha <= 0 ||
        pos.dx < -120 ||
        pos.dx > s.width + 120 ||
        pos.dy < -120 ||
        pos.dy > s.height + 120;
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  
  static const double connectDistance = 130; 

  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final pPaint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        final a = particles[i];
        final b = particles[j];
        final d = (a.pos - b.pos).distance;

        if (d < connectDistance) {
          final alpha = (1 - d / connectDistance) * 0.8;
          canvas.drawLine(
            a.pos,
            b.pos,
            Paint()
              ..color = Colors.blueGrey.withOpacity(alpha.clamp(0.0, 1.0))
              ..strokeWidth = 1,
          );
        }
      }
    }

    for (final p in particles) {
      pPaint.color = Colors.white.withOpacity((p.alpha * 0.5).clamp(0.0, 1.0));
      canvas.drawCircle(p.pos, 2.2, pPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

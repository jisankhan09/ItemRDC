import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            // Background content to see the blur effect
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1544377193-33dcf4d68fb5?q=80&w=1932'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Center the button
            const Center(
              child: LiquidButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class LiquidButton extends StatefulWidget {
  const LiquidButton({super.key});

  @override
  State<LiquidButton> createState() => _LiquidButtonState();
}

class _LiquidButtonState extends State<LiquidButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset _dragOffset = Offset.zero;

  // Tanh function for a squishy effect, similar to the original code
  double _tanh(double x) {
    return (math.exp(x) - math.exp(-x)) / (math.exp(x) + math.exp(-x));
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    _controller.stop();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    // Animate back to the center
    final animation = Tween<Offset>(begin: _dragOffset, end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    animation.addListener(() {
      setState(() {
        _dragOffset = animation.value;
      });
    });

    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = const Size(200, 50);

    // Calculate transformation based on drag offset
    final maxOffset = size.shortestSide;
    final tx = maxOffset * _tanh(0.5 * _dragOffset.dx / maxOffset);
    final ty = maxOffset * _tanh(0.5 * _dragOffset.dy / maxOffset);

    // Squishy scale effect
    final scaleX = 1.0 + 0.1 * (_dragOffset.dx.abs() / size.width).clamp(0.0, 1.0);
    final scaleY = 1.0 + 0.1 * (_dragOffset.dy.abs() / size.height).clamp(0.0, 1.0);

    final transform = Matrix4.identity()
      ..translate(tx, ty)
      ..scale(scaleX, scaleY);

    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform(
        transform: transform,
        alignment: FractionalOffset.center,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(size.height),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(size.height),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: const Center(
                  child: Text(
                    'Liquid Button',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

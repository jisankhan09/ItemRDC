import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

class LiquidButton extends StatefulWidget {
  final Widget child;
  final double width;
  final double height;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color borderColor;

  const LiquidButton({
    super.key,
    required this.child,
    this.width = 200,
    this.height = 50,
    this.onTap,
    this.backgroundColor = const Color(0x33FFFFFF),
    this.borderColor = const Color(0x55FFFFFF),
  });

  @override
  State<LiquidButton> createState() => _LiquidButtonState();
}

class _LiquidButtonState extends State<LiquidButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset _dragOffset = Offset.zero;

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

  void _onPanStart(_) {
    _controller.stop();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta;
    });
  }

  void _onPanEnd(_) {
    final animation = Tween<Offset>(
      begin: _dragOffset,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    animation.addListener(() {
      setState(() {
        _dragOffset = animation.value;
      });
    });

    _controller
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = Size(widget.width, widget.height);
    final maxOffset = size.shortestSide;

    final tx = maxOffset * _tanh(0.5 * _dragOffset.dx / maxOffset);
    final ty = maxOffset * _tanh(0.5 * _dragOffset.dy / maxOffset);

    final scaleX =
        1.0 + 0.1 * (_dragOffset.dx.abs() / size.width).clamp(0.0, 1.0);
    final scaleY =
        1.0 + 0.1 * (_dragOffset.dy.abs() / size.height).clamp(0.0, 1.0);

    final transform = Matrix4.identity()
      ..translate(tx, ty)
      ..scale(scaleX, scaleY);

    return GestureDetector(
      onTap: widget.onTap,
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform(
        transform: transform,
        alignment: Alignment.center,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(size.height),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(size.height),
                  border: Border.all(color: widget.borderColor),
                ),
                child: Center(child: widget.child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
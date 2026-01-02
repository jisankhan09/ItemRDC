import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class LiquidButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onClick;
  final ui.FragmentShader shader;

  const LiquidButton({
    super.key,
    required this.child,
    required this.onClick,
    required this.shader,
  });

  @override
  State<LiquidButton> createState() => _LiquidButtonState();
}

class _LiquidButtonState extends State<LiquidButton>
    with SingleTickerProviderStateMixin {
  // Animation controller for the press/release and drag-return spring effects
  late AnimationController _controller;

  // Animation for the press/release scale effect
  late Animation<double> _scaleAnimation;

  // Stores the drag offset to apply translation
  Offset _dragOffset = Offset.zero;

  // The position where the user starts dragging.
  // This is used to calculate the return-to-center animation.
  Offset _dragStartPosition = Offset.zero;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

    // This animation runs when the controller is "flung"
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
  }

  // --- Gesture Handlers ---

  void _onPanStart(DragStartDetails details) {
    _dragStartPosition = details.localPosition;
    _controller.stop(); // Stop any ongoing animations
    // Animate the button scaling down
    _controller.forward();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      // Calculate the offset from the initial touch point and apply a tanh-like effect
      final delta = details.localPosition - _dragStartPosition;
      // Simple division to reduce the intensity of the drag, similar to the original's tanh
      _dragOffset = delta / 2.0; 
    });
  }

  void _onPanEnd(DragEndDetails details) {
    // We need to animate the button back to its original position and scale.
    // We use a spring simulation for a bouncy, natural feel.
    final spring = SpringDescription(mass: 0.8, stiffness: 120.0, damping: 8.0);
    
    // Animate the drag offset back to zero
    final offsetAnimation = SpringSimulation(spring, _dragOffset.distance, 0, details.velocity.pixelsPerSecond.distance);
    
    // Animate the button scale back to 1.0
    _controller.animateWith(SpringSimulation(spring, _controller.value, 0, 0));
    
    _controller.addListener(() {
      if(_controller.isAnimating) {
        final currentOffset = _dragOffset.direction;
        final newDistance = offsetAnimation.x(_controller.lastElapsedDuration!.inMilliseconds / 1000);
        setState(() {
            _dragOffset = Offset.fromDirection(currentOffset, newDistance);
        });
      }
    });

    // If the drag ends close to the center, register it as a click
    if (_dragOffset.distance < 5.0) {
      widget.onClick();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // --- Build Method ---
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      onPanCancel: () => _onPanEnd(DragEndDetails()), // Treat cancel as end
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: _dragOffset,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.0), // Capsule shape
          child: Stack(
            children: [
              // 1. The main glass/blur effect
              BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              // 2. The custom lens shader effect on top of the blur
              ShaderMask(
                shaderCallback: (bounds) {
                  // Set the uniforms for the shader
                  widget.shader
                    ..setFloat(0, bounds.width)
                    ..setFloat(1, bounds.height)
                    ..setFloat(2, 0.5) // u_lens_radius
                    ..setFloat(3, 0.25); // u_refraction

                  return widget.shader;
                },
                blendMode: BlendMode.srcOver,
                // The ShaderMask needs a child to apply the mask to
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: widget.child,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

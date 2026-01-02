import 'package:flutter/material.dart';

class GlowTextField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;

  const GlowTextField({
    super.key,
    required this.label,
    this.controller,
  });

  @override
  State<GlowTextField> createState() => _GlowTextFieldState();
}

class _GlowTextFieldState extends State<GlowTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _glowAnimation;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6), // CSS 6s
    );

    _glowAnimation = TweenSequence<Color?>([
      TweenSequenceItem(
        tween: ColorTween(begin: Color(0xFFFFDD33), end: Color(0xFFFFAA5A)),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Color(0xFFFFAA5A), end: Color(0xFF966EFF)),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Color(0xFF966EFF), end: Color(0xFF5AC8FF)),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Color(0xFF5AC8FF), end: Color(0xFFFFDD33)),
        weight: 25,
      ),
    ]).animate(_controller);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        final glowColor = _focusNode.hasFocus
            ? _glowAnimation.value ?? Colors.transparent
            : Colors.transparent;

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.transparent,
              width: 2,
            ),
            boxShadow: _focusNode.hasFocus
                ? [
                    BoxShadow(
                      color: glowColor.withOpacity(0.25),
                      blurRadius: 6,
                    ),
                    BoxShadow(
                      color: glowColor.withOpacity(0.35),
                      blurRadius: 0,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
          ),
        );
      },
    );
  }
}
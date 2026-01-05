import 'package:flutter/material.dart';

class GlowTextField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;
  final TextInputType inputType;
  final bool isPassword;

  const GlowTextField({
    super.key,
    required this.label,
    this.controller,
    this.icon,
    this.isPassword = false,
    this.inputType = TextInputType.text,
    this.backgroundColor = const Color(0x00000000),
    this.textColor = Colors.black,
  });

  @override
  State<GlowTextField> createState() => _GlowTextFieldState();
}

class _GlowTextFieldState extends State<GlowTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _glowAnimation;
  final FocusNode _focusNode = FocusNode();

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
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
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(8),
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
            keyboardType: widget.inputType,
            obscureText: widget.isPassword ? _obscureText : false,
            style: TextStyle(color: widget.textColor),
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),

              // 👈 Left Icon
              prefixIcon: widget.icon != null
                  ? Icon(widget.icon, color: Colors.grey)
                  : null,

              // 👁 Eye Icon for password
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }
}
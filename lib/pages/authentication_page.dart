import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:itemrdc/pages/home_page.dart';
import 'package:itemrdc/util/glow_text_field.dart';
import 'package:itemrdc/util/liquid_button.dart';
import 'package:itemrdc/util/particles.dart'; // ParticleScene

/// Generic liquid effect wrapper for bouncy UI
class LiquidEffect extends StatefulWidget {
  final Widget child;
  final double maxScale;
  final double maxOffset;

  const LiquidEffect({
    super.key,
    required this.child,
    this.maxScale = 0.05, // up to 5% scale
    this.maxOffset = 15,  // max drag offset
  });

  @override
  State<LiquidEffect> createState() => _LiquidEffectState();
}

class _LiquidEffectState extends State<LiquidEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset _dragOffset = Offset.zero;

  double _tanh(double x) => (math.exp(x) - math.exp(-x)) / (math.exp(x) + math.exp(-x));

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

  void _onPanStart(_) => _controller.stop();

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta;
    });
  }

  void _onPanEnd(_) {
    final animation = Tween<Offset>(
      begin: _dragOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

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
    final tx = widget.maxOffset * _tanh(0.5 * _dragOffset.dx / widget.maxOffset);
    final ty = widget.maxOffset * _tanh(0.5 * _dragOffset.dy / widget.maxOffset);

    final scaleX = 1.0 + widget.maxScale * (_dragOffset.dx.abs() / widget.maxOffset).clamp(0.0, 1.0);
    final scaleY = 1.0 + widget.maxScale * (_dragOffset.dy.abs() / widget.maxOffset).clamp(0.0, 1.0);

    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform(
        transform: Matrix4.identity()..translate(tx, ty)..scale(scaleX, scaleY),
        alignment: Alignment.center,
        child: widget.child,
      ),
    );
  }
}

/// --------------------
/// Sign Up Page
/// --------------------
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: Stack(
        children: [
          // Particle Background
          const Positioned.fill(child: ParticleScene()),

          // Glass overlay
          Positioned.fill(
            child: IgnorePointer(
              ignoring: true,
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          ),

          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: const Color(0x1A1A1A),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.05),
                      blurRadius: 30,
                    ),
                  ],
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Welcome In \nItem RDC",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Phone
                      LiquidEffect(
                        child: GlowTextField(
                          label: "Enter phone number",
                          icon: Icons.phone,
                          controller: phoneController,
                          backgroundColor: const Color(0xFF2A2A2A),
                          textColor: Colors.white,
                          inputType: TextInputType.phone,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Email
                      LiquidEffect(
                        child: GlowTextField(
                          label: "Enter Email",
                          icon: Icons.email,
                          controller: emailController,
                          backgroundColor: const Color(0xFF2A2A2A),
                          textColor: Colors.white,
                          inputType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Password
                      LiquidEffect(
                        child: GlowTextField(
                          label: "Enter Password",
                          icon: Icons.lock,
                          controller: passwordController,
                          backgroundColor: const Color(0xFF2A2A2A),
                          textColor: Colors.white,
                          isPassword: true,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Sign Up Button
                      LiquidEffect(
                        child: LiquidButton(
                          width: double.infinity,
                          height: 50,
                          backgroundColor: const Color(0xFFFFDD33),
                          borderColor: Colors.transparent,
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => HomePage()),
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Bottom Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          LiquidEffect(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const LoginPage()),
                                );
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Color(0xFFFFDD33),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// --------------------
/// Login Page
/// --------------------
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: Stack(
        children: [
          const Positioned.fill(child: ParticleScene()),

          Positioned.fill(
            child: IgnorePointer(
              ignoring: true,
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          ),

          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: const Color(0x1A1A1A),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.05),
                      blurRadius: 30,
                    ),
                  ],
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Welcome Back",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Email
                      LiquidEffect(
                        child: GlowTextField(
                          label: "Enter Email",
                          icon: Icons.email,
                          controller: emailController,
                          backgroundColor: const Color(0xFF2A2A2A),
                          textColor: Colors.white,
                          inputType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Password
                      LiquidEffect(
                        child: GlowTextField(
                          label: "Enter Password",
                          icon: Icons.lock,
                          controller: passwordController,
                          backgroundColor: const Color(0xFF2A2A2A),
                          textColor: Colors.white,
                          isPassword: true,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Sign In Button
                      LiquidEffect(
                        child: LiquidButton(
                          width: double.infinity,
                          height: 50,
                          backgroundColor: const Color(0xFFFFDD33),
                          borderColor: Colors.transparent,
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => HomePage()),
                            );
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Bottom Links
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LiquidEffect(
                            child: InkWell(
                              onTap: () => Navigator.pop(context),
                              child: const Text(
                                "Don't have an account?",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          LiquidEffect(
                            child: InkWell(
                              onTap: () => debugPrint("Forget password clicked"),
                              child: const Text(
                                "Forget password",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
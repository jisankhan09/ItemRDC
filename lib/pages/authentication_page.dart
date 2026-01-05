import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:itemrdc/pages/home_page.dart';
import 'package:itemrdc/util/glow_text_field.dart';
import 'package:itemrdc/util/liquid_button.dart';
import 'package:itemrdc/util/particles.dart'; // ParticleScene

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
      backgroundColor: const Color(0xFF0F0F0F), // Dark background
      body: Stack(
        children: [
          // Particle Background
          const Positioned.fill(child: ParticleScene()),

          // Overlay for glass effect
          Positioned.fill(
            child: IgnorePointer(
              ignoring: true,
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          ),

          // Centered Container (like CSS .container)
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: const Color(0x1A1A1A), // semi-transparent dark
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
                      GlowTextField(
                        label: "Enter phone number",
                        controller: phoneController,
                        backgroundColor: const Color(0xFF2A2A2A),
                        textColor: Colors.white,
                        inputType: TextInputType.phone,
                      ),
                      const SizedBox(height: 12),

                      // Email
                      GlowTextField(
                        label: "Enter Email",
                        controller: emailController,
                        backgroundColor: const Color(0xFF2A2A2A),
                        textColor: Colors.white,
                        inputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 12),

                      // Password
                      GlowTextField(
                        label: "Enter Password",
                        controller: passwordController,
                        backgroundColor: const Color(0xFF2A2A2A),
                        textColor: Colors.white,
                        isPassword: true,
                      ),
                      const SizedBox(height: 20),

                      // Sign Up Button
                      LiquidButton(
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
                      const SizedBox(height: 12),

                      // Bottom Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const Login()),
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

// Login Page
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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

                      GlowTextField(
                        label: "Enter Email",
                        controller: emailController,
                        backgroundColor: const Color(0xFF2A2A2A),
                        textColor: Colors.white,
                        inputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 12),

                      GlowTextField(
                        label: "Enter Password",
                        controller: passwordController,
                        backgroundColor: const Color(0xFF2A2A2A),
                        textColor: Colors.white,
                        isPassword: true,
                      ),
                      const SizedBox(height: 20),

                      LiquidButton(
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
                      const SizedBox(height: 12),

                      // Bottom Links
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              "Don't have an account?",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              debugPrint("Forget password clicked");
                            },
                            child: const Text(
                              "Forget password",
                              style: TextStyle(color: Colors.grey),
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
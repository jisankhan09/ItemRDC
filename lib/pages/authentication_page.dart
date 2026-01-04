import 'package:flutter/material.dart';
import 'package:itemrdc/util/glow_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _animation = Tween<double>(begin: 1.0, end: 1.0).animate(_controller); // initial dummy
  }

  @override
  void dispose() {
    _controller.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void navigateToSignUp() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const SignUpPage(),
        transitionDuration: const Duration(milliseconds: 700),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // scale animation for ClipPath
          return Stack(
            children: [
              AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: Tween<double>(begin: 0.0, end: 2.0)
                      .animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut))
                      .value,
                  origin: const Offset(-50, -50),
                  child: ClipPath(
                    clipper: QuarterCircleClipper(),
                    child: Container(
                      width: 220,
                      height: 220,
                      color: const Color(0xffcff3f4),
                    ),
                  ),
                );
              },
            ),
              FadeTransition(
                opacity: animation,
                child: child,
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          ClipPath(
            clipper: QuarterCircleClipper(),
            child: Container(
              width: 220,
              height: 220,
              color: const Color(0xffcff3f4),
              child: const Center(
                child: Text(
                  "Welcome\nBack",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 240, 20, 100),
            child: Column(
              children: [
                GlowTextField(
                  label: "Enter Email",
                  controller: emailController,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 15),
                GlowTextField(
                  label: "Enter Password",
                  controller: passwordController,
                  isPassword: true,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    const Text(
                      "Sign In",
                      style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        debugPrint("Login clicked");
                      },
                      tooltip: "Login",
                      icon: const Icon(Icons.arrow_forward, color: Colors.white),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: const CircleBorder(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: InkWell(
              onTap: navigateToSignUp,
              child: const Text("Don't have an account?"),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                debugPrint("Forget password clicked");
              },
              child: const Text("Forget password"),
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with SingleTickerProviderStateMixin {
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _animation = Tween<double>(begin: 2.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void navigateBack() {
    _controller.reverse().then((_) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.scale(
                scale: _animation.value,
                origin: const Offset(-50, -50),
                child: ClipPath(
                  clipper: QuarterCircleClipper(),
                  child: Container(
                    width: 220,
                    height: 220,
                    color: const Color(0xffcff3f4),
                    child: const Center(
                      child: Text(
                        "Welcome In\nItem RDC",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 240, 20, 100),
            child: Column(
              children: [
                GlowTextField(
                  label: "Enter phone number",
                  controller: phoneController,
                  backgroundColor: Colors.white,
                  inputType: TextInputType.number,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 15),
                GlowTextField(
                  label: "Enter Email",
                  controller: emailController,
                  inputType: TextInputType.emailAddress,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 15),
                GlowTextField(
                  label: "Enter Password",
                  controller: passwordController,
                  isPassword: true,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        debugPrint("Sign Up clicked");
                      },
                      tooltip: "Sign Up",
                      icon: const Icon(Icons.arrow_forward, color: Colors.white),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: const CircleBorder(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: InkWell(
              onTap: navigateBack,
              child: const Text("Already have an account?"),
            ),
          ),
          Positioned(
            bottom: 15,
            right: 20,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.help),
              tooltip: "Support",
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom quarter circle clipper
class QuarterCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width, 0);
    path.arcToPoint(
      Offset(0, size.height),
      radius: Radius.circular(size.width),
      clockwise: true,
    );
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
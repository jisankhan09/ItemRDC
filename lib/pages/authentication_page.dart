import 'package:flutter/material.dart';
import 'package:itemrdc/util/glow_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          /// Header Shape
          ClipPath(
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

          /// Scrollable Form
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 240, 20, 100),
            child: Column(
              children: [
                GlowTextField(
                  label: "Enter phone number",
                  controller: phoneController,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 15),
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
                  textColor: Colors.black,
                ),
                const SizedBox(height: 25),

                Row(
                  children: [
                    const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        debugPrint("Sign Up clicked");
                      },
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

          /// Bottom Left
          Positioned(
            bottom: 20,
            left: 20,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
              child: const Text("Already have an account?"),
            ),
          ),

          /// Bottom Right
          Positioned(
            bottom: 15,
            right: 20,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.help),
            ),
          ),
        ],
      ),
    );
  }
}

class QuarterCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(size.width * 1.0, 0); // M80 0

    path.arcToPoint(
      Offset(0, size.height * 1.0), // 0 80
      radius: Radius.circular(size.width * 1.0), // 80 80
      clockwise: true,
    );

    path.lineTo(0, 0); // L0 0
    path.close(); // Z

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          /// Header Shape
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
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          /// Scrollable Form
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
                  textColor: Colors.black,
                ),
                const SizedBox(height: 25),

                Row(
                  children: [
                    const Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        debugPrint("Login clicked");
                      },
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

          /// Bottom Left
          Positioned(
            bottom: 20,
            left: 20,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text("Don't have an account?"),
            ),
          ),

          /// Bottom Right
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
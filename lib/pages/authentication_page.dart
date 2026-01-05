import 'package:flutter/material.dart';
import 'package:itemrdc/pages/home_page.dart';
import 'package:itemrdc/util/glow_text_field.dart';
import 'package:itemrdc/util/liquid_button.dart';
import 'package:itemrdc/util/particles.dart';

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
      body: Stack(
        children: [
          /// 🔥 PARTICLE BACKGROUND
          const Positioned.fill(
            child: ParticleScene(),
          ),

          /// 🎨 overlay (UI readable রাখতে)
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.85),
            ),
          ),

          /// TOP SHAPE
          ClipPath(
            clipper: QuarterCircleClipper(),
            child: Container(
              width: 200,
              height: 200,
              color: const Color(0xffcff3f4),
              child: const Center(
                child: Text(
                  "Welcome In \nItem RDC",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          /// FORM
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: GlowTextField(
                    label: "Enter phone number",
                    backgroundColor: Colors.white,
                    controller: phoneController,
                    textColor: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: GlowTextField(
                    label: "Enter Email",
                    backgroundColor: Colors.white,
                    controller: emailController,
                    textColor: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: GlowTextField(
                    label: "Enter Password",
                    controller: passwordController,
                    textColor: Colors.black,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    children: [
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      LiquidButton(
                        width: 55,
                        height: 55,
                        backgroundColor: Colors.black.withOpacity(0.8),
                        borderColor: Colors.black,
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HomePage(),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// BOTTOM LINKS
          Positioned(
            bottom: 20,
            left: 20,
            child: InkWell(
              child: const Text("Already have an account?"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Login()),
                );
              },
            ),
          ),
          Positioned(
            bottom: 13,
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
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔥 PARTICLE BACKGROUND
          const Positioned.fill(
            child: ParticleScene(),
          ),

          /// overlay
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.85),
            ),
          ),

          ClipPath(
            clipper: QuarterCircleClipper(),
            child: Container(
              width: 200,
              height: 200,
              color: const Color(0xffcff3f4),
              child: const Center(
                child: Text(
                  "Welcome \nBack",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: GlowTextField(
                    label: "Enter Email",
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: GlowTextField(
                    label: "Enter Password",
                    textColor: Colors.black,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    children: [
                      const Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      LiquidButton(
                        width: 55,
                        height: 55,
                        backgroundColor: Colors.black.withOpacity(0.85),
                        borderColor: Colors.black,
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HomePage(),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 20,
            left: 20,
            child: InkWell(
              child: const Text("Don't have any account?"),
              onTap: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
              child: const Text("Forget password"),
              onTap: () {
                debugPrint("Forget password clicked");
              },
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

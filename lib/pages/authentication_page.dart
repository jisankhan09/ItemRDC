import 'package:flutter/material.dart';
import 'package:itemrdc/util/glow_text_field.dart';
import 'package:itemrdc/util/liquid_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: GlowTextField(
                    label: "Enter phone number",
                    backgroundColor: Colors.white,
                    controller: phoneController,
                    textColor: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
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
                        onTap: () {
                          print("Sign Up clicked");
                        },
                        backgroundColor: Colors.black.withOpacity(0.8),
                        borderColor: Colors.black,
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                LiquidButton(
                  width: 220,
                  height: 40,
                  backgroundColor: Colors.white.withOpacity(0.6),
                  borderColor: Colors.black26,
                  onTap: () {
                    print("Already have an account clicked");
                  },
                  child: const Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.help),
            ),
            bottom: 13,
            right: 20,
          ),
          ClipPath(
            clipper: QuarterCircleClipper(),
            child: Container(
              child: const Center(
                child: Text(
                  "Welcome In \nItem RDC",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              width: 200,
              height: 200,
              color: Color(0xffcff3f4),
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------- Login Page -------------------------
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: QuarterCircleClipper(),
            child: Container(
              child: const Center(
                child: Text(
                  "Welcome \nBack",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              width: 200,
              height: 200,
              color: Color(0xffcff3f4),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
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
                        onTap: () {
                          print("Login clicked");
                        },
                        backgroundColor: Colors.black.withOpacity(0.85),
                        borderColor: Colors.black,
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LiquidButton(
                      width: 240,
                      height: 40,
                      backgroundColor: Colors.white.withOpacity(0.6),
                      borderColor: Colors.black26,
                      onTap: () {
                        print("Go to Sign Up");
                      },
                      child: const Text(
                        "Don't have any account?",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    LiquidButton(
                      width: 150,
                      height: 38,
                      backgroundColor: Colors.white.withOpacity(0.6),
                      borderColor: Colors.black26,
                      onTap: () {
                        print("Forget password clicked");
                      },
                      child: const Text(
                        "Forget password",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                )
              ],
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

    path.moveTo(size.width * 1.0, 0);

    path.arcToPoint(
      Offset(0, size.height * 1.0),
      radius: Radius.circular(size.width * 1.0),
      clockwise: true,
    );

    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

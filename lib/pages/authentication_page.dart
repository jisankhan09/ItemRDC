import 'package:flutter/material.dart';
import 'package:itemrdc/util/glow_text_field.dart';

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
                    controller: passwordController,
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
                        IconButton(
                          onPressed: () {
                            print("Sign Up clicked");
                          },
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: const CircleBorder(),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Positioned(
            child: InkWell(
              child: const Text("Already have an account?"),
              onTap: () {
                print(" clicked");
              },
            ),
            bottom: 20,
            left: 20,
          ),
          Positioned(
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.help)),
            bottom: 13,
            right: 20,
          ),
          ClipPath(
            clipper: QuarterCircleClipper(),
            child: Container(
              child: Center(
                child: const Text(
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
          ClipPath(
            clipper: QuarterCircleClipper(),
            child: Container(
              child: Center(
                child: const Text(
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
                        IconButton(
                          onPressed: () {
                            print("Login clicked");
                          },
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: const CircleBorder(),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Positioned(
            child: InkWell(
              child: const Text("Don't have any account?"),
              onTap: () {
                print("Forget password clicked");
              },
            ),
            bottom: 20,
            left: 20,
          ),
          Positioned(
            child: InkWell(
              child: const Text("Forget password"),
              onTap: () {
                print("Forget password clicked");
              },
            ),
            bottom: 20,
            right: 20,
          ),
        ],
      ),
    );
  }
}

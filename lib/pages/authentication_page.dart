import 'package:flutter/material.dart';
import 'package:itemrdc/util/glow_text_field.dart';

/// Sign Up Page
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late AnimationController animationController;
  late Animation<double> widthAnimation;
  late Animation<double> heightAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // ডামি Tween
    widthAnimation = Tween<double>(begin: 1, end: 220).animate(animationController);
    heightAnimation = Tween<double>(begin: 1, end: 220).animate(animationController);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenSize = MediaQuery.of(context).size;

      widthAnimation = Tween<double>(begin: screenSize.width, end: 220).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      )..addListener(() => setState(() {}));

      heightAnimation = Tween<double>(begin: screenSize.height, end: 220).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      );

      animationController.forward();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Form
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 240, 20, 100),
            child: Column(
              children: [
                GlowTextField(
                  label: "Phone number",
                  controller: phoneController,
                  backgroundColor: Colors.white,
                  inputType: TextInputType.number,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 15),
                GlowTextField(
                  label: "Email address",
                  controller: emailController,
                  inputType: TextInputType.emailAddress,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 15),
                GlowTextField(
                  label: "Password",
                  controller: passwordController,
                  isPassword: true,
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
                      onPressed: () {},
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
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

          /// Animated ClipPath
          ClipPath(
            clipper: QuarterCircleClipper(),
            child: Container(
              width: widthAnimation.value,
              height: heightAnimation.value,
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
        ],
      ),
    );
  }
}

/// Login Page
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late AnimationController animationController;
  late Animation<double> widthAnimation;
  late Animation<double> heightAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    widthAnimation = Tween<double>(begin: 1, end: 220).animate(animationController);
    heightAnimation = Tween<double>(begin: 1, end: 220).animate(animationController);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenSize = MediaQuery.of(context).size;

      widthAnimation = Tween<double>(begin: screenSize.width, end: 220).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      )..addListener(() => setState(() {}));

      heightAnimation = Tween<double>(begin: screenSize.height, end: 220).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      );

      animationController.forward();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 240, 20, 100),
            child: Column(
              children: [
                GlowTextField(
                  label: "Email address",
                  controller: emailController,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 15),
                GlowTextField(
                  label: "Password",
                  controller: passwordController,
                  isPassword: true,
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
                      onPressed: () {},
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
              onTap: () {
                Navigator.pop(context);
              },
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

          /// Animated ClipPath
          ClipPath(
            clipper: QuarterCircleClipper(),
            child: Container(
              width: widthAnimation.value,
              height: heightAnimation.value,
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
        ],
      ),
    );
  }
}

/// Custom Clipper
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
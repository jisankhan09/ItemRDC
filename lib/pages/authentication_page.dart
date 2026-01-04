import 'package:flutter/material.dart';
import 'package:itemrdc/util/glow_text_field.dart';

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
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    // প্রথমে ডামি Tween দিয়ে রাখি
    animation = Tween<double>(begin: 1, end: 220).animate(animationController);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // স্ক্রিন সাইজ পাওয়া
      final screenWidth = MediaQuery.of(context).size.width;

      // Tween আপডেট করি পুরো স্ক্রিন থেকে ছোট 220 পর্যন্ত
      animation = Tween<double>(begin: screenWidth, end: 220).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      )..addListener(() {
          setState(() {});
        });

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

          /// Bottom Right
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
              width: animation.value,
              height: animation.value,
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

/// Custom Clipper
class QuarterCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(size.width, 0); // M width 0
    path.arcToPoint(
      Offset(0, size.height), // 0 height
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

/// Login Page
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

     animation = Tween<double>(begin: 1, end: 220).animate(animationController);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // স্ক্রিন সাইজ পাওয়া
      final screenWidth = MediaQuery.of(context).size.width;

      // Tween আপডেট করি পুরো স্ক্রিন থেকে ছোট 220 পর্যন্ত
      animation = Tween<double>(begin: screenWidth, end: 220).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      )..addListener(() {
          setState(() {});
        });

      animationController.forward();
    });

    
    
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [

          /// Scrollable Form
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
                    /// Header Shape
          ClipPath(
            clipper: QuarterCircleClipper(),
            child: Container(
              width: animation.value==1.0?500:animation.value,
              height: animation.value==1.0?500:animation.value,
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
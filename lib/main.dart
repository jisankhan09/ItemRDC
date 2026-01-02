import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'liquid_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liquid Button Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // We need to load the shader from assets. This is an async operation.
  ui.FragmentShader? lensShader;

  @override
  void initState() {
    super.initState();
    _loadShader();
  }

  void _loadShader() async {
    try {
      final program =
          await ui.FragmentProgram.fromAsset('assets/shaders/lens_effect.frag');
      setState(() {
        lensShader = program.fragmentShader();
      });
    } catch (error) {
      debugPrint('Error loading shader: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wallpaper_light.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: lensShader == null
              ? const CircularProgressIndicator() // Show a loader while shader compiles
              : LiquidButton(
                  shader: lensShader!,
                  onClick: () {
                    debugPrint("Button clicked!");
                  },
                  child: const Text(
                    'Transparent Liquid Button',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

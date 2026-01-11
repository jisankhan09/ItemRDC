import 'package:flutter/material.dart';
import 'DrawBackdropModifier.dart';
import 'backdrops/LayerBackdrop.dart';
import 'backdrops/LayerBackdropModifier.dart';
import 'effects/Blur.dart';
import 'effects/Lens.dart';
import 'highlight/Highlight.dart';
import 'shadow/Shadow.dart';

void main() {
  runApp(const MaterialApp(
    home: AeroApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class AeroApp extends StatefulWidget {
  const AeroApp({super.key});

  @override
  State<AeroApp> createState() => _AeroAppState();
}

class _AeroAppState extends State<AeroApp> {
  final LayerBackdrop _globalBackdrop = LayerBackdrop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      // 1. Transparent AppBar Slot
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: GlassAppBar(backdrop: _globalBackdrop),
      ),

      // 2. Complex Background
      body: Stack(
        children: [
          LayerBackdropModifier(
            backdrop: _globalBackdrop,
            child: const BackgroundContent(),
          ),
          // Scrollable content
          ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 100, 20, 100),
            itemCount: 20,
            itemBuilder: (context, index) => GlassCard(
              index: index,
              backdrop: _globalBackdrop,
            ),
          ),
        ],
      ),

      // 3. Floating Action Button
      floatingActionButton: GlassFAB(backdrop: _globalBackdrop),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // 4. Bottom Navigation Bar
      bottomNavigationBar: GlassBottomNav(backdrop: _globalBackdrop),
    );
  }
}

/// A Glassmorphic AppBar
class GlassAppBar extends StatelessWidget {
  final LayerBackdrop backdrop;
  const GlassAppBar({super.key, required this.backdrop});

  @override
  Widget build(BuildContext context) {
    return DrawBackdrop(
      backdrop: backdrop,
      shape: () => const RoundedRectangleBorder(),
      effects: (scope) => scope.blur(radius: 15),
      highlight: () => Highlight.defaults,
      child: AppBar(
        title: const Text("Aero UI", style: TextStyle(fontWeight: FontWeight.w300)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.settings))],
      ),
    );
  }
}

/// A Glassmorphic Bottom Navigation Bar
class GlassBottomNav extends StatelessWidget {
  final LayerBackdrop backdrop;
  const GlassBottomNav({super.key, required this.backdrop});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: DrawBackdrop(
        backdrop: backdrop,
        shape: () => const RoundedRectangleBorder(),
        effects: (scope) => scope.blur(radius: 20),
        highlight: () => Highlight.defaults,
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          notchMargin: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.home, color: Colors.white)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.white)),
              const SizedBox(width: 40), // Space for FAB
              IconButton(onPressed: () {}, icon: const Icon(Icons.notifications, color: Colors.white)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.person, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}

/// A Glassmorphic Floating Action Button
class GlassFAB extends StatelessWidget {
  final LayerBackdrop backdrop;
  const GlassFAB({super.key, required this.backdrop});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: DrawBackdrop(
        backdrop: backdrop,
        shape: () => const CircleBorder(),
        effects: (scope) {
          scope.blur(radius: 10);
          scope.lens(refractionHeight: 10, refractionAmount: 0.2);
        },
        highlight: () => Highlight.defaults,
        shadow: () => Shadow.defaults,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.white.withValues(alpha: 0.1),
          elevation: 0,
          child: const Icon(Icons.add, color: Colors.white, size: 32),
        ),
      ),
    );
  }
}

/// Background decorations
class BackgroundContent extends StatelessWidget {
  const BackgroundContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 100,
            left: -50,
            child: _Circle(color: Colors.blue.withValues(alpha: 0.3), size: 200),
          ),
          Positioned(
            bottom: 200,
            right: -30,
            child: _Circle(color: Colors.pink.withValues(alpha: 0.2), size: 250),
          ),
          Positioned(
            top: 400,
            left: 150,
            child: _Circle(color: Colors.orange.withValues(alpha: 0.15), size: 180),
          ),
        ],
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  final Color color;
  final double size;
  const _Circle({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class GlassCard extends StatelessWidget {
  final int index;
  final LayerBackdrop backdrop;
  const GlassCard({super.key, required this.index, required this.backdrop});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 100,
      child: DrawBackdrop(
        backdrop: backdrop,
        shape: () => RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        effects: (scope) => scope.blur(radius: 10),
        highlight: () => Highlight.defaults,
        child: Center(
          child: ListTile(
            leading: CircleAvatar(backgroundColor: Colors.white24, child: Text("${index + 1}")),
            title: Text("Item ${index + 1}", style: const TextStyle(color: Colors.white)),
            subtitle: const Text("Refracted Background", style: TextStyle(color: Colors.white70)),
            trailing: const Icon(Icons.chevron_right, color: Colors.white54),
          ),
        ),
      ),
    );
  }
}
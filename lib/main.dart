import 'package:flutter/material.dart';
import 'package:backdrop/DrawBackdropModifier.dart'; // package:backdrop ব্যবহার করুন
import 'package:backdrop/backdrops/LayerBackdrop.dart';
import 'package:backdrop/backdrops/LayerBackdropModifier.dart';
import 'package:backdrop/effects/Blur.dart';
import 'package:backdrop/effects/Lens.dart';
import 'package:backdrop/highlight/Highlight.dart';
import 'package:backdrop/shadow/Shadow.dart';


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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: GlassAppBar(backdrop: _globalBackdrop),
      ),
      body: Stack(
        children: [
          // Background Image from Picsum
          LayerBackdropModifier(
            backdrop: _globalBackdrop,
            child: SizedBox.expand(
              child: Image.network(
                'https://picsum.photos/1200/800',
                fit: BoxFit.cover,
              ),
            ),
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
      floatingActionButton: GlassFAB(backdrop: _globalBackdrop),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: GlassBottomNav(backdrop: _globalBackdrop),
    );
  }
}

class GlassAppBar extends StatelessWidget {
  final LayerBackdrop backdrop;
  const GlassAppBar({super.key, required this.backdrop});

  @override
  Widget build(BuildContext context) {
    return DrawBackdrop(
      backdrop: backdrop,
      shape: () => const RoundedRectangleBorder(),
      effects: (scope) => scope.blur(radius: 10),
      highlight: () => Highlight.plain, // Use plain highlight for better visibility
      child: AppBar(
        title: const Text("Aero UI", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.settings))],
      ),
    );
  }
}

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
        effects: (scope) => scope.blur(radius: 15),
        highlight: () => Highlight.plain,
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.home, color: Colors.white)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.white)),
              const SizedBox(width: 40),
              IconButton(onPressed: () {}, icon: const Icon(Icons.notifications, color: Colors.white)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.person, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}

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
          scope.blur(radius: 5);
          scope.lens(refractionHeight: 10, refractionAmount: 0.1);
        },
        highlight: () => Highlight.defaults,
        shadow: () => Shadow.defaults,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.white.withValues(alpha: 0.2),
          elevation: 0,
          child: const Icon(Icons.add, color: Colors.white, size: 32),
        ),
      ),
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
        effects: (scope) => scope.blur(radius: 8),
        highlight: () => Highlight.defaults,
        child: Center(
          child: ListTile(
            leading: CircleAvatar(backgroundColor: Colors.white24, child: Text("${index + 1}", style: const TextStyle(color: Colors.white))),
            title: Text("Item ${index + 1}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: const Text("Glassmorphic Card", style: TextStyle(color: Colors.white70)),
            trailing: const Icon(Icons.chevron_right, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

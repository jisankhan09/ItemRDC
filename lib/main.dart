import 'package:flutter/material.dart';
<<<<<<< HEAD
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
=======

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
>>>>>>> b33448e (Build Web)
    );
  }
}

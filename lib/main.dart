import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as p;

import 'package:flutter_ide/code_forge.dart';
import 'package:flutter_ide/finder.dart';

import 'package:re_highlight/languages/dart.dart';
import 'package:re_highlight/styles/atom-one-dark-reasonable.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final undoController = UndoRedoController();
  CodeForgeController? codeController;
  late final String absFilePath;

  @override
  void initState() {
    super.initState();

    /// Current working directory
    final baseDir = Directory.current.path;
    debugPrint("📂 Current dir: $baseDir");

    absFilePath = p.join(baseDir, "example_code.dart");

    final file = File(absFilePath);
    if (!file.existsSync()) {
      debugPrint("📄 Creating example_code.dart");
      file.writeAsStringSync(
        "// Debug example file\n\nvoid main() {\n  print('Hello Flutter IDE');\n}\n",
      );
    } else {
      debugPrint("📄 File exists");
    }
  }

  /// LSP init
  Future<LspConfig?> getLsp(BuildContext context) async {
    try {
      debugPrint("🚀 Starting Dart LSP...");
      final data = await LspStdioConfig.start(
        executable: "dart",
        args: ["language-server", "--protocol=lsp"],
        workspacePath: Directory.current.path,
        languageId: "dart",
      );
      debugPrint("✅ LSP started");

      // Snackbar for success
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("✅ LSP started successfully"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      });

      return data;
    } catch (e) {
      debugPrint("❌ LSP FAILED: $e");

      // Snackbar for error
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("❌ LSP failed: $e"),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      });

      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.edit),
          onPressed: () {
            codeController?.setGitDiffDecorations(
              addedRanges: [(1, 5), (10, 20)],
              removedRanges: [(25, 30)],
            );
          },
        ),
        body: SafeArea(
          child: Builder(builder: (context) {
            // Builder needed for ScaffoldMessenger
            return FutureBuilder<LspConfig?>(
              future: getLsp(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // LSP fail or succeed doesn't block editor
                codeController ??= CodeForgeController(
                  lspConfig: snapshot.data,
                );

                return Focus(
                  autofocus: true,
                  child: CodeForge(
                    controller: codeController,
                    undoController: undoController,
                    filePath: absFilePath,
                    language: langDart,
                    editorTheme: atomOneDarkReasonableTheme,
                    textStyle: GoogleFonts.jetBrainsMono(fontSize: 14),
                    finderBuilder: (c, controller) =>
                        FindPanelView(controller: controller),
                    matchHighlightStyle: const MatchHighlightStyle(
                      currentMatchStyle: TextStyle(
                        backgroundColor: Color(0xFFFFA726),
                      ),
                      otherMatchStyle: TextStyle(
                        backgroundColor: Color(0x55FFFF00),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}

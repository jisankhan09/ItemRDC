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

    /// Windows debug path check
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
  Future<LspConfig?> getLsp() async {
    try {
      debugPrint("🚀 Starting Dart LSP...");

      final data = await LspStdioConfig.start(
        executable: "dart",
        args: ["language-server", "--protocol=lsp"],
        workspacePath: Directory.current.path,
        languageId: "dart",
      );

      debugPrint("✅ LSP started");
      return data;
    } catch (e, st) {
      debugPrint("❌ LSP FAILED: $e");
      debugPrint(st.toString());
      return null;
    }
  }

  /// Snackbar helper
  void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
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
          child: FutureBuilder<LspConfig?>(
            future: getLsp(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                // LSP init error
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showSnackBar(context, "LSP Error: ${snapshot.error}", isError: true);
                });
                return const Center(child: Text("Error loading LSP"));
              }

              codeController ??= CodeForgeController(
                lspConfig: snapshot.data,
                readOnly: false, // typing enable
              );

              // 🔹 Listen to diagnostics/errors
              codeController!.onDiagnosticsChanged.listen((diagnostics) {
                for (final diag in diagnostics) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showSnackBar(context, "${diag.severity}: ${diag.message}",
                        isError: diag.severity == DiagnosticSeverity.error);
                  });
                }
              });

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
          ),
        ),
      ),
    );
  }
}

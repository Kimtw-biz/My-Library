import 'package:example/widgets/example_auto_layout.dart';
import 'package:example/widgets/example_scroll_progress_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text("My Library Examples"),
          ),
          body: SafeArea(
            minimum: const EdgeInsets.all(32.0),
            child: ListView(
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ExampleAutoLayout(),
                    ),
                  ),
                  child: const Text("Auto Layout"),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ExampleScrollProgressBar(),
                    ),
                  ),
                  child: const Text("Scroll Progress Bar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_my_library/stable/widgets/auto_layout.dart';

class ExampleAutoLayout extends StatelessWidget {
  const ExampleAutoLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              scrollDirection: Axis.horizontal,
              child: AutoLayout.horizontal(
                mainAxisGap: 32.0,
                children: List.filled(
                  50,
                  Placeholder(
                    fallbackWidth: MediaQuery.sizeOf(context).height * 0.1,
                    fallbackHeight: MediaQuery.sizeOf(context).height * 0.1,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32.0),
                scrollDirection: Axis.vertical,
                child: AutoLayout.vertical(
                  mainAxisGap: 32.0,
                  children: List.filled(
                    50,
                    Placeholder(
                      fallbackWidth: MediaQuery.sizeOf(context).width,
                      fallbackHeight: MediaQuery.sizeOf(context).width * 0.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

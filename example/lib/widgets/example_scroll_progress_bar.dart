import 'package:flutter/material.dart';
import 'package:flutter_my_library/flutter_my_library.dart';

class ExampleScrollProgressBar extends StatefulWidget {
  const ExampleScrollProgressBar({super.key});

  @override
  State<ExampleScrollProgressBar> createState() =>
      _ExampleScrollProgressBarState();
}

class _ExampleScrollProgressBarState extends State<ExampleScrollProgressBar> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            ScrollProgressBar(
              controller: controller,
              direction: Axis.horizontal,
              thickness: 8.0,
            ),
            SizedBox.fromSize(size: const Size.fromHeight(8.0)),
            Expanded(
              child: Row(
                children: [
                  ScrollProgressBar(
                    controller: controller,
                    direction: Axis.vertical,
                    thickness: 8.0,
                  ),
                  SizedBox.fromSize(size: const Size.fromWidth(8.0)),
                  Flexible(
                    child: SingleChildScrollView(
                      controller: controller,
                      child: Column(
                        children: List.filled(
                          20,
                          Placeholder(
                            fallbackWidth: MediaQuery.sizeOf(context).width,
                            fallbackHeight:
                                MediaQuery.sizeOf(context).width * 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }
}

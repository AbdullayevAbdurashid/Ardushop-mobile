import 'package:flutter/material.dart';

import 'package:gutenberg_blocks/gutenberg_blocks.dart';

class ExampleHowTo extends StatelessWidget {
  const ExampleHowTo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example How to'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            HowTo(
              title: const Text(
                'bbb',
                style: TextStyle(fontSize: 22),
              ),
              minHeightTitle: 30,
              description: const Text('description'),
              countStep: 3,
              buildItemStep: (int index) {
                return const StepItem(
                  visit: Text('visit'),
                  title: Text('title'),
                  content: Text('Content'),
                );
              },
              borderColor: Colors.red,
            ),
            const SizedBox(height: 50),
            HowTo(
              title: const Text(
                'bbb',
                style: TextStyle(fontSize: 22),
              ),
              minHeightTitle: 30,
              countStep: 3,
              buildItemStep: (int index) {
                return Text('Step ${index + 1}');
              },
              borderColor: Colors.red,
            ),
            const SizedBox(height: 50),
            const HowTo(
              description: Text('description'),
              borderColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

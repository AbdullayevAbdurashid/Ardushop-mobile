import 'package:flutter/material.dart';

import 'package:gutenberg_blocks/gutenberg_blocks.dart';

class ExampleColorHeading extends StatelessWidget {
  const ExampleColorHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Color Heading'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: const [
            ColorHeading(
              title: Text('Title'),
              subtitle: Text('subtitle'),
              background: Colors.deepOrangeAccent,
              padding: EdgeInsets.all(16),
            ),
            SizedBox(height: 16),
            ColorHeading(
              title: Text('Title'),
              background: Colors.deepOrangeAccent,
            ),
          ],
        ),
      ),
    );
  }
}

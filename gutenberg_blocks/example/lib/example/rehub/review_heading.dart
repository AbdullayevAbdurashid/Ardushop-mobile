import 'package:flutter/material.dart';

import 'package:gutenberg_blocks/gutenberg_blocks.dart';

class ExampleReviewHeading extends StatelessWidget {
  const ExampleReviewHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Review heading'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: const [
            ReviewHeading(
              title: Text('title'),
              subtitle: Text('subtitle'),
              positionNumber: Text('01.'),
              image: Text('image'),
            ),
          ],
        ),
      ),
    );
  }
}

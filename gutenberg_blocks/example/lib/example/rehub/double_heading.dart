import 'package:flutter/material.dart';

import 'package:gutenberg_blocks/gutenberg_blocks.dart';

class ExampleDoubleHeading extends StatelessWidget {
  const ExampleDoubleHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget title = Text('Title', style: Theme.of(context).textTheme.headline4);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Double heading'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            DoubleHeading(
              title: title,
            ),
            const SizedBox(height: 16),
            DoubleHeading(
              title: title,
              backgroundText: Text(
                '01.',
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(color: const Color(0xFFf0f0f0), fontWeight: FontWeight.w700),
              ),
              minHeight: 130,
            ),
          ],
        ),
      ),
    );
  }
}

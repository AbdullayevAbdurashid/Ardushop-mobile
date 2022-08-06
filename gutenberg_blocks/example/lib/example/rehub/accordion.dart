import 'package:flutter/material.dart';

import 'package:gutenberg_blocks/gutenberg_blocks.dart';

class ExampleAccordion extends StatelessWidget {
  const ExampleAccordion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Accordion'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Accordion(
              count: 3,
              buildTitle: (int index) {
                return Text('title', style: Theme.of(context).textTheme.subtitle1);
              },
              buildExpansion: (int index) {
                return const Text('Expansion');
              },
              dividerColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:gutenberg_blocks/gutenberg_blocks.dart';

class ExampleVersusTable extends StatelessWidget {
  const ExampleVersusTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Versus Table'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            VersusTable(
              title: const Text('title'),
              subtitle: const Text('subtitle'),
              buildItem: (int index, double maxWidth, TextAlign textAlign) {
                return Text('$index');
              },
              separator: const Text('vs'),
            ),
            const SizedBox(height: 50),
            VersusTable(
              title: const Text('title'),
              subtitle: const Text('subtitle'),
              buildItem: (int index, double maxWidth, TextAlign textAlign) {
                return Text('${index + 1}');
              },
              separator: const Text('vs'),
              column: 3,
            )
          ],
        ),
      ),
    );
  }
}

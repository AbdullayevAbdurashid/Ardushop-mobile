import 'package:flutter/material.dart';

import 'package:gutenberg_blocks/gutenberg_blocks.dart';

class ExampleConsPros extends StatelessWidget {
  const ExampleConsPros({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Cons pros'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            ConsPros(
              positive: const Text('positive'),
              negative: ViewIconPros(
                icon: Icons.check,
                title: const Text('negative'),
                items: const ['a', 'e'],
                colorIcon: Colors.green,
                styleItem: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

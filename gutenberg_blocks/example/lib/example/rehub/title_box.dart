import 'package:flutter/material.dart';

import 'package:gutenberg_blocks/gutenberg_blocks.dart';

class ExampleTitleBox extends StatelessWidget {
  const ExampleTitleBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Title Box'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const TitleBox(
              title: Text('Title'),
              borderColor: Colors.red,
            ),
            const SizedBox(height: 16),
            TitleBox(
              title: const Text('Title'),
              borderColor: Colors.red,
              heading: Text('heading', style: Theme.of(context).textTheme.headline5),
            ),
            const SizedBox(height: 16),
            const TitleBox(
              title: Text('Title'),
              borderColor: Colors.red,
              doubleBorder: true,
            ),
            const SizedBox(height: 16),
            TitleBox(
              title: const Text('Title'),
              borderColor: Colors.red,
              doubleBorder: true,
              heading: Text(
                'heading',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

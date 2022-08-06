import 'package:flutter/material.dart';

import 'package:gutenberg_blocks/gutenberg_blocks.dart';

class ExamplePostOfferBox extends StatelessWidget {
  const ExamplePostOfferBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Offer box'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: const [
            PostOfferBox(
              image: Text('image'),
              title: Text('title'),
              rating: Text('rating'),
              button: Text('button'),
            ),
            SizedBox(height: 60),
            PostOfferBox(
              image: Text('image'),
              title: Text('title'),
              button: Text('button'),
            ),
          ],
        ),
      ),
    );
  }
}

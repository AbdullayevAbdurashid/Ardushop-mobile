import 'package:flutter/material.dart';

import 'package:gutenberg_blocks/gutenberg_blocks.dart';

class ExamplePromoBox extends StatelessWidget {
  const ExamplePromoBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Promo box'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: const [
            PromoBox(
              title: Text('title'),
              subtitle: Text('subtitle'),
              button: Text('button'),
              background: Colors.yellow,
            ),
            SizedBox(height: 20),
            PromoBox(
              title: Text('title border'),
              subtitle: Text('subtitle'),
              button: Text('button'),
              // background: Colors.yellow,
              enableBorder: true,
              borderColor: Colors.red,
            ),
            SizedBox(height: 20),
            PromoBox(
              title: Text('title highlight'),
              subtitle: Text('subtitle'),
              button: Text('button'),
              // background: Colors.yellow,
              enableHighlightBorder: true,
              highlightBorderColor: Colors.red,
            ),
            SizedBox(height: 20),
            PromoBox(
              title: Text('title border & highlight'),
              subtitle: Text('subtitle'),
              button: Text('button'),
              enableBorder: true,
              enableHighlightBorder: true,
              highlightBorderColor: Colors.red,
              borderColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}

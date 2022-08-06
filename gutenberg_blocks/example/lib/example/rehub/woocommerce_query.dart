import 'package:flutter/material.dart';

import 'package:gutenberg_blocks/gutenberg_blocks.dart';

class ExampleWoocommerceQuery extends StatelessWidget {
  const ExampleWoocommerceQuery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Woocommerce query'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: const [
            WoocommerceQueryItem(
              image: Text('image'),
              name: Text('name'),
              category: Text('category'),
              rating: Text('rating'),
              price: Text('price'),
              button: Text('button'),
              color: Colors.white,
            ),
            SizedBox(height: 50),
            WoocommerceQueryItem(
              image: Text('image'),
              name: Text('name'),
              category: Text('category'),
              rating: Text('rating'),
              price: Text('price'),
              button: Text('button'),
              color: Colors.white,
              width: 300,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:gutenberg_blocks/gutenberg_blocks.dart';

class ExampleWoocommerceBox extends StatelessWidget {
  const ExampleWoocommerceBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Woocommerce box'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const WoocommerceBoxProductItem(
              image: Text('image'),
              name: Text('name'),
              price: Text('price'),
              rating: Text('rating'),
              description: Text('desciption'),
              button: Text('button'),
              band: Text('band'),
              color: Color(0xFFf4f4f4),
            ),
            const SizedBox(height: 50),
            WoocommerceBoxFiction(
              title: 'OS :',
              content: 'XBOX one, XBOX one X',
              styleTitle: theme.textTheme.subtitle1 ?? const TextStyle(),
              styleContent: theme.textTheme.bodyText1 ?? const TextStyle(),
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}

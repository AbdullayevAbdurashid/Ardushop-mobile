import 'package:flutter/material.dart';

import 'package:gutenberg_blocks/gutenberg_blocks.dart';

class ExampleOfferListing extends StatelessWidget {
  const ExampleOfferListing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Offer Listing'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            OfferListingItem(
              image: const Text('image'),
              name: const Text('name'),
              price: const Text('price'),
              badge: const Text('badge'),
              description: const Text('description'),
              button: const Text('button'),
              disclaimer: Container(
                color: Colors.green,
                child: const Text('disclaimer'),
              ),
              color: Colors.white,
              disclaimerColor: Colors.pink,
            ),
            const SizedBox(height: 50),
            OfferListingItem(
              image: const Text('image'),
              name: const Text('name'),
              description: const Text('description'),
              button: const Text('button'),
              disclaimer: Container(
                color: Colors.green,
                child: const Text('disclaimer'),
              ),
              width: 300,
              color: Colors.white,
              disclaimerColor: Colors.pink,
            ),
          ],
        ),
      ),
    );
  }
}

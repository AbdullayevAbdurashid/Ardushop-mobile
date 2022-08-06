import 'package:flutter/material.dart';

import 'package:gutenberg_blocks/gutenberg_blocks.dart';

class ExamplePostOfferListing extends StatelessWidget {
  const ExamplePostOfferListing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Post Offer Listing'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: const [
            PostOfferListingItem(
              image: Text('image'),
              name: Text('name'),
              color: Colors.white,
            ),
            SizedBox(height: 50),
            PostOfferListingItem(
              image: Text('image'),
              name: Text('name'),
              description: Text('desciption'),
              color: Colors.white,
            ),
            SizedBox(height: 50),
            PostOfferListingItem(
              image: Text('image'),
              name: Text('name'),
              description: Text('desciption'),
              width: 300,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

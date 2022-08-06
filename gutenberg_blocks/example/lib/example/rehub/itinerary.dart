import 'package:flutter/material.dart';

import 'package:gutenberg_blocks/gutenberg_blocks.dart';

class ExampleItinerary extends StatelessWidget {
  const ExampleItinerary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Itinerary'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: const [
            ItineraryItem(
              colorBoxIcon: Colors.blue,
              icon: Icon(Icons.description, size: 16, color: Colors.white),
              title: Text('title'),
            ),
          ],
        ),
      ),
    );
  }
}

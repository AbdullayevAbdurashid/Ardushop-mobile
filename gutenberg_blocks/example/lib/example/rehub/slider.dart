import 'package:flutter/material.dart';

class ExampleSlider extends StatelessWidget {
  const ExampleSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Slider'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Text('no ui'),
      ),
    );
  }
}

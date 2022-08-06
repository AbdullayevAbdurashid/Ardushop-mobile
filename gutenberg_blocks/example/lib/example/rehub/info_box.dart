import 'package:flutter/material.dart';

import 'package:gutenberg_blocks/gutenberg_blocks.dart';

Widget _getTitle(TextAlign? textAlign) {
  return Text(
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s',
    textAlign: textAlign ?? TextAlign.start,
  );
}

class ExampleInfoBox extends StatelessWidget {
  const ExampleInfoBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = const Color(0xFFF0FFDE);
    Widget icon = const Icon(Icons.link, size: 22, color: Color(0xFF21BA45));

    Widget date = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(color: const Color(0xFF5BC0DE), borderRadius: BorderRadius.circular(29)),
      child: const Text('Date : 24/6/2021', style: TextStyle(color: Colors.white)),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Example Info Box')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            InfoBox(
              icon: icon,
              background: color,
              title: _getTitle(TextAlign.start),
              date: date,
            ),
            const SizedBox(height: 16),
            InfoBox(
              icon: icon,
              background: color,
              title: _getTitle(TextAlign.center),
              date: date,
              align: InfoBoxAlign.center,
            ),
            const SizedBox(height: 16),
            InfoBox(
              icon: icon,
              background: color,
              title: _getTitle(TextAlign.end),
              date: date,
              align: InfoBoxAlign.right,
            ),
            const SizedBox(height: 16),
            InfoBox(
              icon: icon,
              background: color,
              title: _getTitle(TextAlign.justify),
              date: date,
              align: InfoBoxAlign.justify,
            ),
            const SizedBox(height: 16),
            InfoBox(
              icon: icon,
              background: color,
              title: _getTitle(TextAlign.start),
            ),
            const SizedBox(height: 16),
            InfoBox(
              icon: icon,
              background: color,
              title: _getTitle(TextAlign.center),
              align: InfoBoxAlign.center,
            ),
            const SizedBox(height: 16),
            InfoBox(
              icon: icon,
              background: color,
              title: _getTitle(TextAlign.end),
              align: InfoBoxAlign.right,
            ),
            const SizedBox(height: 16),
            InfoBox(
              icon: icon,
              background: color,
              title: _getTitle(TextAlign.justify),
              align: InfoBoxAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}

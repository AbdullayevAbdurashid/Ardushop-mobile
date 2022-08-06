import 'package:flutter/material.dart';

import 'package:gutenberg_blocks/gutenberg_blocks.dart';

class ExampleComparisonTable extends StatelessWidget {
  const ExampleComparisonTable({Key? key}) : super(key: key);

  Widget buildItem({
    required String title,
    Color? color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      alignment: Alignment.center,
      color: color,
      child: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example comparison table'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const ComparisonTableItem(
              badge: Text('badge'),
              image: Text('image'),
              title: Text('title'),
              subtitle: Text('subtitle'),
              star: Text('star'),
              list: Text('list'),
              button: Text('button'),
            ),
            const SizedBox(height: 50),
            Table(
              border: TableBorder.all(),
              children: [
                const TableRow(
                  children: [
                    ComparisonTableItem(
                      badge: Text('badge'),
                      image: Text('image'),
                      title: Text('title'),
                      subtitle: Text('subtitle'),
                      star: Text('star'),
                      list: Text('list'),
                      button: Text('button'),
                    )
                  ],
                ),
                TableRow(
                  children: [
                    buildItem(title: 'Bottom line text', color: const Color(0xFFf4f4f4)),
                  ],
                ),
                TableRow(
                  children: [
                    buildItem(title: 'Text of bottom line'),
                  ],
                ),
                TableRow(
                  children: [
                    buildItem(title: 'Cons Text', color: const Color(0xFFf4f4f4)),
                  ],
                ),
                TableRow(
                  children: [
                    buildItem(title: 'Text of cons text'),
                  ],
                ),
                TableRow(
                  children: [
                    buildItem(title: 'Spec Text', color: const Color(0xFFf4f4f4)),
                  ],
                ),
                TableRow(
                  children: [
                    buildItem(title: 'Text of spec Text'),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

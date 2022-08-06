import 'package:flutter/material.dart';

class VersusTable extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final int column;
  final Widget Function(int index, double maxWidth, TextAlign textAlign) buildItem;
  final Widget separator;
  final Color? color;
  final EdgeInsetsGeometry padding;
  final double? spacing;

  const VersusTable({
    Key? key,
    this.title,
    this.subtitle,
    this.column = 2,
    required this.buildItem,
    required this.separator,
    this.color,
    this.padding = const EdgeInsets.all(16),
    this.spacing,
  })  : assert(column == 2 || column == 3),
        super(key: key);

  List<Widget> buildTable() {
    List<Widget> data = [];
    for (var i = 0; i < column; i++) {
      if (i == 0) {
        data.add(Expanded(
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: buildItemTable(i),
          ),
        ));
      } else if (i == column - 1) {
        data.add(
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: buildItemTable(i),
            ),
          ),
        );
      } else {
        data.add(
          Flexible(
            child: buildItemTable(i),
          ),
        );
      }
      if (i < column - 1) {
        data.add(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spacing ?? 24),
            child: separator,
          ),
        );
      }
    }
    return data;
  }

  Widget buildItemTable(int index) {
    TextAlign textAlign = index > 0 && index < column - 1 ? TextAlign.center : TextAlign.start;
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        double maxWidth = constraints.maxWidth;
        return buildItem(index, maxWidth, textAlign);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      color: color,
      child: Column(
        children: [
          title ?? Container(),
          if (subtitle is Widget) ...[
            if (title is Widget) const SizedBox(height: 8),
            subtitle ?? Container(),
          ],
          if (title is Widget || subtitle is Widget) const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buildTable(),
          )
        ],
      ),
    );
  }
}

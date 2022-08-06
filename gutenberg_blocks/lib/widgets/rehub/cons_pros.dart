import 'package:flutter/material.dart';

class ConsPros extends StatelessWidget {
  final Widget? positive;
  final Widget? negative;

  const ConsPros({
    Key? key,
    this.positive,
    this.negative,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (positive is Widget) ...[
          positive ?? Container(),
        ],
        if (negative is Widget) ...[
          const SizedBox(height: 24),
          negative ?? Container(),
        ],
      ],
    );
  }
}

class ViewIconPros extends StatelessWidget {
  final Widget? title;
  final IconData icon;
  final Color? colorIcon;
  final List<String> items;
  final TextStyle? styleItem;

  const ViewIconPros({
    Key? key,
    this.title,
    required this.items,
    this.icon = Icons.check,
    this.colorIcon,
    this.styleItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title is Widget) ...[
          title ?? Container(),
          const SizedBox(height: 24),
        ],
        ...List.generate(items.length, (index) {
          String text = items.elementAt(index);
          double pad = index < items.length - 1 ? 8 : 0;
          return Padding(
            padding: EdgeInsets.only(bottom: pad),
            child: Row(
              children: [
                Icon(icon, size: 16, color: colorIcon),
                const SizedBox(width: 10),
                Expanded(child: Text(text, style: styleItem))
              ],
            ),
          );
        })
      ],
    );
  }
}

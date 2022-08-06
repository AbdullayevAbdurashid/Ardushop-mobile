import 'package:flutter/material.dart';

class PrettyListItem extends StatelessWidget {
  final Widget title;
  final double pad;
  final Icon icon;

  const PrettyListItem({
    Key? key,
    required this.title,
    this.pad = 16,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(width: pad),
        Expanded(child: title),
      ],
    );
  }
}

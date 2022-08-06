import 'package:flutter/material.dart';

class ColorHeading extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final Color background;
  final EdgeInsetsGeometry padding;

  const ColorHeading({
    Key? key,
    this.title,
    this.subtitle,
    required this.background,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      color: background,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          subtitle ?? Container(),
          title ?? Container(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DoubleHeading extends StatelessWidget {
  final Widget? backgroundText;
  final Widget title;
  final EdgeInsetsGeometry padding;
  final double minHeight;

  const DoubleHeading({
    Key? key,
    this.backgroundText,
    required this.title,
    this.padding = const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
    this.minHeight = 72,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PositionedDirectional(child: buildBox(child: backgroundText ?? Container())),
        buildBox(
          child: Padding(
            padding: padding,
            child: title,
          ),
        )
      ],
    );
  }

  Widget buildBox({Widget? child}) {
    return Container(
      constraints: BoxConstraints(minHeight: minHeight),
      alignment: AlignmentDirectional.center,
      child: SizedBox(width: double.infinity, child: child),
    );
  }
}

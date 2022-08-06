import 'package:flutter/material.dart';

class ItineraryItem extends StatelessWidget {
  final Icon? icon;
  final double? sizeBoxIcon;
  final Color colorBoxIcon;
  final Widget title;
  final double? pad;
  final EdgeInsetsGeometry? paddingTitle;

  const ItineraryItem({
    Key? key,
    this.icon,
    this.sizeBoxIcon,
    required this.colorBoxIcon,
    required this.title,
    this.pad,
    this.paddingTitle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: sizeBoxIcon ?? 40,
          height: sizeBoxIcon ?? 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colorBoxIcon,
            shape: BoxShape.circle,
          ),
          child: icon,
        ),
        SizedBox(width: pad ?? 16),
        Expanded(
          child: Container(
            padding: paddingTitle ?? const EdgeInsets.symmetric(vertical: 5),
            constraints: BoxConstraints(minHeight: sizeBoxIcon ?? 40),
            alignment: AlignmentDirectional.centerStart,
            child: title,
          ),
        ),
      ],
    );
  }
}

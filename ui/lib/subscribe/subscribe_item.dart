import 'package:flutter/material.dart';

class SubscribeItem extends StatelessWidget {
  final Widget? icon;
  final Widget? title;
  final Widget? content;
  final Widget? textField;
  final Widget? elevatedButton;
  const SubscribeItem({
    Key? key,
    this.icon,
    this.title,
    this.content,
    this.textField,
    this.elevatedButton,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = 8;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon ?? Container(),
        SizedBox(
          height: height,
        ),
        title ?? Container(),
        SizedBox(
          height: height,
        ),
        content ?? Container(),
        SizedBox(
          height: height * 2,
        ),
        textField ?? Container(),
        SizedBox(
          height: height * 2,
        ),
        SizedBox(
          height: 48,
          width: double.infinity,
          child: elevatedButton ?? Container(),
        )
      ],
    );
  }
}

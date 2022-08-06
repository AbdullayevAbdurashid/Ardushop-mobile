import 'package:flutter/material.dart';

enum InfoBoxAlign { left, right, center, justify }

class InfoBox extends StatelessWidget {
  final Widget? icon;
  final Widget? title;
  final Widget? date;
  final Color background;
  final EdgeInsetsGeometry padding;
  final InfoBoxAlign align;

  const InfoBox({
    Key? key,
    this.icon,
    this.title,
    this.date,
    required this.background,
    this.padding = const EdgeInsets.all(16),
    this.align = InfoBoxAlign.left,
  }) : super(key: key);

  MainAxisAlignment getAxisHeading(InfoBoxAlign value) {
    switch (value) {
      case InfoBoxAlign.center:
        return MainAxisAlignment.center;
      case InfoBoxAlign.right:
        return MainAxisAlignment.end;
      default:
        return MainAxisAlignment.start;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = date is Widget
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (icon is Widget || date is Widget) ...[
                Row(
                  mainAxisAlignment: getAxisHeading(align),
                  children: [
                    if (align != InfoBoxAlign.right && icon is Widget) ...[
                      icon ?? Container(),
                      const SizedBox(width: 16),
                    ],
                    date ?? Container(),
                    if (align == InfoBoxAlign.right && icon is Widget) ...[
                      const SizedBox(width: 16),
                      icon ?? Container(),
                    ],
                  ],
                ),
                if (title is Widget) const SizedBox(height: 8),
              ],
              SizedBox(
                width: double.infinity,
                child: title,
              )
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (align != InfoBoxAlign.right && icon is Widget) ...[
                icon ?? Container(),
                const SizedBox(width: 16),
              ],
              Expanded(child: title ?? Container()),
              if (align == InfoBoxAlign.right && icon is Widget) ...[
                const SizedBox(width: 16),
                icon ?? Container(),
              ],
            ],
          );
    return Container(
      color: background,
      padding: padding,
      child: child,
    );
  }
}

import 'package:flutter/material.dart';

class ComparisonTableItem extends StatelessWidget {
  final Widget? badge;
  final Widget? image;
  final Widget? title;
  final Widget? subtitle;
  final Widget? star;
  final Widget? list;
  final Widget? button;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const ComparisonTableItem({
    Key? key,
    this.badge,
    this.image,
    this.title,
    this.subtitle,
    this.star,
    this.list,
    this.button,
    this.width,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: Column(
        children: [
          badge ?? Container(),
          Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: Column(
              children: [
                image ?? Container(),
                if (title is Widget || subtitle is Widget) ...[
                  if (image is Widget) const SizedBox(height: 10),
                  title ?? Container(),
                  subtitle ?? Container(),
                ],
                if (star is Widget) ...[
                  if (image is Widget || title is Widget || subtitle is Widget) const SizedBox(height: 10),
                  star ?? Container(),
                ],
                if (list is Widget) ...[
                  if (image is Widget || title is Widget || subtitle is Widget || star is Widget)
                    const SizedBox(height: 10),
                  list ?? Container(),
                ],
                if (button is Widget) ...[
                  if (image is Widget || title is Widget || subtitle is Widget || star is Widget || list is Widget)
                    const SizedBox(height: 10),
                  button ?? Container(),
                ],
              ],
            ),
          )
        ],
      ),
    );
  }
}

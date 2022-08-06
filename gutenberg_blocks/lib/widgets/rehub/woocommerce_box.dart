import 'package:flutter/material.dart';

class WoocommerceBoxProductItem extends StatelessWidget {
  final Widget image;
  final Widget name;
  final Widget price;
  final Widget? rating;
  final Widget description;
  final Widget button;
  final Widget? band;
  final double? width;
  final Color color;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const WoocommerceBoxProductItem({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    this.rating,
    required this.description,
    required this.button,
    this.band,
    this.width,
    required this.color,
    this.borderRadius,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(color: color, borderRadius: borderRadius ?? BorderRadius.circular(8)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              image,
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    name,
                    const SizedBox(height: 8),
                    price,
                    if (rating is Widget) ...[
                      const SizedBox(height: 8),
                      rating ?? Container(),
                    ]
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          description,
          const SizedBox(height: 16),
          button,
          if (band is Widget) ...[
            const SizedBox(height: 16),
            band ?? Container(),
          ]
        ],
      ),
    );
  }
}

class WoocommerceBoxFiction extends StatelessWidget {
  final String title;
  final String content;
  final TextStyle styleTitle;
  final TextStyle styleContent;
  final Color color;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const WoocommerceBoxFiction({
    Key? key,
    required this.title,
    required this.content,
    required this.styleTitle,
    required this.styleContent,
    required this.color,
    this.borderRadius,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(color: color, borderRadius: borderRadius ?? BorderRadius.circular(8)),
      child: RichText(
        text: TextSpan(
          text: '$title ',
          style: styleTitle,
          children: [
            TextSpan(text: content, style: styleContent),
          ],
        ),
      ),
    );
  }
}

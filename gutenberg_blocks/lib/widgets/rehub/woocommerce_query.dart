import 'package:flutter/material.dart';

class WoocommerceQueryItem extends StatelessWidget {
  final Widget image;
  final Widget name;
  final Widget? category;
  final Widget? rating;
  final Widget? price;
  final Widget? button;
  final double? width;
  final Color color;
  final List<BoxShadow>? boxShadow;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const WoocommerceQueryItem({
    Key? key,
    required this.image,
    required this.name,
    this.category,
    this.rating,
    this.price,
    this.button,
    this.width,
    required this.color,
    this.boxShadow,
    this.borderRadius,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        double maxWidth = constraints.maxWidth;
        double widthScreen = MediaQuery.of(context).size.width;
        double widthDefault = maxWidth == double.infinity ? widthScreen : maxWidth;
        double widthItem = width ?? widthDefault;

        return Container(
          width: widthItem,
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius ?? BorderRadius.circular(8),
            boxShadow: boxShadow ??
                [
                  const BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.08),
                    offset: Offset(0, 4),
                    blurRadius: 24,
                    spreadRadius: 0,
                  )
                ],
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              image,
              Padding(
                padding: padding ?? const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    category ?? Container(),
                    if (category is Widget) const SizedBox(height: 8),
                    name,
                    if (rating is Widget) const SizedBox(height: 8),
                    rating ?? Container(),
                    if (price is Widget) const SizedBox(height: 8),
                    price ?? Container(),
                    if (button is Widget) const SizedBox(height: 16),
                    button ?? Container(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

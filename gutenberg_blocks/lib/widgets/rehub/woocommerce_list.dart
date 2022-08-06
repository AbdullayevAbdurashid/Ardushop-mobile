import 'package:flutter/material.dart';

class WoocommerceListItem extends StatelessWidget {
  final Widget image;
  final Widget name;
  final Widget? description;
  final Widget? price;
  final Widget? badge;
  final Widget? button;
  final double? width;
  final Color color;
  final List<BoxShadow>? boxShadow;
  final BorderRadius? borderRadius;

  const WoocommerceListItem({
    Key? key,
    required this.image,
    required this.name,
    this.description,
    this.price,
    this.badge,
    this.button,
    this.width,
    required this.color,
    this.boxShadow,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
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
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                name,
                if (price is Widget || badge is Widget) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: price ?? Container()),
                      const SizedBox(width: 16),
                      badge ?? Container(),
                    ],
                  ),
                ],
                if (description is Widget) ...[
                  const SizedBox(height: 8),
                  description ?? Container(),
                ],
                if (button is Widget) ...[
                  const SizedBox(height: 8),
                  button ?? Container(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

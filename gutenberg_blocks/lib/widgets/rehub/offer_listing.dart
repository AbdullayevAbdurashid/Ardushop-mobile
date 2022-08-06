import 'package:flutter/material.dart';

class OfferListingItem extends StatelessWidget {
  final Widget image;
  final Widget? name;
  final Widget? description;
  final Widget? price;
  final Widget? badge;
  final Widget? button;
  final Widget? disclaimer;
  final double? width;
  final Color color;
  final Color disclaimerColor;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry disclaimerPadding;

  const OfferListingItem({
    Key? key,
    required this.image,
    this.name,
    this.description,
    this.price,
    this.badge,
    this.button,
    this.disclaimer,
    this.width,
    required this.color,
    required this.disclaimerColor,
    this.borderRadius,
    this.boxShadow,
    this.padding = const EdgeInsets.all(16),
    this.disclaimerPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadius radius = borderRadius ?? BorderRadius.circular(8);
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        double maxWidth = constraints.maxWidth;
        double widthScreen = MediaQuery.of(context).size.width;
        double widthDefault = maxWidth == double.infinity ? widthScreen : maxWidth;
        double widthItem = width ?? widthDefault;

        return Container(
          width: widthItem,
          decoration: BoxDecoration(
            color: disclaimerColor,
            borderRadius: radius,
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: padding,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: radius,
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
                    const SizedBox(height: 16),
                    name ?? Container(),
                    if (price is Widget || badge is Widget) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(child: price ?? Container()),
                          if (price is Widget && badge is Widget) const SizedBox(width: 12),
                          badge ?? Container(),
                        ],
                      ),
                    ],
                    if (description is Widget) ...[
                      const SizedBox(height: 8),
                      description ?? const SizedBox(),
                    ],
                    if (button is Widget) ...[
                      const SizedBox(height: 8),
                      button ?? const SizedBox(),
                    ],
                  ],
                ),
              ),
              if (disclaimer is Widget)
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: disclaimerPadding,
                    child: disclaimer ?? Container(),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class OfferBox extends StatelessWidget {
  final Widget? image;
  final Widget? title;
  final Widget? description;
  final Widget? rating;
  final Widget? price;
  final Widget? buttonCoupon;
  final Widget? disclaimer;
  final EdgeInsetsGeometry padding;
  final Color? borderColor;

  const OfferBox({
    Key? key,
    this.image,
    this.title,
    this.description,
    this.rating,
    this.price,
    this.buttonCoupon,
    this.disclaimer,
    this.padding = const EdgeInsets.all(16),
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: borderColor is Color ? padding : null,
      decoration:
          borderColor is Color ? BoxDecoration(border: Border.all(width: 2, color: borderColor ?? Colors.black)) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (image is Widget) image ?? Container(),
          if (title is Widget || price is Widget || rating is Widget || disclaimer is Widget) ...[
            if (image is Widget) const SizedBox(height: 16),
            title ?? Container(),
            if (title is Widget) const SizedBox(height: 8),
            if (price is Widget || rating is Widget)
              Row(
                children: [
                  Expanded(child: price ?? Container()),
                  if (rating is Widget) ...[
                    const SizedBox(width: 16),
                    rating ?? Container(),
                  ]
                ],
              ),
            if (title is Widget || price is Widget || rating is Widget) const SizedBox(height: 8),
            disclaimer ?? Container(),
          ],
          if (buttonCoupon is Widget || description is Widget) ...[
            if (image is Widget) const SizedBox(height: 16),
            buttonCoupon ?? Container(),
            if (buttonCoupon is Widget) const SizedBox(height: 8),
            description ?? Container(),
          ],
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// A post widget display full width on the screen
///
class ProductCurveItem extends StatelessWidget {
  /// Widget image
  final Widget image;

  /// Widget name. It must required
  final Widget name;

  /// Widget price
  final Widget price;

  /// Widget rating
  final Widget? rating;

  /// Widget wishlist
  final Widget? wishlist;

  /// Widget button Add card
  final Widget? addCard;

  /// Widget extra tags in information
  final Widget? tagExtra;

  /// Widget quantity
  final Widget? quantity;

  /// Width item
  final double width;

  /// shadow card
  final List<BoxShadow>? boxShadow;

  /// Border of item post
  final Border? border;

  /// Color Card of item post
  final Color color;

  /// Border of item post
  final BorderRadius borderRadius;

  /// Function click item
  final Function onClick;

  /// Padding content
  final EdgeInsetsGeometry padding;

  /// Create Product Horizontal Item
  const ProductCurveItem({
    Key? key,
    required this.image,
    required this.name,
    required this.onClick,
    required this.price,
    this.rating,
    this.addCard,
    this.tagExtra,
    this.quantity,
    this.width = 300,
    this.wishlist,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.border,
    this.color = Colors.white,
    this.boxShadow,
    this.padding = const EdgeInsets.all(8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color,
                  border: border,
                  borderRadius: borderRadius,
                  boxShadow: boxShadow,
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  borderRadius: borderRadius,
                  onTap: () => onClick(),
                  child: Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            image,
                            Positioned(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(child: tagExtra ?? Container()),
                                    if (wishlist != null) ...[
                                      const SizedBox(width: 12),
                                      wishlist ?? Container(),
                                    ],
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        name,
                        const SizedBox(height: 4),
                        price,
                        if (rating != null) ...[
                          const SizedBox(height: 8),
                          rating ?? Container(),
                        ],
                        if (quantity != null) ...[
                          const SizedBox(height: 12),
                          quantity ?? Container(),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              PositionedDirectional(
                bottom: 0,
                end: 0,
                child: addCard ?? Container(),
              ),
            ],
          )
        ],
      ),
    );
  }
}

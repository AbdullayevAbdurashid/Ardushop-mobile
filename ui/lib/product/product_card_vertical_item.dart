import 'package:flutter/material.dart';
import 'product_item.dart';

/// A post widget display full width on the screen
///
class ProductCardVerticalItem extends ProductItem {
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

  /// Widget category
  final Widget? category;

  /// Widget button Add card
  final Widget? addCard;

  /// Widget extra tags in information
  final Widget? tagExtra;

  /// Widget quantity
  final Widget? quantity;

  /// Width item
  final double? width;

  /// shadow card
  final List<BoxShadow>? boxShadow;

  /// Border of item post
  final Border? border;

  /// Color Card of item post
  final Color? color;

  /// Border of item post
  final BorderRadius? borderRadius;

  /// Function click item
  final Function onClick;

  /// Padding content
  final EdgeInsetsGeometry? padding;

  /// Create Product Contained Item
  const ProductCardVerticalItem({
    Key? key,
    required this.image,
    required this.name,
    required this.onClick,
    required this.price,
    this.rating,
    this.wishlist,
    this.category,
    this.addCard,
    this.tagExtra,
    this.quantity,
    this.width,
    this.boxShadow,
    this.border,
    this.color = Colors.transparent,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.padding,
  }) : super(
          key: key,
          colorProduct: color,
          boxShadowProduct: boxShadow,
          borderProduct: border,
          borderRadiusProduct: borderRadius,
        );

  @override
  Widget buildLayout(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        double maxWidth = constraints.maxWidth;
        double screenWidth = MediaQuery.of(context).size.width;
        double defaultWidth = maxWidth != double.infinity ? maxWidth : screenWidth;
        double widthItem = width ?? defaultWidth;
        return SizedBox(
          width: widthItem,
          child: InkWell(
            onTap: () => onClick(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                image,
                Padding(
                  padding: padding ?? const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (category is Widget) ...[
                        category ?? Container(),
                        const SizedBox(height: 8),
                      ],
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                name,
                                if (rating is Widget) ...[
                                  const SizedBox(height: 8),
                                  rating ?? Container(),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          price,
                        ],
                      ),
                      if (quantity is Widget || addCard is Widget) ...[
                        const SizedBox(height: 24),
                        quantity ?? Container(),
                        if (quantity is Widget && addCard is Widget) const SizedBox(height: 12),
                        addCard ?? Container(),
                      ],
                      if (tagExtra is Widget || wishlist is Widget) ...[
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(child: tagExtra ?? Container()),
                            wishlist ?? Container(),
                          ],
                        )
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

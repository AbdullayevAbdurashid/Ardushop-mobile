import 'package:flutter/material.dart';

import 'product_item.dart';

/// A post widget display full width on the screen
///
class ProductCardHorizontalItem extends ProductItem {
  /// Widget image
  final Widget image;

  /// Widget name. It must required
  final Widget name;

  /// Widget price
  final Widget? price;

  /// Widget category
  final Widget? category;

  /// Widget wishlist
  final Widget? wishlist;

  /// Widget wishlist
  final Widget? tagExtra;

  /// Widget button Add card
  final Widget? addCart;

  /// Widget quantity
  final Widget? quantity;

  /// Width item
  final double? width;

  /// Color item of item product
  final Color? color;

  /// Color item of item product
  final double radiusImage;

  /// Color opacity of item post
  final Color? colorOpacity;

  /// Color opacity of item post
  final double? opacity;

  /// Border of item post
  final BorderRadius? borderRadius;

  /// shadow card
  final List<BoxShadow>? boxShadow;

  /// Border of item post
  final Border? border;

  /// Function click item
  final Function onClick;

  /// Padding item
  final EdgeInsetsGeometry? padding;

  /// Create Product Card Item
  const ProductCardHorizontalItem({
    Key? key,
    required this.image,
    required this.name,
    required this.onClick,
    this.price,
    this.category,
    this.wishlist,
    this.tagExtra,
    this.addCart,
    this.quantity,
    this.width,
    this.color,
    this.colorOpacity,
    this.opacity,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.radiusImage = 0,
    this.padding,
    this.border,
    this.boxShadow,
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
        Color colorFilter = colorOpacity ?? Colors.black;

        return SizedBox(
          width: widthItem,
          child: GestureDetector(
            onTap: () => onClick(),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusImage),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(colorFilter.withOpacity(opacity ?? 0.6), BlendMode.srcOver),
                    child: image,
                  ),
                ),
                PositionedDirectional(
                  start: 0,
                  end: 0,
                  top: 0,
                  bottom: 0,
                  child: Padding(
                    padding: padding ?? const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (category is Widget || tagExtra is Widget) ...[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(child: category ?? Container()),
                                    tagExtra ?? Container(),
                                  ],
                                ),
                                const SizedBox(height: 8),
                              ],
                              name,
                              price ?? Container(),
                              const SizedBox(height: 4),
                              quantity ?? Container(),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: addCart ?? Container(),
                              ),
                            ),
                            const SizedBox(width: 16),
                            wishlist ?? Container(),
                          ],
                        ),
                      ],
                    ),
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

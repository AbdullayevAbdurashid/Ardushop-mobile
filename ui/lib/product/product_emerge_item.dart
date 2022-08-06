import 'package:flutter/material.dart';

import 'product_item.dart';

/// A post widget display full width on the screen
///
class ProductEmergeItem extends ProductItem {
  /// Widget image
  final Widget image;

  /// Widget name. It must required
  final Widget name;

  /// Widget price
  final Widget price;

  /// Widget category
  final Widget category;

  /// Widget rating
  final Widget? rating;

  /// Widget wishlist
  final Widget? wishlist;

  /// Widget button Add card
  final Widget? addCart;

  /// Widget extra tags in information
  final Widget? tagExtra;

  /// Widget quantity
  final Widget? quantity;

  /// Width item
  final double width;

  /// Distance to button add card emerge on image
  final double? bottom;

  /// Function click item
  final Function onClick;

  /// shadow card
  final List<BoxShadow>? boxShadow;

  /// Border of item post
  final Border? border;

  /// Color Card of item post
  final Color? color;

  /// Border of item post
  final BorderRadius? borderRadius;

  /// Padding content
  final EdgeInsetsGeometry? padding;

  /// Create Product Emerge Item
  const ProductEmergeItem({
    Key? key,
    required this.image,
    required this.name,
    required this.onClick,
    required this.price,
    required this.category,
    this.rating,
    this.wishlist,
    this.addCart,
    this.tagExtra,
    this.quantity,
    this.bottom,
    this.width = 300,
    this.boxShadow,
    this.border,
    this.borderRadius,
    this.color = Colors.transparent,
    this.padding,
  }) : super(
          key: key,
          colorProduct: color,
          borderProduct: border,
          borderRadiusProduct: borderRadius,
          boxShadowProduct: boxShadow,
        );

  @override
  Widget buildLayout(BuildContext context) {
    double height = 8;
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: () => onClick(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: bottom ?? 17),
                  child: image,
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  right: 8,
                  bottom: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      tagExtra ?? Container(),
                      Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: addCart ?? Container(),
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: padding ?? EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rating ?? Container(),
                  SizedBox(height: height),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            category,
                            name,
                            SizedBox(height: height),
                            price,
                          ],
                        ),
                      ),
                      if (wishlist != null)const SizedBox(width: 5),
                      wishlist ?? Container()
                    ],
                  ),
                  if (quantity != null) SizedBox(height: height),
                  quantity ?? Container()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'product_item.dart';

/// A post widget display full width on the screen
///
class ProductCartItem extends ProductItem {
  /// Widget image
  final Widget? image;

  /// Widget name. It must required
  final Widget name;

  /// Widget price
  final Widget price;

  /// Widget attributes
  final Widget? attribute;

  /// Widget button quantity
  final Widget? quantity;

  /// shadow card
  final List<BoxShadow>? boxShadow;

  /// Border of item post
  final Border? border;

  /// Color Card of item post
  final Color? color;

  /// Border of item post
  final BorderRadius? borderRadius;

  /// Function click item
  final GestureTapCallback? onClick;

  final GestureTapCallback? onRemove;

  /// Padding item
  final EdgeInsetsGeometry padding;

  /// delete
  final Widget? remove;

  /// Create Product Card Item
  const ProductCartItem({
    Key? key,
    required this.name,
    this.onClick,
    required this.price,
    this.onRemove,
    this.image,
    this.quantity,
    this.attribute,
    this.boxShadow,
    this.border,
    this.color = Colors.transparent,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.remove,
    this.padding = EdgeInsets.zero,
  }) : super(
          key: key,
          colorProduct: color,
          borderProduct: border,
          borderRadiusProduct: borderRadius,
          boxShadowProduct: boxShadow,
        );

  @override
  Widget buildLayout(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (image != null)
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 16),
                child: image ?? Container(),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: name,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      price,
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: attribute ?? Container(),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          quantity ?? Container(),
                          InkResponse(
                              onTap: onRemove,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(bottom: 16, top: 16, start: 32),
                                child: remove ?? Container(),
                              ))
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

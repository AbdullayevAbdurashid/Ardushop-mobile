import 'package:flutter/material.dart';
import 'product_category_item.dart';

class ProductCategoryHorizontalItem extends ProductCategoryItem {
  /// Widget image
  final Widget? image;

  /// Widget name. It must required
  final Widget? name;

  /// Widget count items
  final Widget? count;

  /// Function click item
  final Function onClick;

  /// ShapeBorder of item post
  final ShapeBorder? shape;

  /// Elevation fro shadow card
  final double? elevation;

  /// Color shadow card
  final Color? shadowColor;

  /// Color Card of item category
  final Color? color;

  const ProductCategoryHorizontalItem({
    Key? key,
    this.image,
    this.name,
    this.count,
    required this.onClick,
    this.shape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
    this.elevation,
    this.shadowColor,
    this.color,
  }) : super(
          key: key,
          shapeProductCategory: shape,
          elevationProductCategory: elevation,
          shadowColorProductCategory: shadowColor,
          colorProductCategory: color,
        );
  @override
  Widget buildLayout(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: image is Widget ? 0 : 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  name ?? Container(),
                  if (name != null && count != null) const SizedBox(height: 3.6),
                  count ?? Container(),
                ],
              ),
            ),
          ),
          image ?? Container(),
        ],
      ),
    );
  }
}

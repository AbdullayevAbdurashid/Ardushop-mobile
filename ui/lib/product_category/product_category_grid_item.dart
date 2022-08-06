import 'package:flutter/material.dart';
import 'product_category_item.dart';

class ProductCategoryGridItem extends ProductCategoryItem {
  /// Widget name.
  final Widget name;

  /// Widget action.
  final Widget? action;

  /// ShapeBorder of item post
  final ShapeBorder? shape;

  /// Elevation fro shadow card
  final double? elevation;

  /// Color shadow card
  final Color? shadowColor;

  /// Color Card of item category
  final Color? color;

  final Widget? child;

  const ProductCategoryGridItem({
    Key? key,
    required this.name,
    this.action,
    this.shape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
    this.elevation,
    this.shadowColor,
    this.color,
    this.child,
  }) : super(
          key: key,
          shapeProductCategory: shape,
          elevationProductCategory: elevation,
          shadowColorProductCategory: shadowColor,
          colorProductCategory: color,
        );

  @override
  Widget buildLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: name,
              ),
              if (action != null) const SizedBox(width: 12),
              action ?? Container(),
            ],
          ),
          if (child is Widget) const SizedBox(height: 16),
          child ?? Container(),
        ],
      ),
    );
  }
}

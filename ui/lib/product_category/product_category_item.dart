import 'package:flutter/material.dart';

abstract class ProductCategoryItem extends StatefulWidget {
  final double? elevationProductCategory;
  final Color? shadowColorProductCategory;
  final ShapeBorder? shapeProductCategory;
  final Color? colorProductCategory;

  const ProductCategoryItem({
    Key? key,
    this.elevationProductCategory,
    this.shadowColorProductCategory,
    this.shapeProductCategory,
    this.colorProductCategory,
  }) : super(key: key);

  @override
  State<ProductCategoryItem> createState() => _ProductCategoryItemState();

  @protected
  Widget buildLayout(BuildContext context);
}

class _ProductCategoryItemState extends State<ProductCategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: widget.shadowColorProductCategory,
      elevation: widget.elevationProductCategory ?? 0,
      margin: EdgeInsets.zero,
      shape: widget.shapeProductCategory ?? const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      color: widget.colorProductCategory,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: widget.buildLayout(context),
    );
  }
}

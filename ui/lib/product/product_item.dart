import 'package:flutter/material.dart';

abstract class ProductItem extends StatefulWidget {
  final Color? colorProduct;
  final Border? borderProduct;
  final BorderRadius? borderRadiusProduct;
  final List<BoxShadow>? boxShadowProduct;

  const ProductItem({
    Key? key,
    this.colorProduct,
    this.borderProduct,
    this.boxShadowProduct,
    this.borderRadiusProduct,
  }) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();

  @protected
  Widget buildLayout(BuildContext context);
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.zero,
      // shape: widget.shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.zero),

      decoration: BoxDecoration(
        color: widget.colorProduct ?? Theme.of(context).cardColor,
        border: widget.borderProduct,
        borderRadius: widget.borderRadiusProduct,
        boxShadow: widget.boxShadowProduct,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: widget.buildLayout(context),
    );
    // return Card(
    //   shadowColor: widget.shadowColor,
    //   elevation: widget.elevation ?? 0,
    //   margin: EdgeInsets.zero,
    //   shape: widget.shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    //   color: widget.color,
    //   clipBehavior: Clip.antiAliasWithSaveLayer,
    //   child: widget.buildLayout(context),
    // );
  }
}

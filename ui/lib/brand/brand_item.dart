import 'package:flutter/material.dart';

abstract class BrandItem extends StatefulWidget {
  final Color? colorBrand;
  final BorderRadius? borderRadiusBrand;
  final Border? borderBrand;
  final List<BoxShadow>? boxShadowBrand;

  const BrandItem({
    Key? key,
    this.borderRadiusBrand,
    this.borderBrand,
    this.boxShadowBrand,
    this.colorBrand,
  }) : super(key: key);

  @override
  State<BrandItem> createState() => _BrandItemState();

  @protected
  Widget buildLayout(BuildContext context);
}

class _BrandItemState extends State<BrandItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.colorBrand ?? Theme.of(context).cardColor,
          border: widget.borderBrand,
          borderRadius: widget.borderRadiusBrand,
          boxShadow: widget.boxShadowBrand),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: widget.buildLayout(context),
    );
  }
}

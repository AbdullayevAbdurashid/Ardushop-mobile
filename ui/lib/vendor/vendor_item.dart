import 'package:flutter/material.dart';

abstract class VendorItem extends StatefulWidget {
  final Color? colorVendor;
  final Border? borderVendor;
  final BorderRadius? borderRadiusVendor;
  final List<BoxShadow>? boxShadowVendor;

  const VendorItem({
    Key? key,
    this.borderVendor,
    this.borderRadiusVendor,
    this.boxShadowVendor,
    this.colorVendor,
  }) : super(key: key);

  @override
  State<VendorItem> createState() => _VendorItemState();

  @protected
  Widget buildLayout(BuildContext context);
}

class _VendorItemState extends State<VendorItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.colorVendor,
        border: widget.borderVendor,
        borderRadius: widget.borderRadiusVendor,
        boxShadow: widget.boxShadowVendor,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: widget.buildLayout(context),
    );
  }
}

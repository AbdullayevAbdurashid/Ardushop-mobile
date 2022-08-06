import 'package:flutter/material.dart';
import 'vendor_item.dart';

class VendorContainedItem extends VendorItem {
  /// Widget image
  final Widget image;

  /// Widget name
  final Widget name;

  /// Widget distance item
  final Widget? distance;

  /// Widget rating
  final Widget? rating;

  /// width item
  final double? width;

  /// Function click item
  final Function onClick;

  /// Padding Item
  final EdgeInsets padding;

  /// BorderRadius of item post
  final BorderRadius? borderRadius;

  /// border item
  final Border? border;

  /// shadow item
  final List<BoxShadow>? boxShadow;

  /// Color Card of item category
  final Color? color;

  const VendorContainedItem({
    Key? key,
    required this.image,
    required this.name,
    required this.onClick,
    this.distance,
    this.rating,
    this.width,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    this.border,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.boxShadow,
    this.color = const Color(0xFFF4F4F4),
  }) : super(
          key: key,
          borderVendor: border,
          borderRadiusVendor: borderRadius,
          boxShadowVendor: boxShadow,
          colorVendor: color,
        );
  @override
  Widget buildLayout(BuildContext context) {
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: () => onClick(),
        child: Padding(
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              image,
              const SizedBox(height: 16),
              name,
              if (distance != null) distance ?? Container(),
              if (rating != null) ...[const SizedBox(height: 8), rating ?? Container()],
            ],
          ),
        ),
      ),
    );
  }
}

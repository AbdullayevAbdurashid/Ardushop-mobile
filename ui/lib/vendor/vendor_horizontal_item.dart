import 'package:flutter/material.dart';
import 'vendor_item.dart';

class VendorHorizontalItem extends VendorItem {
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

  const VendorHorizontalItem({
    Key? key,
    required this.image,
    required this.name,
    required this.onClick,
    this.distance,
    this.rating,
    this.width,
    this.padding = const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
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
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    name,
                    distance ??
                        SizedBox(
                          height: rating != null ? 8 : 0,
                        ),
                    if (rating != null) rating ?? Container(),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              image,
            ],
          ),
        ),
      ),
    );
  }
}

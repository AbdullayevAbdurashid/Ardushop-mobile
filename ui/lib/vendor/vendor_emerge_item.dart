import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:ui/vendor/vendor_item.dart';
import 'vendor_horizontal_item.dart';

class VendorEmergeItem extends VendorItem {
  /// Widget image
  final Widget image;

  /// Widget banner
  final Widget banner;

  /// Widget name
  final Widget name;

  /// Widget distance items
  final Widget? distance;

  /// Widget direction icon
  final Widget? directionIcon;

  /// Widget rating
  final Widget? rating;

  /// width item
  final double? width;

  /// height emerge
  final double heightEmerge;

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

  const VendorEmergeItem({
    Key? key,
    required this.image,
    required this.banner,
    required this.name,
    required this.onClick,
    this.directionIcon,
    this.distance,
    this.rating,
    this.width,
    this.heightEmerge = 160,
    this.padding = const EdgeInsets.all(24),
    this.border,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.boxShadow,
    this.color = const Color(0xFFF4F4F4),
  }) : super(key: key);
  @override
  Widget buildLayout(BuildContext context) {
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: () => onClick(),
        child: Stack(
          children: [
            Positioned(child: banner),
            if (directionIcon != null)
              Positioned(
                top: 16,
                right: 16,
                child: directionIcon ?? Container(),
              ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: heightEmerge),
                VendorHorizontalItem(
                  image: image,
                  name: name,
                  onClick: onClick,
                  distance: distance,
                  rating: rating,
                  width: width,
                  padding: padding,
                  border: null,
                  borderRadius: borderRadius,
                  boxShadow: null,
                  color: color,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

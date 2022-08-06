import 'package:flutter/material.dart';
import 'vendor_item.dart';

class VendorGradientItem extends VendorItem {
  /// Widget image
  final Widget image;

  /// Widget banner
  final Widget banner;

  /// Widget name
  final Widget name;

  /// Widget distance items
  final Widget? distance;

  /// Widget rating
  final Widget? rating;

  /// Widget direction icon
  final Widget? directionIcon;

  /// gradient item
  final Gradient? gradient;

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

  const VendorGradientItem({
    Key? key,
    required this.image,
    required this.banner,
    required this.name,
    required this.onClick,
    this.distance,
    this.rating,
    this.directionIcon,
    this.gradient,
    this.width,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
    this.border,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.boxShadow,
    this.color,
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
        child: Stack(
          children: [
            banner,
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: padding,
                decoration: BoxDecoration(
                  gradient: gradient ??
                      const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.transparent,
                          Colors.black
                        ], // red to yellowepeats the gradient over the canvas
                      ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.topRight,
                      child: directionIcon ?? Container(),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              name,
                              distance ?? SizedBox(height: rating is Widget ? 8 : 0),
                              if (rating is Widget) ...[
                                const SizedBox(height: 3),
                                rating ?? Container(),
                              ],
                            ],
                          ),
                        ),
                        image,
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

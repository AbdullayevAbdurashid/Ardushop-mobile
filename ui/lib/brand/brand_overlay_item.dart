import 'package:flutter/material.dart';
import 'brand_item.dart';

class BrandOverlayItem extends BrandItem {
  final Widget image;
  final Widget? name;
  final double width;
  final double? height;
  final Color opacityColor;
  final double opacity;

  /// Padding item
  final EdgeInsetsGeometry? paddingContent;

  /// Border Radius Item
  final BorderRadius? borderRadius;

  /// Border Item
  final Border? border;

  /// Border Radius Item
  final List<BoxShadow>? boxShadow;

  /// Color Card of item post
  final Color? color;

  /// Function click item
  final Function? onClick;

  const BrandOverlayItem({
    Key? key,
    this.name,
    required this.image,
    this.width = 109,
    this.height,
    this.opacityColor = Colors.black,
    this.opacity = 0.5,
    this.paddingContent,
    this.onClick,
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.color,
  }) : super(
          key: key,
          colorBrand: color,
          borderBrand: border,
          borderRadiusBrand: borderRadius,
          boxShadowBrand: boxShadow,
        );

  @override
  Widget buildLayout(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: InkWell(
        onTap: () => onClick?.call(),
        child: Stack(
          children: [
            image,
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: paddingContent ?? const EdgeInsets.all(11),
                color: opacityColor.withOpacity(opacity),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: name ?? Container(),
                    ),
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

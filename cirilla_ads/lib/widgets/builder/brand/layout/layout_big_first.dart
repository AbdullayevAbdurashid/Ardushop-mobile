import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/post_mixin.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/widgets/cirilla_brand_item.dart';
import 'package:cirilla/widgets/cirilla_divider.dart';
import 'package:flutter/material.dart';

class LayoutBigFirst extends StatelessWidget {
  final List<Brand> brands;
  final BuildItemBrandType buildItem;
  final double pad;
  final EdgeInsetsDirectional padding;
  final double widthView;
  final double dividerWidth;
  final Color dividerColor;

  const LayoutBigFirst({
    Key? key,
    required this.brands,
    required this.buildItem,
    this.pad = 0,
    this.padding = EdgeInsetsDirectional.zero,
    this.widthView = 300,
    this.dividerWidth = 0,
    this.dividerColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (brands.isEmpty) return Container();

    List<Brand> newBrands = List<Brand>.of(brands);
    Brand firstBrand = newBrands.removeAt(0);

    double widthWidget = widthView - padding.end - padding.start;
    Widget dividerWidget = dividerWidth > 0
        ? CirillaDivider(
            color: dividerColor,
            thickness: dividerWidth,
            height: pad,
          )
        : SizedBox(height: pad);
    return Padding(
      padding: padding,
      child: Column(
        children: [
          Column(
            children: [
              FirstItem(brand: firstBrand, width: widthWidget),
              if (newBrands.isNotEmpty) dividerWidget,
            ],
          ),
          ...List.generate(
            newBrands.length,
            (int index) {
              // double newWidth = MediaQuery.of(context).size.width;
              return Column(
                children: [
                  buildItem(
                    context,
                    brand: newBrands[index],
                    width: widthWidget,
                    height: null,
                  ),
                  if (index < newBrands.length - 1) dividerWidget,
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

class FirstItem extends StatelessWidget with PostMixin {
  final Brand brand;
  final double width;

  const FirstItem({Key? key, required this.brand, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CirillaBrandItem(
      brand: brand,
      width: width,
      templateType: Strings.brandItemOverlay,
    );
  }
}

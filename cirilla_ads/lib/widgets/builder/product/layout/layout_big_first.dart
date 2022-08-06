import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/cirilla_divider.dart';
import 'package:cirilla/widgets/cirilla_product_item.dart';
import 'package:flutter/material.dart';

class LayoutBigFirst extends StatelessWidget with LoadingMixin {
  final List<Product>? products;

  final Map<String, dynamic>? template;

  final BuildItemProductType? buildItem;
  final double? pad;
  final Color? dividerColor;
  final double? dividerHeight;
  final EdgeInsetsDirectional padding;
  final double widthView;

  final bool loading;
  final bool canLoadMore;
  final bool? enableLoadMore;
  final Function? onLoadMore;

  /// Force Login Add To Cart
  final bool requiredLogin;

  /// Enable Product Quick View
  final bool enableProductQuickView;

  const LayoutBigFirst({
    Key? key,
    this.products,
    this.buildItem,
    this.pad = 0,
    this.dividerColor,
    this.dividerHeight = 1,
    this.padding = EdgeInsetsDirectional.zero,
    this.template,
    this.widthView = 300,
    this.loading = false,
    this.canLoadMore = false,
    this.enableLoadMore = false,
    this.onLoadMore,
    required this.requiredLogin,
    required this.enableProductQuickView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (products!.isEmpty) return Container();
    TranslateType translate = AppLocalizations.of(context)!.translate;

    List<Product> productsData = List<Product>.of(products!);
    Product firstProduct = productsData.removeAt(0);

    //
    double width = ConvertData.stringToDouble(get(template, ['data', 'size', 'width'], 100));
    double height = ConvertData.stringToDouble(get(template, ['data', 'size', 'height'], 100));

    double widthItem = widthView - padding.end - padding.start;
    double heightItem = (widthItem * height) / width;

    return Container(
      padding: padding,
      child: Column(
        children: [
          Column(
            children: [
              FirstItem(
                product: firstProduct,
                width: widthItem,
                height: heightItem,
                template: template,
                requiredLogin: requiredLogin,
                enableProductQuickView: enableProductQuickView,
              ),
              CirillaDivider(color: dividerColor, height: pad, thickness: dividerHeight),
            ],
          ),
          ...List.generate(
            productsData.length,
            (int index) {
              return Column(
                children: [
                  buildItem!(
                    context,
                    product: productsData[index],
                    width: widthItem,
                    height: heightItem,
                  ),
                  CirillaDivider(color: dividerColor, height: pad, thickness: dividerHeight),
                ],
              );
            },
          ),
          if (enableLoadMore! && canLoadMore)
            SizedBox(
              height: 34,
              child: ElevatedButton(
                onPressed: onLoadMore as void Function()?,
                child: loading ? entryLoading(context, size: 14, color: Colors.white) : Text(translate('load_more')),
              ),
            )
        ],
      ),
    );
  }
}

class FirstItem extends StatelessWidget {
  final Product? product;
  final double? width;
  final double? height;

  final Map<String, dynamic>? template;

  /// Force Login Add To Cart
  final bool requiredLogin;

  /// Enable Product Quick View
  final bool enableProductQuickView;

  const FirstItem({
    Key? key,
    this.product,
    this.width,
    this.height,
    this.template,
    required this.requiredLogin,
    required this.enableProductQuickView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return CirillaProductItem(
      // index: 0,
      product: product,
      width: screenWidth,
      height: (screenWidth * height!) / width!,
      // template: {
      //   'template': Strings.postItemContained,
      //   'data': template['data'],
      // },
      enableProductQuickView: enableProductQuickView,
      requiredLogin: requiredLogin,
    );
  }
}

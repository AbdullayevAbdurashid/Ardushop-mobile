import 'package:flutter/material.dart';

class ProductCategoryTextRightItem extends StatelessWidget {
  final Function onTap;
  final Widget name;
  final Widget? image;
  final Widget? count;
  final Widget? iconRight;
  final Widget? child;
  final double basePadding;

  const ProductCategoryTextRightItem({
    Key? key,
    required this.onTap,
    required this.name,
    this.image,
    this.count,
    this.iconRight,
    this.child,
    this.basePadding = 8,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InkWell(
          onTap: () => onTap(),
          child: Container(
            constraints: const BoxConstraints(minHeight: 58),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: Theme.of(context).dividerColor),
              ),
            ),
            child: Row(
              children: [
                if (iconRight != null)
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: basePadding),
                    child: iconRight,
                  ),
                if (count != null)
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: basePadding),
                    child: count,
                  ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: basePadding * 2),
                      child: name,
                    ),
                  ),
                ),
                if (image != null) Padding(padding: EdgeInsetsDirectional.only(start: basePadding), child: image),
              ],
            ),
          )),
      child ?? Container(),
    ]);
  }
}

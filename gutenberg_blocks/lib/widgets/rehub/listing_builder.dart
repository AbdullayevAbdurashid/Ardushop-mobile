import 'package:flutter/material.dart';

class ListingBuilderItem extends StatelessWidget {
  final Widget? image;
  final Widget? title;
  final Widget? price;
  final Widget? score;
  final Widget? content;
  final Widget? button;
  final Widget? disclaimer;
  final Widget? expand;
  final Color background;
  final BorderRadius borderRadius;
  final Border? border;
  final EdgeInsetsGeometry? padding;
  final List<BoxShadow>? boxShadow;
  final Color colorDisclaimer;
  final EdgeInsetsGeometry? paddingDisclaimer;
  final double? width;

  const ListingBuilderItem({
    Key? key,
    this.image,
    this.title,
    this.price,
    this.score,
    this.content,
    this.button,
    this.disclaimer,
    this.expand,
    required this.background,
    this.border,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.padding,
    this.boxShadow,
    required this.colorDisclaimer,
    this.paddingDisclaimer,
    this.width,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: disclaimer is Widget
          ? Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colorDisclaimer,
                borderRadius: borderRadius,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildContent(),
                  Padding(
                    padding: paddingDisclaimer ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: disclaimer,
                  ),
                ],
              ),
            )
          : buildContent(),
    );
  }

  Widget buildContent() {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: background,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow ??
            [
              const BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.08),
                offset: Offset(0, 4),
                blurRadius: 24,
                spreadRadius: 0,
              )
            ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          image ?? Container(),
          if (title is Widget || price is Widget || score is Widget) ...[
            if (image is Widget) const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title ?? Container(),
                      if (title is Widget && price is Widget) const SizedBox(height: 8),
                      price ?? Container(),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                score ?? Container(),
              ],
            ),
          ],
          if (content is Widget) ...[
            if (image is Widget || title is Widget || price is Widget || score is Widget) const SizedBox(height: 8),
            content ?? Container(),
          ],
          if (expand is Widget) ...[
            if (image is Widget || title is Widget || price is Widget || score is Widget || content is Widget)
              const SizedBox(height: 8),
            expand ?? Container(),
          ],
          if (button is Widget) ...[
            if (image is Widget ||
                title is Widget ||
                price is Widget ||
                score is Widget ||
                content is Widget ||
                expand is Widget)
              const SizedBox(height: 16),
            button ?? Container(),
          ],
        ],
      ),
    );
  }
}

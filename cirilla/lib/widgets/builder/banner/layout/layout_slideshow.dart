import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/types/types.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';

class LayoutSlideshow extends StatefulWidget {
  final int length;
  final BuildItemBannerType? buildItem;
  final EdgeInsetsDirectional padding;
  final Size? size;
  final Color? indicatorColor;
  final Color? indicatorActiveColor;

  const LayoutSlideshow({
    Key? key,
    this.length = 1,
    this.buildItem,
    this.padding = EdgeInsetsDirectional.zero,
    this.size = const Size(375, 330),
    this.indicatorColor,
    this.indicatorActiveColor,
  }) : super(key: key);

  @override
  State<LayoutSlideshow> createState() => _LayoutSlideshowState();
}

class _LayoutSlideshowState extends State<LayoutSlideshow> {
  int pagination = 0;
  void changePagination(int value) {
    setState(() {
      pagination = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          double width = constraints.maxWidth;
          double height = (width * widget.size!.height) / widget.size!.width;
          return SizedBox(
            width: width,
            height: height,
            child: Swiper(
              itemWidth: width,
              itemHeight: height,
              containerWidth: width,
              containerHeight: height,
              itemBuilder: (_, int index) {
                return SizedBox(
                  width: width,
                  child: widget.buildItem!(context, index: index, width: width, height: height),
                );
              },
              itemCount: widget.length,
              curve: Curves.linear,
              pagination: SwiperPagination(
                margin: secondPaddingMedium,
                builder: DotSwiperPaginationBuilder(
                  space: 4,
                  activeSize: 6,
                  size: 6,
                  color: widget.indicatorColor,
                  activeColor: widget.indicatorActiveColor,
                ),
              ),
              // onIndexChanged: (int value) => changePagination(value),
            ),
          );
        },
      ),
    );
  }
}

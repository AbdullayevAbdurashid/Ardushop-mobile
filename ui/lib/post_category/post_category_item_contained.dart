import 'package:flutter/material.dart';
import 'post_category_item.dart';

class PostCategoryItemContained extends PostCategoryItem {
  /// widget image PostCategory
  final Widget image;

  /// widget title PostCategory
  final Widget title;

  /// widget count PostCategory
  final Widget? count;

  /// width item
  final double width;

  /// height item
  final double? height;

  /// Border shape item post
  final ShapeBorder? shape;

  /// Color Card of item post
  final Color? color;

  /// elevation item post
  final double? elevation;

  /// color shadow of item post
  final Color? shadowColor;

  /// Function onClick PostCategory
  final Function? onClick;

  const PostCategoryItemContained({
    Key? key,
    required this.image,
    required this.title,
    this.count,
    this.width = 109,
    this.height,
    this.onClick,
    this.shape,
    this.color,
    this.elevation,
    this.shadowColor,
  }) : super(
          key: key,
          shapePostCategory: shape,
          colorPostCategory: color,
          shadowColorPostCategory: shadowColor,
        );

  @override
  Widget buildLayout(BuildContext context) {
    return InkResponse(
      onTap: () => onClick?.call(),
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                image,
                Positioned(
                  right: 0,
                  child: count ?? Container(),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            title,
          ],
        ),
      ),
    );
  }
}

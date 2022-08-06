import 'package:flutter/material.dart';
import 'post_item.dart';

/// A post widget display full width on the screen
///
class PostTopNameItem extends PostItem {
  /// Widget image
  final Widget image;

  /// Widget name. It must required
  final Widget name;

  /// Widget category
  final Widget? category;

  /// Widget date
  final Widget? date;

  /// Widget author
  final Widget? author;

  /// Widget excerpt
  final Widget? excerpt;

  /// Widget comment
  final Widget? comment;

  /// width Item
  final double width;

  /// padding Item
  final EdgeInsetsGeometry padding;

  /// Border of item post
  final Border? border;

  /// Color Card of item post
  final Color? color;

  /// Border of item post
  final BorderRadius? borderRadius;

  /// shadow card
  final List<BoxShadow>? boxShadow;

  /// Function click item
  final Function onClick;

  /// Create Post Contained Item
  const PostTopNameItem({
    Key? key,
    required this.image,
    required this.name,
    required this.onClick,
    this.category,
    this.excerpt,
    this.date,
    this.author,
    this.comment,
    this.width = 300,
    this.padding = EdgeInsets.zero,
    this.color,
    this.boxShadow,
    this.borderRadius,
    this.border,
  }) : super(
          key: key,
          borderPost: border,
          boxShadowPost: boxShadow,
          borderRadiusPost: borderRadius,
          colorPost: color,
        );

  @override
  Widget buildLayout(BuildContext context) {
    double height =16;
    return InkWell(
      onTap: () => onClick(),
      child: Container(
        width: width,
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (category != null) ...[
              category ?? Container(),
              SizedBox(height: height),
            ],
            name,
            SizedBox(height: height),
            image,
            if (date != null || author != null || comment != null) ...[
              SizedBox(height: height),
              Wrap(
                spacing: 16,
                children: [
                  if (date != null) date ?? Container(),
                  if (author != null) author ?? Container(),
                  comment ?? Container(),
                ],
              ),
            ],
            if (excerpt != null) ...[
              SizedBox(height: height),
              excerpt ?? Container(),
            ],
          ],
        ),
      ),
    );
  }
}

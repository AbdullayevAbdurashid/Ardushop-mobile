import 'package:flutter/material.dart';
import 'post_item.dart';

/// A post widget display full width on the screen
///
class PostOverlayItem extends PostItem {
  /// Widget image
  final Widget image;

  /// Widget name. It must required
  final Widget name;

  /// Widget category
  final Widget? category;

  /// Widget category
  final Widget? topRight;

  /// Widget date
  final Widget? date;

  /// Widget author
  final Widget? author;

  /// Widget description
  final Widget? excerpt;

  /// Widget comment
  final Widget? comment;

  /// background opacity
  final Color background;

  /// opacity
  final double opacity;

  /// color line
  final Color? colorLine;

  /// padding item
  final EdgeInsetsGeometry padding;

  /// width item
  final double width;

  /// shadow card
  final List<BoxShadow>? boxShadow;

  /// Border of item post
  final Border? border;

  /// Color Card of item post
  final Color? color;

  /// Border of item post
  final BorderRadius? borderRadius;

  /// Function click item
  final Function onClick;

  /// Create Post Contained Item
  const PostOverlayItem({
    Key? key,
    required this.image,
    required this.name,
    required this.onClick,
    this.category,
    this.topRight,
    this.excerpt,
    this.date,
    this.author,
    this.comment,
    this.background = Colors.black,
    this.colorLine,
    this.opacity = 0.5,
    this.width = 300,
    this.padding = const EdgeInsets.all(24),
    this.color,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.border,
    this.boxShadow,
  }) : super(
          key: key,
          colorPost: color,
          borderPost: border,
          borderRadiusPost: borderRadius,
          boxShadowPost: boxShadow,
        );

  @override
  Widget buildLayout(BuildContext context) {
    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: () => onClick(),
        child: Stack(
          children: [
            image,
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: background.withOpacity(opacity),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (category != null || topRight != null) ...[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: category ?? Container()),
                                if (topRight != null)
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(start: 16),
                                    child: topRight ?? Container(),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 16),
                          ],
                          name,
                        ],
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 2,
                      margin: const EdgeInsets.symmetric(vertical: 24),
                      color: colorLine ?? Theme.of(context).dividerColor,
                    ),
                    if (excerpt != null) excerpt ?? Container(),
                    if (date != null || author != null || comment != null) ...[
                      const SizedBox(
                        height: 16,
                      ),
                      Wrap(
                        spacing: 16,
                        children: [
                          if (date != null) date ?? Container(),
                          if (author != null) author ?? Container(),
                          comment ?? Container(),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

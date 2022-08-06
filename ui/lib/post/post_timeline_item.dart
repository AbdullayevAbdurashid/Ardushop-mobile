import 'package:flutter/material.dart';

/// A post widget display full width on the screen
///
class PostTimeLineItem extends StatelessWidget {
  static double defaultWidthLeft = 74;

  /// Widget image
  final Widget image;

  /// Widget name. It must required
  final Widget name;

  /// Widget category
  final Widget? category;

  /// Widget info heading
  final Widget? headingInfo;

  /// Widget description
  final Widget? description;

  /// Widget left
  final Widget? left;

  /// width widget left
  final double widthLeft;

  /// width item
  final double width;

  /// padding content
  final EdgeInsetsGeometry paddingContent;

  /// Function click item
  final Function onClick;

  /// Border of item post
  final Border? border;

  /// Color Card of item post
  final Color? color;

  /// Border of item post
  final BorderRadius? borderRadius;

  /// shadow card
  final List<BoxShadow>? boxShadow;

  /// Create Post Contained Item
  const PostTimeLineItem({
    Key? key,
    required this.image,
    required this.name,
    required this.onClick,
    this.category,
    this.description,
    this.headingInfo,
    this.width = 353,
    this.widthLeft = 74,
    this.paddingContent = const EdgeInsets.all(16),
    this.left,
    this.color,
    this.borderRadius,
    this.border,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: headingInfo ?? Container()),
              if (category != null)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: category ?? Container(),
                )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (left != null) SizedBox(width: widthLeft, child: left ?? Container()),
              Expanded(
                child: InkWell(
                  onTap: () => onClick(),
                  child: Container(
                    width: double.infinity,
                    padding: paddingContent,
                    decoration: BoxDecoration(
                      color: color ?? Theme.of(context).cardColor,
                      border: border,
                      borderRadius: borderRadius ??
                          const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                      boxShadow: boxShadow ??
                          [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              offset: const Offset(0, 4),
                              blurRadius: 0.08,
                              spreadRadius: 24,
                            )
                          ],
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        image,
                        const SizedBox(height: 16),
                        name,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// A post widget display full width on the screen
///
class PostEmergeItem extends StatelessWidget {
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

  /// Width item
  final double width;

  /// heightEmerge
  final double heightEmerge;

  /// padding content item
  final EdgeInsetsGeometry padding;

  /// Function click item
  final Function onClick;

  /// shadow card
  final List<BoxShadow>? boxShadow;

  /// Border of item post
  final Border? border;

  /// Color Card of item post
  final Color? color;

  /// Border of item post
  final BorderRadius? borderRadius;

  /// Create Post Contained Item
  const PostEmergeItem({
    Key? key,
    required this.image,
    required this.name,
    required this.onClick,
    this.category,
    this.excerpt,
    this.date,
    this.author,
    this.comment,
    this.heightEmerge = 150,
    this.padding = const EdgeInsets.all(16),
    this.width = 300,
    this.color,
    this.border,
    this.borderRadius,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double height =16;
    return SizedBox(
      width: width,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              width: width,
              constraints: BoxConstraints(minHeight: heightEmerge),
              child: image,
            ),
          ),
          Column(
            children: [
              Container(
                height: heightEmerge,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: height),
                // transform: Matrix4.translationValues(0.0, -43.0, 0.0),
                child: Container(
                  margin: EdgeInsets.zero,
                  // elevation: elevation ?? 6,
                  // shape: shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  // shadowColor: shadowColor,
                  // color: color,
                  decoration: BoxDecoration(
                    color: color ?? theme.cardColor,
                    border: border,
                    borderRadius: borderRadius ?? BorderRadius.circular(8),
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
                  child: Padding(
                    padding: padding,
                    child: Column(
                      children: [
                        if (category != null) ...[
                          category ?? Container(),
                          SizedBox(height: height),
                        ],
                        InkWell(
                          onTap: () => onClick(),
                          child: name,
                        ),
                        if (excerpt is Widget) ...[SizedBox(height: height), excerpt ?? Container()],
                        if (date != null || author != null || comment != null) ...[
                          SizedBox(height: height),
                          Wrap(
                            spacing: 16,
                            alignment: WrapAlignment.center,
                            children: [
                              if (date != null) date ?? Container(),
                              if (author != null) author ?? Container(),
                              comment ?? Container()
                            ],
                          )
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

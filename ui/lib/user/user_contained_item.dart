import 'package:flutter/material.dart';
import 'user_item.dart';

class UserContainedItem extends UserItem {
  /// Widget Image
  final Widget? image;

  /// Widget title
  final Widget title;

  /// Widget title
  final Widget? leading;

  /// Widget sub title
  final Widget? trailing;

  /// width item
  final double width;

  /// padding item
  final EdgeInsetsGeometry padding;

  /// Function click item
  final Function onClick;

  /// Border radius of item
  final BorderRadius? borderRadius;

  /// Shadow of item
  final List<BoxShadow>? shadow;

  /// Color of item
  final Color? color;

  const UserContainedItem({
    Key? key,
    this.image,
    required this.title,
    this.leading,
    this.trailing,
    required this.onClick,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.shadow,
    this.color,
    this.width = double.infinity,
    this.padding = const EdgeInsets.all(16),
  }) : super(
          key: key,
          shadowUser: shadow,
          borderRadiusUser: borderRadius,
          colorUser: color,
        );

  @override
  Widget buildLayout(BuildContext context) {
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: () => onClick(),
        child: Padding(
          padding: padding,
          child: Row(
            children: [
              if (image is Widget) ...[
                image ?? Container(),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    leading ?? Container(),
                    title,
                    if (trailing is Widget) ...[const SizedBox(height: 4), trailing ?? Container()],
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

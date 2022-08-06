import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final Widget? label;
  final Icon? icon;
  final EdgeInsets padding;
  final GestureTapCallback? onTap;
  final double? elevation;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final Color? color;
  final bool enableIconLeft;

  const Search({
    Key? key,
    this.label,
    this.icon,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(width: 1),
    ),
    this.elevation = 0,
    this.shadowColor,
    this.color,
    this.enableIconLeft = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = 16;
    return buildContent(
      child: label != null || icon != null
          ? Padding(
              padding: padding,
              child: Row(
                children: [
                  if (icon != null && enableIconLeft) icon ?? Container(),
                  if (icon != null && enableIconLeft) SizedBox(width: width),
                  Expanded(child: label ?? Container()),
                  if (icon != null && !enableIconLeft) SizedBox(width: width),
                  if (icon != null && !enableIconLeft) icon ?? Container(),
                ],
              ),
            )
          : const SizedBox(height: 48, width: double.infinity),
    );
  }

  Widget buildContent({Widget? child}) {
    return Card(
      color: color,
      elevation: elevation,
      shadowColor: shadowColor,
      shape: shape,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }
}

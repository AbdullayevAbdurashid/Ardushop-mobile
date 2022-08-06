import 'package:flutter/material.dart';

abstract class IconBoxItem extends StatefulWidget {
  final Color? colorIconBox;
  final BorderRadius? borderRadiusIconBox;
  final Border? borderIconBox;
  final List<BoxShadow>? boxShadowIconBox;

  const IconBoxItem({
    Key? key,
    this.borderRadiusIconBox,
    this.borderIconBox,
    this.boxShadowIconBox,
    this.colorIconBox,
  }) : super(key: key);

  @override
  State<IconBoxItem> createState() => _IconBoxItemState();

  @protected
  Widget buildLayout(BuildContext context);
}

class _IconBoxItemState extends State<IconBoxItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.colorIconBox ?? Theme.of(context).cardColor,
          border: widget.borderIconBox,
          borderRadius: widget.borderRadiusIconBox,
          boxShadow: widget.boxShadowIconBox),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: widget.buildLayout(context),
    );
  }
}

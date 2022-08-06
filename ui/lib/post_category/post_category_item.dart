import 'package:flutter/material.dart';

abstract class PostCategoryItem extends StatefulWidget {
  final double? elevationPostCategory;
  final Color? shadowColorPostCategory;
  final Color? colorPostCategory;
  final ShapeBorder? shapePostCategory;

  const PostCategoryItem({
    Key? key,
    this.elevationPostCategory,
    this.shadowColorPostCategory,
    this.colorPostCategory,
    this.shapePostCategory,
  }) : super(key: key);

  @override
  State<PostCategoryItem> createState() => _PostCategoryItemState();

  @protected
  Widget buildLayout(BuildContext context);
}

class _PostCategoryItemState extends State<PostCategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: widget.shadowColorPostCategory,
      elevation: widget.elevationPostCategory ?? 0,
      color: widget.colorPostCategory,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: widget.shapePostCategory ?? const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: widget.buildLayout(context),
    );
  }
}

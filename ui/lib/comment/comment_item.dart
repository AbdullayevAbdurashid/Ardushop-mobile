import 'package:flutter/material.dart';

abstract class CommentItem extends StatefulWidget {
  final double? elevationComment;
  final Color? shadowColorComment;
  final ShapeBorder? shape;
  final Color? color;

  const CommentItem({
    Key? key,
    this.elevationComment,
    this.shadowColorComment,
    this.shape,
    this.color = Colors.transparent,
  }) : super(key: key);

  @override
  State<CommentItem> createState() => _CommentItemState();

  @protected
  Widget buildLayout(BuildContext context);
}

class _CommentItemState extends State<CommentItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: widget.shadowColorComment,
      elevation: widget.elevationComment ?? 0,
      margin: EdgeInsets.zero,
      shape: widget.shape ?? const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      color: widget.color,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: widget.buildLayout(context),
    );
  }
}

import 'package:flutter/material.dart';

abstract class PostItem extends StatefulWidget {
  final Color? colorPost;
  final List<BoxShadow>? boxShadowPost;
  final Border? borderPost;
  final BorderRadius? borderRadiusPost;

  const PostItem({
    Key? key,
    this.colorPost,
    this.boxShadowPost,
    this.borderPost,
    this.borderRadiusPost,
  }) : super(key: key);

  @override
  State<PostItem> createState() => _PostItemState();

  @protected
  Widget buildLayout(BuildContext context);
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.colorPost ?? Theme.of(context).cardColor,
        borderRadius: widget.borderRadiusPost,
        border: widget.borderPost,
        boxShadow: widget.boxShadowPost,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: widget.buildLayout(context),
    );
  }
}

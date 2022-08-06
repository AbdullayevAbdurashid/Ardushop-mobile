import 'package:flutter/material.dart';
import 'comment_item.dart';
class CommentHorizontalItem extends CommentItem {
  /// Link url image
  final String image;

  /// widget name
  final Widget name;

  /// widget date
  final Widget date;
  
  /// widget Comment
  final Widget comment;

  /// widget rating detal/about Comment
  final Widget? rating;

  /// Function onClick
  final Function onClick;

  /// Elevation fro shadow card
  final double? elevation;

  /// Color shadow card
  final Color? shadowColor;

  final Widget? reply;

  const CommentHorizontalItem({
    Key? key,
    required this.image,
    required this.name,
    required this.onClick,
    required this.comment,
    required this.date,
    this.rating,
    this.elevation,
    this.shadowColor,
    this.reply,
  }): super(
    key: key,
    elevationComment: elevation,
    shadowColorComment: shadowColor,
  );

  @override
  Widget buildLayout(BuildContext context) {
     return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          renderMedia(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: name),
                    date,
                  ],
                ),
                rating?? Container(),

                comment,
                reply ?? Container(),
              ],
            ),
          )
        ],
      // ),
    );
  }

  Widget renderMedia() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Image.network(
        image,
        width: 24,
        height: 24,
        fit: BoxFit.cover,
      ),
    );
  }
}
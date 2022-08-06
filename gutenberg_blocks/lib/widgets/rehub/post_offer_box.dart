import 'package:flutter/material.dart';

class PostOfferBox extends StatelessWidget {
  final Widget? image;
  final Widget? title;
  final Widget? rating;
  final Widget? button;

  const PostOfferBox({
    Key? key,
    this.image,
    this.title,
    this.rating,
    this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        image ?? Container(),
        if (title is Widget) ...[
          if (image is Widget) const SizedBox(height: 16),
          title ?? Container(),
        ],
        if (rating is Widget) ...[
          if (image is Widget || title is Widget) const SizedBox(height: 8),
          rating ?? Container(),
        ],
        if (button is Widget) ...[
          if (image is Widget || title is Widget || rating is Widget) const SizedBox(height: 16),
          button ?? Container(),
        ],
      ],
    );
  }
}

import 'package:flutter/material.dart';

class ReviewHeading extends StatelessWidget {
  final Widget? positionNumber;
  final Widget? title;
  final Widget? subtitle;
  final Widget? image;

  const ReviewHeading({
    Key? key,
    this.positionNumber,
    this.title,
    this.subtitle,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (positionNumber is Widget || title is Widget || image is Widget)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    positionNumber ?? Container(),
                    title ?? Container(),
                  ],
                ),
              ),
              if (image is Widget) const SizedBox(width: 16),
              image ?? Container(),
            ],
          ),
        if (subtitle is Widget && (positionNumber is Widget || title is Widget || image is Widget))
          const SizedBox(height: 8),
        subtitle ?? Container()
      ],
    );
  }
}

import 'package:flutter/material.dart';

class ReviewBox extends StatelessWidget {
  final Widget score;
  final Widget? title;
  final Widget? description;
  final Widget? criteria;
  final Widget? consPros;
  final Widget separator;

  const ReviewBox({
    Key? key,
    required this.score,
    this.title,
    this.description,
    this.criteria,
    this.consPros,
    required this.separator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            score,
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title ?? Container(),
                  if (title is Widget && description is Widget) const SizedBox(height: 4),
                  description ?? Container(),
                ],
              ),
            ),
          ],
        ),
        if (criteria is Widget) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: separator,
          ),
          criteria ?? Container(),
        ],
        if (consPros is Widget) ...[
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 16),
            child: separator,
          ),
          consPros ?? Container(),
        ],
      ],
    );
  }
}

import 'package:flutter/material.dart';

class HowTo extends StatelessWidget {
  final Widget? title;
  final Widget? description;
  final Color borderColor;
  final EdgeInsetsGeometry padding;
  final double minHeightTitle;
  final double padHorizontalTitle;
  final int countStep;
  final Widget Function(int index)? buildItemStep;
  final double padStep;

  const HowTo({
    Key? key,
    this.title,
    this.description,
    required this.borderColor,
    this.padding = const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
    this.minHeightTitle = 49,
    this.padHorizontalTitle = 16,
    this.countStep = 1,
    this.buildItemStep,
    this.padStep = 32,
  })  : assert(countStep >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        double maxWidth = constraints.maxWidth;
        double widthScreen = MediaQuery.of(context).size.width;
        double widthDefault = maxWidth == double.infinity ? widthScreen : maxWidth;
        double maxWidthTitle = widthDefault - 2 * padHorizontalTitle;
        BorderSide borderSide = BorderSide(width: 2, color: borderColor);

        double heightEmerge = title is Widget ? minHeightTitle / 2 : 0;

        return Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: heightEmerge),
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  description ?? Container(),
                  if (description is Widget && countStep > 0 && buildItemStep != null) const SizedBox(height: 24),
                  if (countStep > 0 && buildItemStep != null)
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, int index) {
                        return buildItemStep?.call(index) ?? Container();
                      },
                      separatorBuilder: (_, int index) {
                        return SizedBox(height: padStep);
                      },
                      itemCount: countStep,
                    ),
                ],
              ),
            ),
            Positioned(
              top: heightEmerge,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    left: borderSide,
                    right: borderSide,
                    bottom: borderSide,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: title is Widget ? minHeightTitle : null,
              child: Row(
                children: [
                  Expanded(
                    child: Divider(height: 2, thickness: 2, color: borderColor),
                  ),
                  if (title is Widget) ...[
                    SizedBox(width: padHorizontalTitle),
                    Container(
                      constraints: BoxConstraints(maxWidth: maxWidthTitle),
                      child: title,
                    ),
                    SizedBox(width: padHorizontalTitle),
                  ],
                  Expanded(
                    child: Divider(height: 2, thickness: 2, color: borderColor),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class StepItem extends StatelessWidget {
  final Widget visit;
  final Widget? title;
  final Widget? content;

  const StepItem({
    Key? key,
    required this.visit,
    this.title,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            visit,
            const SizedBox(width: 16),
            Expanded(child: title ?? Container()),
          ],
        ),
        if (content is Widget) ...[const SizedBox(height: 8), content ?? Container()]
      ],
    );
  }
}

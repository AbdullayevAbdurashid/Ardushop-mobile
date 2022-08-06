import 'package:flutter/material.dart';

class TitleBox extends StatelessWidget {
  final Widget? heading;
  final Widget title;
  final Color borderColor;
  final bool doubleBorder;
  final EdgeInsetsGeometry paddingTitle;
  final double minHeightTitle;
  final double padHorizontalHeading;
  final double marHorizontalHeading;

  const TitleBox({
    Key? key,
    this.heading,
    required this.title,
    required this.borderColor,
    this.doubleBorder = false,
    this.paddingTitle = const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 16),
    this.minHeightTitle = 33,
    this.padHorizontalHeading = 8,
    this.marHorizontalHeading = 8,
  })  : assert(minHeightTitle >= 0),
        assert(marHorizontalHeading >= 0),
        assert(padHorizontalHeading >= 0),
        super(key: key);

  Widget buildBorder(Color color, bool doubleBorder, double heightBorder) {
    double widthBorder = doubleBorder ? 1 : heightBorder;
    BorderSide borderSide = BorderSide(width: widthBorder, color: color);
    Border border = Border(
      left: borderSide,
      right: borderSide,
      bottom: borderSide,
    );
    if (doubleBorder) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(heightBorder - 2 * widthBorder).copyWith(top: heightBorder),
        decoration: BoxDecoration(border: border),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            border: border,
          ),
        ),
      );
    }
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(border: border),
    );
  }

  Widget buildLineBorder(Color color, bool doubleBorder, double heightBorder, String visit) {
    double widthBorder = doubleBorder ? 1 : heightBorder;

    if (!doubleBorder) {
      return Container(
        height: widthBorder,
        color: color,
      );
    }
    double pad = heightBorder - 2 * widthBorder;
    EdgeInsetsGeometry paddingLine = visit == 'end'
        ? EdgeInsetsDirectional.only(end: pad + widthBorder)
        : EdgeInsetsDirectional.only(start: pad + widthBorder);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Divider(height: 1, thickness: 1, color: color),
        Container(
          height: widthBorder,
          color: color,
        ),
        SizedBox(height: pad),
        Padding(
          padding: paddingLine,
          child: Container(
            height: widthBorder,
            color: color,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        double maxWidth = constraints.maxWidth;
        double widthScreen = MediaQuery.of(context).size.width;
        double widthDefault = maxWidth == double.infinity ? widthScreen : maxWidth;
        double maxWidthTitle = widthDefault - 2 * padHorizontalHeading - 2 * marHorizontalHeading;

        double heightBorder = doubleBorder ? 4 : 2;
        double heightEmerge = heading is Widget ? minHeightTitle / 2 - heightBorder / 2 : 0;

        return Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: heightEmerge),
              padding: paddingTitle,
              child: title,
            ),
            Positioned(
              top: heightEmerge,
              left: 0,
              right: 0,
              bottom: 0,
              child: buildBorder(borderColor, doubleBorder, heightBorder),
            ),
            SizedBox(
              height: heading is Widget ? minHeightTitle : null,
              child: Row(
                children: [
                  SizedBox(
                    width: marHorizontalHeading,
                    child: buildLineBorder(borderColor, doubleBorder, heightBorder, 'start'),
                  ),
                  if (heading is Widget) ...[
                    SizedBox(width: padHorizontalHeading),
                    Container(
                      constraints: BoxConstraints(maxWidth: maxWidthTitle),
                      child: heading,
                    ),
                    SizedBox(width: padHorizontalHeading),
                  ],
                  Expanded(
                    child: buildLineBorder(borderColor, doubleBorder, heightBorder, 'end'),
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

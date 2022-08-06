import 'package:flutter/material.dart';

enum HighlightPosition { start, end, top, bottom }

class PromoBox extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final Widget? button;
  final Color? background;
  final Color? borderColor;
  final Color? highlightBorderColor;
  final bool enableBorder;
  final bool enableHighlightBorder;
  final HighlightPosition highlightPosition;
  final EdgeInsetsGeometry padding;
  final double borderSize;

  const PromoBox({
    Key? key,
    this.title,
    this.subtitle,
    this.button,
    this.background,
    this.borderColor,
    this.highlightBorderColor,
    this.enableBorder = false,
    this.enableHighlightBorder = false,
    this.highlightPosition = HighlightPosition.start,
    this.padding = const EdgeInsets.all(24),
    this.borderSize = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title ?? Container(),
          if (title is Widget && subtitle is Widget) const SizedBox(height: 8),
          subtitle ?? Container(),
          if (button is Widget && (title is Widget || subtitle is Widget)) const SizedBox(height: 16),
          button ?? Container(),
        ],
      ),
    );
  }

  Widget buildBox({Widget? child}) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: padding,
          decoration: BoxDecoration(
            color: background,
            border: enableBorder ? Border.all(width: borderSize, color: borderColor ?? Colors.black) : null,
          ),
          child: child,
        ),
        buildPosition(),
      ],
    );
  }

  Widget buildPosition() {
    if (enableHighlightBorder) {
      double? top;
      double? start;
      double? end;
      double? bottom;
      double? widthHighLight;
      double? heightHighLight;
      switch (highlightPosition) {
        case HighlightPosition.top:
          top = 0;
          start = 0;
          end = 0;
          widthHighLight = double.infinity;
          heightHighLight = 5;
          break;
        case HighlightPosition.end:
          top = 0;
          end = 0;
          bottom = 0;
          widthHighLight = 5;
          heightHighLight = double.infinity;
          break;
        case HighlightPosition.bottom:
          bottom = 0;
          start = 0;
          end = 0;
          widthHighLight = double.infinity;
          heightHighLight = 5;
          break;
        default:
          top = 0;
          start = 0;
          bottom = 0;
          widthHighLight = 5;
          heightHighLight = double.infinity;
      }
      return PositionedDirectional(
        top: top,
        start: start,
        end: end,
        bottom: bottom,
        child: Container(
          width: widthHighLight,
          height: heightHighLight,
          color: highlightBorderColor,
        ),
      );
    }
    return Container();
  }
}

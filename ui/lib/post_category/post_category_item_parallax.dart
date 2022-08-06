import 'package:flutter/material.dart';

class PostCategoryItemParallax extends StatelessWidget {
  PostCategoryItemParallax({
    Key? key,
    required this.image,
    required this.title,
    this.count,
    this.ratio = 336 / 160,
    this.width,
    this.colorsGradient,
    this.borderRadius,
    this.onClick,
  }) : super(key: key);

  /// widget image PostCategory
  final Widget image;

  /// widget title PostCategory
  final Widget title;

  /// widget count PostCategory
  final Widget? count;

  final double ratio;

  final double? width;

  final BorderRadius? borderRadius;

  final List<Color>? colorsGradient;

  final GlobalKey _backgroundImageKey = GlobalKey();

  /// Function onClick PostCategory
  final Function? onClick;

  @override
  Widget build(BuildContext context) {
    // Widget item = ClipRRect(
    //   borderRadius: borderRadius ?? BorderRadius.circular(8),
    //   child: Stack(
    //     children: [
    //       _buildParallaxBackground(context),
    //       _buildGradient(),
    //       _buildTitleAndSubtitle(),
    //     ],
    //   ),
    // );

    return SizedBox(
      width: width ?? 335,
      child: AspectRatio(
        aspectRatio: ratio,
        child: InkResponse(
          onTap: () => onClick?.call(),
          child: ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
            child: Stack(
              children: [
                _buildParallaxBackground(context),
                _buildGradient(),
                _buildTitleAndSubtitle(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context)!,
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        Container(
          key: _backgroundImageKey,
          child: image,
        )
      ],
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colorsGradient ?? [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.5, 1],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle() {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title,
          count ?? Container(),
        ],
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(listItemBox.size.centerLeft(Offset.zero), ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction = (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final backgroundSize = (backgroundImageKey.currentContext!.findRenderObject() as RenderBox).size;
    final listItemSize = context.size;
    final childRect = verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
      0,
      transform: Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}

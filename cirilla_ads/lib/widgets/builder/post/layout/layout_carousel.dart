import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/loading_mixin.dart';
import 'package:cirilla/models/post/post.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/widgets/cirilla_divider.dart';
import 'package:flutter/material.dart';

class LayoutCarousel extends StatefulWidget {
  final List<Post>? posts;
  final BuildItemPostType? buildItem;
  final double? pad;
  final Color? dividerColor;
  final double? dividerHeight;
  final EdgeInsetsDirectional padding;
  final bool loading;
  final bool canLoadMore;
  final bool? enableLoadMore;
  final Function? onLoadMore;

  const LayoutCarousel({
    Key? key,
    this.posts,
    this.buildItem,
    this.pad = 0,
    this.dividerColor,
    this.dividerHeight = 1,
    this.padding = EdgeInsetsDirectional.zero,
    this.loading = false,
    this.canLoadMore = false,
    this.enableLoadMore = false,
    this.onLoadMore,
  }) : super(key: key);

  @override
  State<LayoutCarousel> createState() => _LayoutCarouselState();
}

class _LayoutCarouselState extends State<LayoutCarousel> with LoadingMixin {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (!widget.enableLoadMore! || !_controller.hasClients || widget.loading || !widget.canLoadMore) return;
    final thresholdReached = _controller.position.extentAfter < endReachedThreshold;

    if (thresholdReached) {
      widget.onLoadMore!();
    }
  }

  @override
  Widget build(BuildContext context) {
    int count = widget.enableLoadMore! && widget.loading ? widget.posts!.length + 1 : widget.posts!.length;
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        double heightItem = constraints.maxHeight;
        return ListView.separated(
          controller: _controller,
          padding: widget.padding,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            if (index == widget.posts!.length) {
              return Container(
                height: heightItem != double.infinity ? heightItem : null,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: layoutPadding),
                  child: buildLoading(context, isLoading: widget.canLoadMore),
                ),
              );
            }
            return widget.buildItem!(context, post: widget.posts![index], index: index);
          },
          separatorBuilder: (context, index) => CirillaDivider(
            color: widget.dividerColor,
            height: widget.pad,
            thickness: widget.dividerHeight,
            axis: Axis.vertical,
          ),
          itemCount: count,
        );
      },
    );
  }
}

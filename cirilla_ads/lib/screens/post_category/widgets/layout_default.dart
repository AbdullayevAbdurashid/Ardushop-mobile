import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/widgets/cirilla_post_category_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LayoutDefault extends StatelessWidget with LoadingMixin {
  final List<PostCategory>? postCategories;
  final bool? loading;
  final Future<void> Function()? refresh;
  final bool? canLoadMore;

  final Widget? search;

  final ScrollController controller;

  LayoutDefault({
    Key? key,
    this.loading,
    this.postCategories,
    this.refresh,
    this.canLoadMore,
    this.search,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      controller: controller,
      slivers: [
        SliverAppBar(
          primary: true,
          pinned: true,
          expandedHeight: 60,
          leadingWidth: 0,
          title: search,
          automaticallyImplyLeading: false,
          titleSpacing: 20,
        ),
        CupertinoSliverRefreshControl(
          onRefresh: refresh,
          builder: buildAppRefreshIndicator,
        ),
        SliverPadding(
          padding: paddingHorizontal,
          sliver: SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                PostCategory item = postCategories!.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.only(top: itemPaddingLarge),
                  child: CirillaPostCategoryItem(
                    category: item,
                    template: const {'template': Strings.postCategoryItemParallax},
                    width: width - 40,
                  ),
                );
              },
              childCount: postCategories!.length,
            ),
          ),
        ),
        if (loading!)
          SliverToBoxAdapter(
            child: buildLoading(context, isLoading: canLoadMore!),
          ),
      ],
    );
  }
}

import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/post/post.dart';
import 'package:cirilla/screens/post/widgets/post_action.dart';
import 'package:cirilla/screens/post/widgets/post_image.dart';
import 'package:flutter/material.dart';

import '../widgets/post_block.dart';

class LayoutStack extends StatelessWidget with AppBarMixin {
  final Post? post;
  final Map<String, dynamic>? styles;
  final Map<String, dynamic>? configs;
  final List<dynamic>? rows;
  final bool enableBlock;

  LayoutStack({
    Key? key,
    this.post,
    this.styles,
    this.configs,
    this.rows,
    this.enableBlock = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        buildAppbar(context),
        SliverToBoxAdapter(
          child: PostBlock(
            post: post,
            rows: rows,
            styles: styles,
            enableBlock: enableBlock,
          ),
        ),
      ],
    );
  }

  Widget buildAppbar(BuildContext context) {
    double paddingTop = MediaQuery.of(context).padding.top;
    double width = MediaQuery.of(context).size.width;

    double widthLeft = 92;
    double widthImage = width - widthLeft;
    double heightImage = (widthImage * 292) / 284;

    return SliverAppBar(
      expandedHeight: heightImage - paddingTop,
      stretch: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const <StretchMode>[
          StretchMode.zoomBackground,
        ],
        centerTitle: true,
        background: SizedBox(
          width: width,
          height: heightImage,
          child: Row(
            children: [
              SizedBox(
                width: widthLeft,
                child: Column(
                  children: [
                    const SizedBox(height: 44),
                    leadingPined(),
                    const SizedBox(height: 32),
                    PostAction(post: post, axis: Axis.vertical, configs: configs),
                  ],
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(60)),
                  child: PostImage(post: post, width: widthImage, height: double.infinity),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

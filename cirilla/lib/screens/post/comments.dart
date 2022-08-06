import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/app_bar_mixin.dart';
import 'package:cirilla/models/post/post_comment.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/store/post_comment/post_comment_store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/utils/date_format.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ui/ui.dart';

import 'comment_form.dart';

class Comments extends StatefulWidget {
  final int? post;
  final PostComment? parent;
  final int top;
  final RequestHelper? requestHelper;

  const Comments({Key? key, this.post, this.parent, this.requestHelper, required this.top}) : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  PostCommentStore? _commentStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _commentStore = PostCommentStore(
      widget.requestHelper,
      post: widget.post,
      parent: widget.parent != null ? widget.parent!.id : 0,
      key: 'post',
    )..getPostComments();
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return Observer(
      builder: (_) {
        List<PostComment> comments = _commentStore!.postComments;

        if (widget.top == 0) {
          return Column(
            children: [
              ...List.generate(comments.length, (index) {
                final comment = comments[index];
                return buildItem(comment: comment, first: index == 0);
              }),
              if (_commentStore!.loading) buildLoading(context: context) else buildMore(top: widget.top),
            ],
          );
        }

        return Container(
          child: comments.isNotEmpty
              ? InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, _, __) => CommentsModal(
                          requestHelper: widget.requestHelper,
                          post: widget.post,
                          parent: widget.parent,
                        ),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          Offset begin = const Offset(0.0, 1.0);
                          Offset end = Offset.zero;
                          Curve curve = Curves.ease;

                          Animatable<Offset> tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    width: 101,
                    height: 23,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: borderRadiusTiny,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FeatherIcons.cornerDownRight, size: 14, color: Theme.of(context).colorScheme.onSurface),
                        const SizedBox(width: 4),
                        if (comments.length > 1)
                          Text(translate('comment_feedbacks', {'count': '${comments.length}'}),
                              style: Theme.of(context).textTheme.overline),
                        if (comments.length == 1)
                          Text(translate('comment_feedback', {'count': '${comments.length}'}),
                              style: Theme.of(context).textTheme.overline),
                      ],
                    ),
                  ),
                )
              : Container(),
        );
      },
    );
  }

  Widget buildLoading({BuildContext? context}) {
    return SpinKitThreeBounce(
      color: Theme.of(context!).primaryColor,
      size: 30.0,
    );
  }

  Widget buildMore({int? top = 0}) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return Container(
      padding: const EdgeInsetsDirectional.only(end: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_commentStore!.canLoadMore)
            OutlinedButton(
              onPressed: () => _commentStore!.getPostComments(),
              style: OutlinedButton.styleFrom(
                shape: const RoundedRectangleBorder(borderRadius: borderRadius),
                padding: paddingHorizontalLarge,
              ),
              child: Text(translate('comment_show_more')),
            ),
          if (_commentStore!.canLoadMore) const SizedBox(width: itemPaddingMedium),
          CommentForm(commentStore: _commentStore),
        ],
      ),
    );
  }

  Widget buildItem({required PostComment comment, bool? first}) {
    return Column(
      children: [
        CommentHorizontalItem(
          name: Text(
            comment.authorName!,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          image: comment.avatar!.large!,
          onClick: () => {},
          comment: Html(
            data: comment.content!.rendered,
            style: {
              "body": Style(margin: EdgeInsets.zero),
              "p": Style(margin: const EdgeInsets.only(top: 11, bottom: itemPaddingMedium)),
            },
          ),
          date: Text(formatDate(date: comment.date!), style: Theme.of(context).textTheme.caption),
          reply: Row(
            children: [
              CommentForm(type: 'text', commentStore: _commentStore, parent: comment.id),
              const SizedBox(width: itemPaddingMedium),
              if (comment.children!)
                Comments(
                  post: comment.post,
                  requestHelper: widget.requestHelper,
                  parent: comment,
                  top: 1,
                )
            ],
          ),
        ),
        const Padding(
          padding: paddingVerticalLarge,
          child: Divider(height: 0),
        ),
      ],
    );
  }
}

class CommentsModal extends StatelessWidget with AppBarMixin {
  final int? post;
  final PostComment? parent;
  final RequestHelper? requestHelper;

  const CommentsModal({Key? key, this.post, this.parent, this.requestHelper}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: leading(),
              title: Text(translate('comment_reply')),
            ),
            SliverToBoxAdapter(
              child: Padding(
                  padding: paddingHorizontal,
                  child: Column(children: [
                    CommentHorizontalItem(
                      name: Text(
                        parent!.authorName!,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      image: parent!.avatar!.large!,
                      onClick: () => {},
                      comment: Html(
                        data: parent!.content!.rendered,
                        style: {
                          "body": Style(margin: EdgeInsets.zero),
                          "p": Style(margin: const EdgeInsets.only(top: 11)),
                        },
                      ),
                      date: Text(
                        formatDate(date: parent!.date!),
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    const Padding(
                      padding: paddingVerticalLarge,
                      child: Divider(height: 0),
                    ),
                  ])),
            ),
            SliverPadding(
              padding: const EdgeInsetsDirectional.only(start: itemPadding * 5, end: layoutPadding),
              sliver: SliverToBoxAdapter(
                child: Comments(
                  requestHelper: requestHelper,
                  post: post,
                  parent: parent,
                  top: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

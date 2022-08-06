import 'package:cirilla/constants/app.dart';
import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/screens/screens.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ui/ui.dart';

class PostCommentWidget extends StatefulWidget {
  final WidgetConfig? widgetConfig;

  const PostCommentWidget({
    Key? key,
    this.widgetConfig,
  }) : super(key: key);

  @override
  State<PostCommentWidget> createState() => _PostCommentWidgetState();
}

class _PostCommentWidgetState extends State<PostCommentWidget> with Utility, NavigationMixin {
  SettingStore? _settingStore;

  late AppStore _appStore;

  PostCommentStore? _postCommentStore;

  @override
  void didChangeDependencies() {
    _appStore = Provider.of<AppStore>(context);
    _settingStore = Provider.of<SettingStore>(context);

    String language = _settingStore?.locale ?? defaultLanguage;
    Map<String, dynamic> fields = widget.widgetConfig?.fields ?? {};
    int limit = ConvertData.stringToInt(get(fields, ['limit'], '4'));

    // Add store to list store
    if (widget.widgetConfig != null && _appStore.getStoreByKey(widget.widgetConfig!.id) == null) {
      PostCommentStore store = PostCommentStore(_settingStore!.requestHelper,
          perPage: limit, lang: language, key: widget.widgetConfig!.id, order: 'desc')
        ..getPostComments();
      _appStore.addStore(store);
      _postCommentStore ??= store;
    } else {
      _postCommentStore = _appStore.getStoreByKey(widget.widgetConfig!.id);
    }

    super.didChangeDependencies();
  }

  Widget buildDate(String strDate, TextStyle? style) {
    DateTime date = strDate != '' ? DateTime.parse(strDate) : DateTime.now();
    return Text(DateFormat('MM/d/y', 'en_US').format(date), style: style);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    String themeModeKey = _settingStore?.themeModeKey ?? 'value';

    // Styles
    Map<String, dynamic> styles = widget.widgetConfig?.styles ?? {};
    Map? margin = get(styles, ['margin'], {});
    Map? padding = get(styles, ['padding'], {});
    Color background = ConvertData.fromRGBA(get(styles, ['background', themeModeKey], {}), Colors.transparent);

    // Config general
    Map<String, dynamic> fields = widget.widgetConfig?.fields ?? {};
    int limit = ConvertData.stringToInt(get(fields, ['limit'], '4'));
    bool? enableAvatar = get(fields, ['enableAvatar'], true);
    bool? enableDate = get(fields, ['enableDate'], true);
    bool? enableExcerpt = get(fields, ['enableExcerpt'], true);

    return Observer(builder: (_) {
      if (_postCommentStore == null) return Container();

      bool loading = _postCommentStore!.loading;
      List<PostComment> postComments = _postCommentStore!.postComments;

      return Container(
        margin: ConvertData.space(margin, 'margin'),
        padding: ConvertData.space(padding, 'padding'),
        color: background,
        child: loading
            ? Column(
                children: List.generate(
                  limit,
                  (_) => Container(
                    padding: paddingVerticalLarge,
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1, color: theme.dividerColor)),
                    ),
                    child: CommentHorizontalPost(
                      onClick: () => {},
                      name: Container(height: 18, width: double.infinity, color: theme.canvasColor),
                      post: Container(),
                      image: enableAvatar!
                          ? Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(color: theme.canvasColor, shape: BoxShape.circle),
                            )
                          : null,
                      comment: enableExcerpt!
                          ? Container(height: 14, width: double.infinity, color: theme.canvasColor)
                          : null,
                      padding: paddingVerticalLarge,
                    ),
                  ),
                ),
              )
            : Column(
                children: postComments
                    .map(
                      (PostComment item) => Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1, color: theme.dividerColor)),
                        ),
                        child: CommentHorizontalPost(
                          name: RichText(
                            text: TextSpan(
                              text: item.authorName,
                              style: theme.textTheme.subtitle2,
                              children: const [TextSpan(text: ' on')],
                            ),
                          ),
                          post: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              textStyle: theme.textTheme.button,
                            ),
                            onPressed: () => Navigator.pushNamed(
                              context,
                              PostScreen.routeName,
                              arguments: {
                                'id': get(item.postData, ['ID'], 0)
                              },
                            ),
                            child: Text(get(item.postData, ['post_title'], '')),
                          ),
                          date: enableDate! ? buildDate(item.date ?? '', theme.textTheme.caption) : null,
                          image: enableAvatar!
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: CirillaCacheImage(
                                    item.avatar?.medium ?? '',
                                    width: 48,
                                    height: 48,
                                  ),
                                )
                              : null,
                          comment: enableExcerpt!
                              ? Html(
                                  data: '<div>${item.content?.rendered ?? ''}</div>',
                                  style: {
                                    "div": Style(fontSize: const FontSize(12)),
                                    "body": Style(margin: EdgeInsets.zero),
                                    "p": Style(margin: EdgeInsets.zero),
                                  },
                                )
                              : null,
                          padding: paddingVerticalLarge,
                          onClick: () {
                            avoidPrint('Comment');
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
      );
    });
  }
}

import 'package:cirilla/models/models.dart';
import 'package:cirilla/store/post/post_store.dart';
import 'package:cirilla/store/setting/setting_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'widgets/body.dart';
import 'widgets/refine.dart';
import 'widgets/sort.dart';

class PostListScreen extends StatefulWidget {
  static const routeName = '/post_list';

  final SettingStore? store;
  final Map<String, dynamic>? args;

  const PostListScreen({Key? key, this.store, this.args}) : super(key: key);

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PostStore? _postStore;
  String? _title;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    String lang = widget.store!.locale;
    _postStore = PostStore(widget.store!.requestHelper, lang: lang);

    if (widget.args != null && widget.args!['id'] != null && widget.args!['name'] != null) {
      _title = widget.args!['name'];
      _postStore!.onChanged(
        categorySelected: [PostCategory(id: widget.args!['id'], name: widget.args!['name'])],
        silent: true,
      );
    }

    if (widget.args != null &&
        widget.args!['category'] != null &&
        widget.args!['category'].runtimeType == PostCategory) {
      _title = widget.args!['category'].name;
      _postStore!.onChanged(categorySelected: [widget.args!['category']], silent: true);
    }

    if (widget.args != null && widget.args!['tag'] != null && widget.args!['tag'].runtimeType == PostTag) {
      _title = widget.args!['tag'].name;
      _postStore!.onChanged(tagSelected: [widget.args!['tag']], silent: true);
    }

    if (!_postStore!.loading) {
      _postStore!.getPosts();
    }

    if (!_postStore!.postCategoryStore!.loading) {
      _postStore!.postCategoryStore!.getPostCategories();
    }

    if (!_postStore!.postTagStore!.loading) {
      _postStore!.postTagStore!.getPostTags();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Configs
    Data data = widget.store!.data!.screens!['postList']!;
    WidgetConfig? widgetConfig = data.widgets!['postList'];

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        bottom: false,
        child: Observer(
          builder: (_) => Body(
            store: _postStore,
            loading: _postStore!.loading,
            sort: Sort(
              value: _postStore!.sort,
              onChanged: _postStore!.onChanged,
            ),
            refine: Refine(store: _postStore),
            styles: widgetConfig!.styles,
            configs: data.configs,
            title: _title,
          ),
        ),
      ),
    );
  }
}

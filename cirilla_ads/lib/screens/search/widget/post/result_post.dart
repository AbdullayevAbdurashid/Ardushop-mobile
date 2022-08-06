import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/screens/screens.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/store/search/search_post_store.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/notification/notification_screen.dart';

class ResultPost extends StatefulWidget {
  final String? search;
  final Function? clearText;

  const ResultPost({
    Key? key,
    this.search,
    this.clearText,
  }) : super(key: key);

  @override
  State<ResultPost> createState() => _ResultPostState();
}

class _ResultPostState extends State<ResultPost> {
  SearchPostStore? searchPostStore;
  SettingStore? settingStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    settingStore = Provider.of<SettingStore>(context);
    searchPostStore = SearchPostStore(settingStore!.persistHelper);
  }

  @override
  Widget build(BuildContext context) {
    AppStore appStore = Provider.of<AppStore>(context);
    SettingStore settingStore = Provider.of<SettingStore>(context);
    PostStore? postStore;
    TranslateType translate = AppLocalizations.of(context)!.translate;
    if (appStore.getStoreByKey('post_search_$widget.search') == null) {
      if (widget.search!.trim() != '') {
        searchPostStore?.addSearch(widget.search.toString());
      }
      postStore = PostStore(
        Provider.of<RequestHelper>(context),
        search: widget.search,
        key: 'post_search_$widget.search',
        lang: settingStore.locale,
      );
    } else {
      postStore = appStore.getStoreByKey('post_search_$widget.search');
      if (widget.search!.trim() != '') {
        searchPostStore?.addSearch(widget.search.toString());
      }
      return ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(postStore!.posts[index].title!.rendered!),
            onTap: () {
              // close(context, snapshot.data[index].id);
              Post post = postStore!.posts[index];
              Navigator.pushNamed(context, '${PostScreen.routeName}/${post.id}/${post.slug}',
                  arguments: {'post': post});
            },
          );
        },
        itemCount: postStore?.posts.length ?? 0,
      );
    }
    return FutureBuilder<List<Post>>(
      future: postStore.getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (widget.search!.trim() != '') {
            searchPostStore?.addSearch(widget.search.toString());
          }
          return snapshot.data!.isNotEmpty
              ? ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index].title!.rendered!),
                      onTap: () {
                        // close(context, snapshot.data[index].id);
                        Post post = postStore!.posts[index];
                        Navigator.pushNamed(
                          context,
                          '${PostScreen.routeName}/${post.id}/${post.slug}',
                          arguments: {'post': post},
                        );
                      },
                    );
                  },
                  itemCount: snapshot.data?.length ?? 0,
                )
              : NotificationScreen(
                  title: Text(translate('post_search_results'), style: Theme.of(context).textTheme.headline6),
                  content: Padding(
                      padding: paddingHorizontal,
                      child: Text(
                        translate('post_no_post_were_found'),
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      )),
                  iconData: FeatherIcons.search,
                  textButton: Text(
                    translate('product_clear'),
                    style: TextStyle(color: Theme.of(context).textTheme.subtitle1!.color),
                  ),
                  styleBtn: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 61),
                      primary: Theme.of(context).colorScheme.surface,
                      shadowColor: Colors.transparent),
                  onPressed: () {
                    widget.clearText?.call();
                  },
                );
        } else {
          if (widget.search!.trim() != '') {
            searchPostStore?.addSearch(widget.search.toString());
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

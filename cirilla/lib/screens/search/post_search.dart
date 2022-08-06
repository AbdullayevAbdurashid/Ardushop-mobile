import 'package:cirilla/screens/search/widget/post/result_post.dart';
import 'package:cirilla/screens/search/widget/post/search_post.dart';
import 'package:cirilla/types/types.dart';
import 'package:flutter/material.dart';

class PostSearchDelegate extends SearchDelegate<String?> {
  PostSearchDelegate(BuildContext context, TranslateType translate)
      : super(
            searchFieldLabel: translate('post_category_search'),
            searchFieldStyle: Theme.of(context).textTheme.bodyText2);

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back_outlined),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty || query == "") Container();
    return SearchPost(
      search: query,
      onChange: (String? title) {
        query = title ?? '';
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ResultPost(
      search: query,
      clearText: () {
        query = '';
        showSuggestions(context);
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      if (query.isEmpty)
        IconButton(
          tooltip: 'Close',
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        )
      else
        IconButton(
          tooltip: 'Clear',
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  void close(BuildContext context, String? result) {
    super.close(context, result);
  }
}

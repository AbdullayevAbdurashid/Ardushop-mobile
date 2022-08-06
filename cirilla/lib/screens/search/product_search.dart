import 'package:cirilla/types/types.dart';
import 'package:flutter/material.dart';

import 'widget/product/result_product.dart';
import 'widget/product/search_product.dart';

class ProductSearchDelegate extends SearchDelegate<String?> {
  ProductSearchDelegate(BuildContext context, TranslateType translate)
      : super(
          searchFieldLabel: translate('product_category_search'),
          searchFieldStyle: Theme.of(context).textTheme.bodyText2,
        );

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
    return Search(
      search: query,
      onChange: (String? title) {
        query = title ?? '';
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Result(
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

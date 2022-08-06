import 'package:cirilla/models/location/prediction.dart';
import 'package:cirilla/service/service.dart';
import 'package:cirilla/types/types.dart';
import 'package:flutter/material.dart';
import 'search_location/results.dart';
import 'search_location/search.dart';

class SearchLocationScreen extends SearchDelegate<Prediction> {
  final apiClient = GooglePlaceApiHelper();
  List<Prediction> _data = [];
  SearchLocationScreen(
    BuildContext context,
    TranslateType translate, {
    Key? key,
    apiClient,
  }) : super(
          searchFieldLabel: translate('address_search'),
          searchFieldStyle: Theme.of(context).textTheme.bodyText2,
        );
  setDataSearch(List<Prediction> data) {
    _data = data;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          Navigator.pop(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(
          context,
          Prediction(
            description: '',
            structuredFormatting: StructuredFormatting(
              mainText: '',
              mainTextMatchedSubstrings: [],
              secondaryText: '',
            ),
            matchedSubstrings: [],
            types: [],
            terms: [],
          ),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Results(
      search: query,
      apiClient: apiClient,
      data: _data,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Search(
      search: query,
      apiClient: apiClient,
      setDataSearch: setDataSearch,
      dataSearch: _data,
    );
  }
}

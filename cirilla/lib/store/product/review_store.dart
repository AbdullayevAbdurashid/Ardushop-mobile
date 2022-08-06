import 'package:cirilla/models/product_review/product_review.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/utils/query.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'review_store.g.dart';

class ProductReviewStore = ProductReviewStoreBase with _$ProductReviewStore;

abstract class ProductReviewStoreBase with Store {
  final String? key;

  // Request helper instance
  final RequestHelper _requestHelper;

  // Constructor: ------------------------------------------------------------------------------------------------------
  ProductReviewStoreBase(
    this._requestHelper, {
    this.key,
    String? lang,
    int? perPage,
    int? productId,
  }) {
    if (lang != null) _lang = lang;
    if (productId != null) _productId = productId;
    if (perPage != null) _perPage = perPage;
    _include = ObservableList<int>.of([]);

    getRatingCount(queryParameters: {'product_id': productId});
    _reaction();
  }

  // Store variables: --------------------------------------------------------------------------------------------------
  static ObservableFuture<List<ProductReview>> emptyProductReviewResponse = ObservableFuture.value([]);

  @observable
  ObservableFuture<List<ProductReview>?> fetchReviewsFuture = emptyProductReviewResponse;

  @observable
  ObservableList<ProductReview> _reviews = ObservableList<ProductReview>.of([]);

  @observable
  bool success = false;

  @observable
  int _perPage = 10;

  @observable
  int? _productId;

  @observable
  String? _lang;

  @observable
  int _nextPage = 1;

  @observable
  bool _canLoadMore = true;

  @observable
  Map _sort = {
    'key': 'latest',
    'query': {
      'order': 'desc',
      'orderby': 'date',
    }
  };

  @observable
  RatingCount _ratingCount = RatingCount(r1: 0, r2: 0, r3: 0, r4: 0, r5: 0);

  @observable
  ObservableList<int> _include = ObservableList<int>.of([]);

  // Computed:----------------------------------------------------------------------------------------------------------
  @computed
  bool get loading => fetchReviewsFuture.status == FutureStatus.pending;

  @computed
  int? get productId => _productId;

  @computed
  int get nextPage => _nextPage;

  @computed
  ObservableList<ProductReview> get reviews => _reviews;

  @computed
  bool get canLoadMore => _canLoadMore;

  @computed
  Map get sort => _sort;

  @computed
  int get perPage => _perPage;

  @computed
  RatingCount get ratingCount => _ratingCount;

  // Actions: ----------------------------------------------------------------------------------------------------------
  @action
  Future<List<ProductReview>> getReviews() async {
    final qs = {
      "page": _nextPage,
      "per_page": _perPage,
      "order": _sort['query']['order'],
      "orderby": _sort['query']['orderby'],
      "include": _include.map((e) => e).toList().join(','),
      "product": _productId,
      "lang": _lang,
    };

    final future = _requestHelper.getReviews(queryParameters: preQueryParameters(qs));

    fetchReviewsFuture = ObservableFuture(future);

    return future.then((reviews) {
      // Replace state in the first time or refresh
      if (_nextPage <= 1) {
        _reviews = ObservableList<ProductReview>.of(reviews!);
      } else {
        // Add reviews when load more page
        _reviews.addAll(ObservableList<ProductReview>.of(reviews!));
      }

      // Check if can load more item
      if (reviews.length >= _perPage) {
        _nextPage++;
      } else {
        _canLoadMore = false;
      }
      return _reviews;
    }).catchError((error) {
      throw error;
    });
  }

  Future<ProductReview> writeReview({Map<String, dynamic>? data}) async {
    var formData = FormData.fromMap(data!);
    return _requestHelper.writeReviews(data: formData);
  }

  Future<RatingCount> getRatingCount({Map<String, dynamic>? queryParameters}) async {
    RatingCount ratingCount = await _requestHelper.getRatingCount(queryParameters: queryParameters);
    _ratingCount = ratingCount;
    return ratingCount;
  }

  @action
  Future<void> refresh() {
    _canLoadMore = true;
    _nextPage = 1;
    _reviews.clear();
    return getReviews();
  }

  @action
  void onChanged({Map? sort, String? search, bool silent = false}) {
    if (sort != null) _sort = sort;
    if (!silent) refresh();
  }

  // Disposers: --------------------------------------------------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _reaction() {
    _disposers = [
      reaction((_) => _sort, (dynamic key) => refresh()),
    ];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}

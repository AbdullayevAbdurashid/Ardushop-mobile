import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/product/product.dart';
import 'package:cirilla/models/product_review/product_review.dart';
import 'package:cirilla/store/product/review_store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:cirilla/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'product_review_form.dart';

class ProductReviewList extends StatefulWidget {
  final Product? product;
  final ProductReviewStore? store;

  const ProductReviewList({Key? key, this.product, this.store}) : super(key: key);

  @override
  State<ProductReviewList> createState() => _ProductReviewListState();
}

class _ProductReviewListState extends State<ProductReviewList>
    with AppBarMixin, TransitionMixin, ScrollMixin, LoadingMixin {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_controller.hasClients || widget.store!.loading || !widget.store!.canLoadMore) return;
    final thresholdReached = _controller.position.extentAfter < endReachedThreshold;

    if (thresholdReached) {
      widget.store!.getReviews();
    }
  }

  @override
  void didChangeDependencies() {
    widget.store!.getReviews();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return Observer(builder: (_) {
      int limit = 10;
      bool loading = widget.store?.loading ?? true;
      List<ProductReview> reviews = widget.store?.reviews ?? [];

      List<ProductReview> emptyReviews = List.generate(limit, (index) => ProductReview()).toList();
      bool isShimmer = reviews.isEmpty && loading;

      List<ProductReview> data = isShimmer ? emptyReviews : reviews;

      return Scaffold(
        key: scaffoldKey,
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 70,
          alignment: Alignment.center,
          child: SizedBox(
            height: 34,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) => ProductReviewForm(
                      store: widget.store,
                      productId: widget.product!.id,
                      product: BasicProductReview(
                        product: widget.product,
                      ),
                    ),
                    transitionsBuilder: slideTransition,
                  ),
                );
              },
              child: Text(translate('product_write_review')),
            ),
          ),
        ),
        body: CustomScrollView(
          controller: _controller,
          slivers: [
            SliverAppBar(
              leading: leading(),
              centerTitle: true,
              elevation: 0,
              floating: true,
              pinned: true,
              title: Text(translate('product_reviews'), style: Theme.of(context).textTheme.subtitle1),
            ),
            SliverToBoxAdapter(
              child: BasicProductReview(
                product: widget.product,
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: paddingHorizontal.add(paddingVerticalLarge),
                    child: BasicInfoReview(
                      product: widget.product,
                      store: widget.store,
                    ),
                  ),
                  const Divider(height: 1, thickness: 1),
                ],
              ),
            ),
            SliverPadding(
              padding: paddingHorizontal,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return CirillaReviewProductItem(review: data[index]);
                  },
                  childCount: data.length,
                ),
              ),
            ),
            if (widget.store!.loading)
              SliverToBoxAdapter(
                child: buildLoading(context, isLoading: widget.store!.canLoadMore),
              ),
          ],
        ),
      );
    });
  }
}

class BasicInfoReview extends StatelessWidget {
  final Product? product;
  final ProductReviewStore? store;

  const BasicInfoReview({Key? key, this.product, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        double? rating = ConvertData.stringToDouble(product!.averageRating);
        int? ratingCount = product!.ratingCount;
        int? r1 = store!.ratingCount.r1;
        int? r2 = store!.ratingCount.r2;
        int? r3 = store!.ratingCount.r3;
        int? r4 = store!.ratingCount.r4;
        int? r5 = store!.ratingCount.r5;

        return ReviewBasicWidget(
          rating: rating,
          countRating: ratingCount,
          countStar1: r1,
          countStar2: r2,
          countStar3: r3,
          countStar4: r4,
          countStar5: r5,
        );
      },
    );
  }
}

class BasicProductReview extends StatelessWidget with ProductMixin {
  final Product? product;

  const BasicProductReview({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      color: theme.cardColor,
      child: Column(
        children: [
          Padding(
            padding: paddingHorizontal.add(paddingVerticalMedium),
            child: Row(
              children: [
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: theme.dividerColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: buildImage(context, product: product!, width: 50, height: 60),
                ),
                const SizedBox(width: 18),
                Expanded(child: Text(product!.name!, style: theme.textTheme.bodyText2)),
                const SizedBox(width: 18),
                buildPrice(context, product: product!),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1),
        ],
      ),
    );
  }
}

class ReviewBasicWidget extends StatelessWidget {
  final double? rating;
  final int? countRating;
  final int? countStar1;
  final int? countStar2;
  final int? countStar3;
  final int? countStar4;
  final int? countStar5;

  const ReviewBasicWidget({
    Key? key,
    this.rating,
    this.countRating,
    this.countStar1,
    this.countStar2,
    this.countStar3,
    this.countStar4,
    this.countStar5,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double widthScreen = MediaQuery.of(context).size.width;
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        double maxWidth = constraints.maxWidth;
        double widthView = maxWidth != double.infinity ? maxWidth : widthScreen;

        double valueRating = rating ?? 0;
        int ratingCount = countRating ?? 0;
        int r1 = countStar1 ?? 0;
        int r2 = countStar2 ?? 0;
        int r3 = countStar3 ?? 0;
        int r4 = countStar4 ?? 0;
        int r5 = countStar5 ?? 0;

        List data = [
          {
            'star': 5,
            'reviews': r5,
            'percent': ratingCount > 0 ? (r5 / ratingCount) * 100 : 0,
          },
          {
            'star': 4,
            'reviews': r4,
            'percent': ratingCount > 0 ? (r4 / ratingCount) * 100 : 0,
          },
          {
            'star': 3,
            'reviews': r3,
            'percent': ratingCount > 0 ? (r3 / ratingCount) * 100 : 0,
          },
          {
            'star': 2,
            'reviews': r2,
            'percent': ratingCount > 0 ? (r2 / ratingCount) * 100 : 0,
          },
          {
            'star': 1,
            'reviews': r1,
            'percent': ratingCount > 0 ? (r1 / ratingCount) * 100 : 0,
          },
        ];

        return SizedBox(
          width: widthView,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: theme.primaryColor),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      valueRating.toStringAsFixed(1),
                      style: theme.textTheme.headline4!.copyWith(color: theme.primaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    ratingCount > 1
                        ? translate('product_count_reviews', {'count': ratingCount.toString()})
                        : translate('product_count_review', {'count': ratingCount.toString()}),
                    style: theme.textTheme.caption,
                  ),
                  CirillaRating(value: valueRating),
                ],
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Table(
                  columnWidths: const <int, TableColumnWidth>{
                    0: IntrinsicColumnWidth(),
                    1: IntrinsicColumnWidth(),
                    2: FlexColumnWidth(),
                    3: IntrinsicColumnWidth(),
                    4: IntrinsicColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    for (int i = 0; i < data.length; i++) ...[
                      TableRow(
                        children: [
                          Text(translate('product_star_review', {'visit': '${data[i]['star']}'}),
                              style: theme.textTheme.caption),
                          const SizedBox(width: 16),
                          // Text('aaa'),
                          CirillaAnimationIndicator(
                            value: data[i]['percent'] / 100,
                          ),
                          const SizedBox(width: 10),
                          Text('${(data[i]['percent']).round()}%', style: theme.textTheme.caption),
                        ],
                      ),
                      if (i < data.length - 1)
                        const TableRow(
                          children: [
                            SizedBox(height: 8),
                            SizedBox(height: 8),
                            SizedBox(height: 8),
                            SizedBox(height: 8),
                            SizedBox(height: 8),
                          ],
                        ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

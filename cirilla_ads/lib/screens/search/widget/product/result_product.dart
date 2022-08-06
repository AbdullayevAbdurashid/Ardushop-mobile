import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/screens/screens.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/store/search/search_store.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/notification/notification_screen.dart';

class Result extends StatefulWidget {
  final String? search;
  final Function? clearText;

  const Result({
    Key? key,
    this.search,
    this.clearText,
  }) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  SearchStore? searchStore;
  SettingStore? settingStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    settingStore = Provider.of<SettingStore>(context);
    searchStore = SearchStore(settingStore!.persistHelper);
  }

  @override
  Widget build(BuildContext context) {
    AppStore appStore = Provider.of<AppStore>(context);
    SettingStore settingStore = Provider.of<SettingStore>(context);
    ProductsStore? productStore;
    TranslateType translate = AppLocalizations.of(context)!.translate;
    if (appStore.getStoreByKey('product_search_${widget.search}') == null) {
      if (widget.search!.trim() != '') {
        searchStore!.addSearch(widget.search.toString());
      }
      productStore = ProductsStore(
        Provider.of<RequestHelper>(context),
        search: widget.search,
        key: 'product_search_${widget.search}',
        language: settingStore.locale,
        currency: settingStore.currency,
      );
    } else {
      productStore = appStore.getStoreByKey('product_search_${widget.search}');
      if (widget.search!.trim() != '') {
        searchStore!.addSearch(widget.search.toString());
      }
      return ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ProductSearchItem(
            product: productStore!.products[index],
            searchStore: searchStore,
          );
        },
        itemCount: productStore!.products.length,
      );
    }

    return FutureBuilder<List<Product>>(
      future: productStore.refresh(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (widget.search!.trim() != '') {
            searchStore!.addSearch(widget.search.toString());
          }
          return snapshot.data!.isNotEmpty
              ? ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    return ProductSearchItem(
                      product: snapshot.data![index],
                      searchStore: searchStore,
                    );
                  },
                  itemCount: snapshot.data!.length,
                )
              : NotificationScreen(
                  title: Text(translate('product_search_results'), style: Theme.of(context).textTheme.headline6),
                  content: Padding(
                      padding: paddingHorizontal,
                      child: Text(
                        translate("product_no_products_were_found"),
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
            searchStore!.addSearch(widget.search.toString());
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class ProductSearchItem extends StatelessWidget with ProductMixin {
  final Product? product;
  final SearchStore? searchStore;
  const ProductSearchItem({
    Key? key,
    this.product,
    this.searchStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: buildImage(context, product: product!, width: 60, height: 60),
      title: buildName(context, product: product!),
      subtitle: buildPrice(context, product: product!),
      onTap: () {
        searchStore!.addSearch(product!.name.toString());
        Navigator.pushNamed(
          context,
          '${ProductScreen.routeName}/${product?.id}/${product?.slug}',
          arguments: {'product': product},
        );
      },
    );
  }
}

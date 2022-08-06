import 'package:cirilla/constants/app.dart';
import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../product/product.dart';

class ProductTabWidget extends StatefulWidget {
  final WidgetConfig? widgetConfig;

  const ProductTabWidget({
    Key? key,
    this.widgetConfig,
  }) : super(key: key);

  @override
  State<ProductTabWidget> createState() => _ProductTabWidgetState();
}

class _ProductTabWidgetState extends State<ProductTabWidget> with Utility, SingleTickerProviderStateMixin {
  SettingStore? _settingStore;
  TabController? _tabController;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> fields = widget.widgetConfig?.fields ?? {};
    List items = get(fields, ['items'], []);
    _tabController = TabController(vsync: this, length: items.length);
  }

  void _onChanged(index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    String themeModeKey = _settingStore?.themeModeKey ?? 'value';
    String lang = _settingStore?.locale ?? defaultLanguage;

    // Styles
    Map<String, dynamic> styles = widget.widgetConfig?.styles ?? {};
    Map? margin = get(styles, ['margin'], {});
    Map? padding = get(styles, ['padding'], {});
    Color background = ConvertData.fromRGBA(get(styles, ['background', themeModeKey], {}), Colors.transparent);

    // Config general
    Map<String, dynamic> fields = widget.widgetConfig?.fields ?? {};
    double? pad = ConvertData.stringToDouble(get(fields, ['pad'], '0'));
    List items = get(fields, ['items'], []);

    if (items.isEmpty) {
      return Container();
    }

    String keyListProduct = '${widget.widgetConfig!.id}_index=$_index';

    return Container(
      margin: ConvertData.space(margin, 'margin'),
      padding: ConvertData.space(padding, 'padding'),
      color: background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Theme(
            data: theme.copyWith(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
            child: TabBar(
              labelPadding: const EdgeInsetsDirectional.only(end: 32),
              onTap: _onChanged,
              isScrollable: true,
              labelColor: theme.primaryColor,
              controller: _tabController,
              labelStyle: theme.textTheme.subtitle2,
              unselectedLabelColor: theme.textTheme.subtitle2!.color,
              indicatorWeight: 2,
              indicatorPadding: const EdgeInsetsDirectional.only(end: 32),
              indicatorColor: theme.primaryColor,
              tabs: List.generate(
                items.length,
                (inx) {
                  Map<String, dynamic> item = items[inx];
                  String name = ConvertData.stringFromConfigs(get(item, ['data', 'name'], ''), lang)!;
                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      name,
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          if (items[_index]['data'] is Map<String, dynamic>) ...[
            SizedBox(height: pad),
            ProductListWidget(
              id: keyListProduct,
              key: Key(keyListProduct),
              fields: items[_index]['data'],
              styles: styles,
            ),
          ],
        ],
      ),
    );
  }
}

class ProductListWidget extends StatefulWidget {
  final String? id;
  final Map<String, dynamic>? fields;
  final Map<String, dynamic> styles;

  const ProductListWidget({
    Key? key,
    this.id,
    this.fields = const {},
    this.styles = const {},
  }) : super(key: key);

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> with Utility, PostMixin {
  late AppStore _appStore;
  SettingStore? _settingStore;
  ProductsStore? _productsStore;

  @override
  void didChangeDependencies() {
    _appStore = Provider.of<AppStore>(context);
    _settingStore = Provider.of<SettingStore>(context);

    int limit = ConvertData.stringToInt(get(widget.fields, ['limit'], '4'));
    String? search = get(widget.fields, ['search', _settingStore!.languageKey], '');
    List<dynamic> tags = get(widget.fields, ['tags'], []);
    List<dynamic> categories = get(widget.fields, ['categories'], []);
    List<dynamic> products = get(widget.fields, ['includeProduct'], []);

    // Gen key for store
    List<Product> inProducts = products.map((e) => Product(id: ConvertData.stringToInt(e['key']))).toList();
    List<ProductCategory> cate = categories.map((t) => ProductCategory(id: ConvertData.stringToInt(t['key']))).toList();
    List<int> tagsData = tags.map((t) => ConvertData.stringToInt(t['key'])).toList();

    String? key = StringGenerate.getProductKeyStore(
      widget.id,
      currency: _settingStore!.currency,
      language: _settingStore!.locale,
      includeProduct: inProducts,
      tags: tagsData,
      limit: limit,
      search: search,
    );

    // Add store to list store
    if (widget.id != null && _appStore.getStoreByKey(key) == null) {
      ProductsStore store = ProductsStore(
        _settingStore!.requestHelper,
        key: key,
        perPage: limit,
        search: search,
        sort: Map<String, dynamic>.from({
          'key': 'product_list_default',
          'query': {
            'orderby': 'date',
            'order': 'desc',
          }
        }),
        tag: tagsData,
        category: cate.isNotEmpty ? cate[0] : null,
        include: inProducts,
        language: _settingStore!.locale,
        currency: _settingStore!.currency,
      )..getProducts();
      _appStore.addStore(store);
      _productsStore ??= store;
    } else {
      _productsStore = _appStore.getStoreByKey(key);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (_productsStore == null) return Container();
        String themeModeKey = _settingStore?.themeModeKey ?? 'value';

        bool loading = _productsStore!.loading;
        List<Product> products = _productsStore!.products;

        // Fields config
        double? height = ConvertData.stringToDoubleCanBeNull(get(widget.fields, ['height'], null));

        // Item template
        String? layout = get(widget.fields, ['layoutItem'], Strings.productLayoutList);

        // general config
        int limit = ConvertData.stringToInt(get(widget.fields, ['limit'], 4));
        List<Product> emptyProducts = List.generate(limit, (index) => Product()).toList();
        bool isShimmer = products.isEmpty && loading;

        return SizedBox(
          height: layout != Strings.productLayoutCarousel && layout != Strings.productLayoutSlideshow ? null : height,
          child: LayoutProductList(
            fields: widget.fields,
            styles: widget.styles,
            products: isShimmer ? emptyProducts : products,
            layout: layout,
            themeModeKey: themeModeKey,
            onLoadMore: () => _productsStore!.getProducts(),
            canLoadMore: _productsStore!.canLoadMore,
            loading: loading,
          ),
        );
      },
    );
  }
}

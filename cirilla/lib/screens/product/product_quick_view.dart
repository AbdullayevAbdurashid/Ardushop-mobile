import 'package:cirilla/mixins/mixins.dart';

import 'package:cirilla/models/models.dart';
import 'package:cirilla/models/product/product_type.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/store/product/variation_store.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'layout/default.dart';

import 'widgets/product_bottom_bar.dart';
import 'widgets/product_category.dart';
import 'widgets/product_name.dart';
import 'widgets/product_rating.dart';
import 'widgets/product_price.dart';
import 'widgets/product_type.dart';
import 'widgets/product_quantity.dart';
import 'widgets/product_description.dart';
import 'widgets/product_addition_information.dart';
import 'widgets/product_review.dart';
import 'widgets/product_sort_description.dart';
import 'widgets/product_status.dart';
import 'widgets/product_add_to_cart.dart';
import 'widgets/product_action.dart';
import 'widgets/product_custom.dart';
import 'widgets/product_store.dart';
import 'widgets/product_featured_image.dart';

class ProductQuickView extends StatefulWidget {
  const ProductQuickView({Key? key, this.args, this.store}) : super(key: key);

  final Map? args;
  final SettingStore? store;

  @override
  State<ProductQuickView> createState() => _ProductQuickViewState();
}

class _ProductQuickViewState extends State<ProductQuickView> with Utility, SnackMixin, LoadingMixin, NavigationMixin {
  late AppStore _appStore;
  RequestHelper? _requestHelper;
  late CartStore _cartStore;

  // Add to cart loading
  bool _addToCartLoading = false;

  Product? _product;
  int _qty = 1;
  VariationStore? _variationStore;
  Map<int?, int> _groupQty = {};

  bool _loading = true;

  @override
  void didChangeDependencies() async {
    _appStore = Provider.of<AppStore>(context);
    _requestHelper = Provider.of<RequestHelper>(context);
    _cartStore = Provider.of<AuthStore>(context).cartStore;

    if (widget.args != null && widget.args!['product'] != null) {
      setState(() {
        _loading = false;
      });
      _product = widget.args!['product'];
    } else if (widget.args!['id'] != null) {
      await getProduct(ConvertData.stringToInt(widget.args!['id']));
    } else if (widget.args!['variation_id'] != null) {
      await getProductVariation(widget.args!['variation_id']);
    }
    init();
    super.didChangeDependencies();
  }

  void init() {
    if (_product != null && _product!.type == ProductType.variable) {
      String key = 'variation_${_product!.id} - ${widget.store!.locale}';
      if (_appStore.getStoreByKey(key) == null) {
        VariationStore store = VariationStore(
          _requestHelper,
          productId: _product!.id,
          key: key,
          lang: widget.store!.locale,
        )..getVariation();
        _appStore.addStore(store);
        _variationStore ??= store;
      } else {
        _variationStore = _appStore.getStoreByKey(key);
      }
    }
  }

  Future<void> getProductVariation(int? id) async {
    try {
      Product product = await _requestHelper!.getProduct(id: id);
      await getProduct(product.parentId);
    } catch (e) {
      showError(context, e);
    }
  }

  Future<void> getProduct(int? id) async {
    try {
      _product = await _requestHelper!.getProduct(id: id);
      setState(() {
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      showError(context, e);
    }
  }

  void setLoading(bool value) {
    setState(() {
      _addToCartLoading = value;
    });
  }

  void _updateGroupQty({required Product product, qty = 1}) {
    Map<int?, int> groupQty = Map<int?, int>.of(_groupQty);
    if (_groupQty.containsKey(product.id)) {
      groupQty.update(product.id, (value) => qty);
    } else {
      groupQty.putIfAbsent(product.id, () => qty);
    }
    setState(() {
      _groupQty = groupQty;
    });
  }

  ///
  /// Handle add to cart
  Future<void> _handleAddToCart([bool? goCartPage]) async {
    if (_product!.type == ProductType.external) {
      await launch(_product!.externalUrl!);
      return;
    }

    if (_product == null || _product!.id == null) return;
    setLoading(true);
    try {
      TranslateType translate = AppLocalizations.of(context)!.translate;

      // Check product variable
      if (_product!.type == ProductType.variable) {
        // Exist variation store not exist
        if (_variationStore == null || !_variationStore!.canAddToCart) {
          showError(context, translate('product_add_to_cart_error_option'));
          setLoading(false);
          return;
        }

        // Prepare variation data for cart
        List<Map<String, dynamic>> variation = _variationStore!.selected.entries
            .map((e) => {
                  'attribute': e.key,
                  'value': e.value,
                })
            .toList();
        await _cartStore.addToCart({
          'id': _variationStore!.productVariation!.id,
          'quantity': _qty,
          'variation': variation,
        });
      } else if (_product!.type == ProductType.grouped) {
        if (_groupQty.keys.isEmpty) {
          showError(context, translate('product_add_to_cart_error_group'));
          setLoading(false);
          return;
        }
        int i = 0;
        List<int?> keys = _groupQty.keys.toList();
        await Future.doWhile(() async {
          await _cartStore.addToCart({'id': keys[i], 'quantity': _groupQty[keys[i]]});
          i++;
          return i < keys.length;
        });
      } else {
        await _cartStore.addToCart({'id': _product!.id, 'quantity': _qty});
      }
      if (mounted) showSuccess(context, AppLocalizations.of(context)!.translate('product_add_to_cart_success'));
      setState(() {
        _addToCartLoading = false;
        _qty = 1;
      });
      if (goCartPage == true && mounted) {
        navigate(context, {
          'type': 'tab',
          'route': '/',
          'args': {'key': 'screens_cart'}
        });
      }
    } catch (e) {
      showError(context, e);
      setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.store!.data == null) return Container();

    SettingStore settingStore = Provider.of<SettingStore>(context);
    String themeModeKey = settingStore.themeModeKey;

    if (_loading) {
      return Scaffold(
        body: Center(child: buildLoading(context, isLoading: _loading)),
      );
    }

    return Observer(builder: (_) {
      // Settings
      Data data = widget.store!.data!.screens!['productQuickView']!;
      bool? extendBodyBehindAppBar = get(data.configs, ['extendBodyBehindAppBar'], true);
      bool enableBottomBar = get(data.configs, ['enableBottomBar'], false);
      bool enableCartIcon = get(data.configs, ['enableCartIcon'], false);
      String? cartIconType = get(data.configs, ['cartIconType'], 'pinned');
      String? floatingActionButtonLocation = get(data.configs, ['floatingActionButtonLocation'], 'centerDocked');

      // Configs
      WidgetConfig configs = data.widgets!['productQuickView']!;

      // Style
      Color background = ConvertData.fromRGBA(
          get(configs.styles, ['background', themeModeKey]), Theme.of(context).scaffoldBackgroundColor);

      // Build Product Content
      List<dynamic>? rows = get(configs.fields, ['rows'], []);

      List<Widget> rowList = buildRows(rows, background: background, themeModeKey: themeModeKey);

      Widget? bottomBar = enableBottomBar
          ? ProductBottomBar(
              configs: data.configs,
              product: _variationStore != null && _variationStore!.productVariation != null
                  ? _variationStore!.productVariation
                  : _product,
              onPress: _handleAddToCart,
              loading: _addToCartLoading,
              qty: ProductQuantity(
                qty: _qty,
                onChanged: (int value) {
                  setState(() {
                    _qty = value;
                  });
                },
              ),
            )
          : null;

      Widget? cartIcon = enableCartIcon ? buildCartIcon(context) : null;

      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (_, controller) {
          return ProductLayoutDefault(
            controller: controller,
            product: _product,
            appbar: null,
            bottomBar: bottomBar,
            slideshow: null,
            productInfo: rowList,
            extendBodyBehindAppBar: extendBodyBehindAppBar,
            cartIcon: cartIcon,
            cartIconType: cartIconType,
            floatingActionButtonLocation: floatingActionButtonLocation,
          );
        },
      );
    });
  }

  Widget buildCartIcon(BuildContext context) {
    return FloatingActionButton(
      onPressed: _handleAddToCart,
      child: _addToCartLoading
          ? entryLoading(context, color: Theme.of(context).colorScheme.onPrimary)
          : const Icon(Icons.shopping_cart),
      // backgroundColor: Theme.of(context).primaryColor,
    );
  }

  List<Widget> buildRows(List<dynamic>? rows, {Color background = Colors.white, String? themeModeKey}) {
    if (rows == null) return [Container()];

    return rows.map((e) {
      String? mainAxisAlignment = get(e, ['data', 'mainAxisAlignment'], 'start');
      String? crossAxisAlignment = get(e, ['data', 'crossAxisAlignment'], 'start');
      bool divider = get(e, ['data', 'divider'], false);
      List<dynamic>? columns = get(e, ['data', 'columns']);

      return Container(
        color: background,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: ConvertData.mainAxisAlignment(mainAxisAlignment),
              crossAxisAlignment: ConvertData.crossAxisAlignment(crossAxisAlignment),
              children: buildColumn(columns, themeModeKey: themeModeKey),
            ),
            if (divider)
              const Divider(
                height: 1,
                thickness: 1,
                endIndent: 20,
                indent: 20,
              ),
          ],
        ),
      );
    }).toList();
  }

  List<Widget> buildColumn(List<dynamic>? columns, {String? themeModeKey}) {
    if (columns == null) return [Container()];
    return columns.map((e) {
      ProductDetailValue configs = ProductDetailValue.fromJson(get(e, ['value'], {}));
      String? type = get(e, ['value', 'type'], '');

      int flex = ConvertData.stringToInt(get(e, ['value', 'flex'], '1'), 1);

      bool? expand = get(e, ['value', 'expand'], false);

      EdgeInsetsDirectional margin = ConvertData.space(
        get(e, ['value', 'margin'], null),
        'margin',
        EdgeInsetsDirectional.zero,
      );

      EdgeInsetsDirectional padding = ConvertData.space(
        get(e, ['value', 'padding'], null),
        'padding',
        const EdgeInsetsDirectional.only(start: 20, end: 20),
      );

      String align = get(e, ['value', 'align'], 'left');

      Color foreground = ConvertData.fromRGBA(
          get(e, ['value', 'foreground', themeModeKey]), Theme.of(context).scaffoldBackgroundColor);

      // Removed block Type
      if ((type == ProductBlocks.type && _product!.type == ProductType.simple) ||
          (type == ProductBlocks.type && _product!.type == ProductType.external)) {
        return Container();
      }

      // Removed block Quantity
      if (type == ProductBlocks.quantity && _product!.type == ProductType.external) {
        return Container();
      }

      return Expanded(
        flex: flex,
        child: Container(
          margin: margin,
          padding:
              type == ProductBlocks.relatedProduct || type == ProductBlocks.upsellProduct ? EdgeInsets.zero : padding,
          color: foreground,
          child: buildBlock(
            type,
            padding: padding,
            align: align,
            expand: expand,
            configs: configs,
          ),
        ),
      );
    }).toList();
  }

  Widget buildBlock(
    String? type, {
    EdgeInsetsDirectional margin = EdgeInsetsDirectional.zero,
    EdgeInsetsDirectional padding = EdgeInsetsDirectional.zero,
    bool? expand = false,
    String align = 'left',
    required ProductDetailValue configs,
  }) {
    if (type == ProductBlocks.quantity && _product!.type == ProductType.grouped) {
      return Container();
    }

    switch (type) {
      case ProductBlocks.category:
        return ProductCategoryList(product: _product, align: align);
      case ProductBlocks.name:
        return ProductName(product: _product, align: align);
      case ProductBlocks.rating:
        return ProductRating(product: _product, align: align);
      case ProductBlocks.price:
        return ProductPrice(
          product: _variationStore != null && _variationStore!.productVariation != null
              ? _variationStore!.productVariation
              : _product,
          align: align,
        );
      case ProductBlocks.status:
        return ProductStatus(
            product: _variationStore != null && _variationStore!.productVariation != null
                ? _variationStore!.productVariation
                : _product,
            align: align);
      case ProductBlocks.featuredImage:
        return FeaturedImage(images: _product!.images);
      case ProductBlocks.type:
        return ProductTypeWidget(
          product: _product,
          store: _variationStore,
          align: align,
          qty: _groupQty,
          onChanged: _updateGroupQty,
        );
      case ProductBlocks.quantity:
        return ProductQuantity(
          qty: _qty,
          onChanged: (int value) {
            setState(() {
              _qty = value;
            });
          },
          align: align,
        );
      case ProductBlocks.sortDescription:
        return ProductSortDescription(product: _product);
      case ProductBlocks.description:
        return ProductDescription(
          product: _product,
          expand: expand,
          align: align,
        );
      case ProductBlocks.additionInformation:
        return ProductAdditionInformation(
          product: _product,
          expand: expand,
          align: align,
        );
      case ProductBlocks.review:
        return ProductReview(
          product: _product,
          expand: expand,
          align: align,
        );
      case ProductBlocks.addToCart:
        return ProductAddToCart(
          product: _variationStore != null && _variationStore!.productVariation != null
              ? _variationStore!.productVariation
              : _product,
          onPress: _handleAddToCart,
          loading: _addToCartLoading,
        );
      case ProductBlocks.action:
        return ProductAction(product: _product, align: align);
      case ProductBlocks.custom:
        return ProductCustom(configs: configs);
      case ProductBlocks.store:
        return ProductStore(product: _product);
      default:
        return Text(type!);
    }
  }
}

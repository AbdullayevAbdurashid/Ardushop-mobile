import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/utils/debug.dart';
import 'package:cirilla/widgets/widgets.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:recase/recase.dart';
import 'package:cirilla/extension/strings.dart';

import 'package:cirilla/models/models.dart';
import 'package:cirilla/models/product/product_type.dart';
import 'package:cirilla/screens/auth/login_screen.dart';
import 'package:cirilla/screens/product/widgets/product_addons.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/store/app_store.dart';
import 'package:cirilla/store/auth/auth_store.dart';
import 'package:cirilla/store/cart/cart_store.dart';
import 'package:cirilla/store/product/variation_store.dart';
import 'package:cirilla/store/setting/setting_store.dart';
import 'package:cirilla/store/product_recently/product_recently_store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:ui/notification/notification_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'layout/default.dart';
import 'layout/zoom.dart';
import 'layout/scroll.dart';

import 'widgets/product_appbar.dart';
import 'widgets/product_bottom_bar.dart';
import 'widgets/product_brand.dart';
import 'widgets/product_slideshow.dart';
import 'widgets/product_category.dart';
import 'widgets/product_name.dart';
import 'widgets/product_rating.dart';
import 'widgets/product_price.dart';
import 'widgets/product_type.dart';
import 'widgets/product_quantity.dart';
import 'widgets/product_description.dart';
import 'widgets/product_related.dart';
import 'widgets/product_upsell.dart';
import 'widgets/product_addition_information.dart';
import 'widgets/product_review.dart';
import 'widgets/product_sort_description.dart';
import 'widgets/product_status.dart';
import 'widgets/product_add_to_cart.dart';
import 'widgets/product_action.dart';
import 'widgets/product_custom.dart';
import 'widgets/product_store.dart';
import 'widgets/product_advanced_custom_field.dart';

class ProductScreen extends StatefulWidget {
  static const String routeName = '/product';

  const ProductScreen({Key? key, this.args, this.store}) : super(key: key);

  final Map? args;
  final SettingStore? store;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with Utility, SnackMixin, LoadingMixin, NavigationMixin, GeneralMixin, AppBarMixin {
  late AppStore _appStore;
  RequestHelper? _requestHelper;
  late CartStore _cartStore;
  late AuthStore _authStore;
  ProductRecentlyStore? _productRecentStore;

  // Add to cart loading
  bool _addToCartLoading = false;

  Product? _product;
  int _qty = 1;
  VariationStore? _variationStore;
  Map<int?, int> _groupQty = {};
  Map<String, dynamic> _addOns = {};

  bool _loading = true;

  @override
  void didChangeDependencies() async {
    _appStore = Provider.of<AppStore>(context);
    _requestHelper = Provider.of<RequestHelper>(context);
    _authStore = Provider.of<AuthStore>(context);
    _cartStore = _authStore.cartStore;
    _productRecentStore = Provider.of<AuthStore>(context).productRecentlyStore;

    Map<String, dynamic> query = {'lang': widget.store?.locale, 'currency': widget.store?.currency};
    if (widget.args != null && widget.args?['product'] != null) {
      setState(() {
        _loading = false;
      });
      Product p = widget.args!['product'];
      _product = p;
      _productRecentStore?.addProductRecently(p.id.toString());
    } else if (widget.args?['id'] != null && widget.args?['type'] == 'variable') {
      await getProductVariation(ConvertData.stringToInt(widget.args!['id']), query);
    } else if (widget.args?['id'] != null) {
      await getProduct(ConvertData.stringToInt(widget.args!['id']), query);
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
          currency: widget.store?.currency,
        )..getVariation();
        _appStore.addStore(store);
        _variationStore ??= store;
      } else {
        _variationStore = _appStore.getStoreByKey(key);
      }
    }
  }

  Future<void> getProductVariation(int? id, Map<String, dynamic> query) async {
    try {
      Product product = await _requestHelper!.getProduct(id: id, queryParameters: query);
      await getProduct(product.parentId, query);
    } catch (e) {
      showError(context, e);
    }
  }

  Future<void> getProduct(int? id, Map<String, dynamic> query) async {
    try {
      Product p = await _requestHelper!.getProduct(id: id, queryParameters: query);
      _product = p;
      _productRecentStore?.addProductRecently(p.id.toString());
      setState(() {
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
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

  Map<String, String?> _preAddons() {
    Map<String, String> addOns = {};
    for (var key in _addOns.keys) {
      dynamic value = _addOns[key];
      if (value is String) {
        addOns.putIfAbsent(key, () => value);
      } else if (value is List<String>) {
        for (int i = 0; i < value.length; i++) {
          String v = _addOns[key][i];
          String v1 = v.toLowerCase().normalize.removeSymbols;
          addOns.putIfAbsent('$key[$i]', () => v1.paramCase);
        }
      } else if (value is SelectType) {
        addOns.putIfAbsent(key, () => value.value);
      }
    }
    return addOns;
  }

  ///
  /// Handle add to cart
  Future<void> _handleAddToCart([bool? goCartPage]) async {
    if (_product!.type == ProductType.external) {
      await launch(_product!.externalUrl!);
      return;
    }

    if (getConfig(widget.store!, ['forceLoginAddToCart'], false) && !_authStore.isLogin) {
      Navigator.of(context).pushNamed(
        LoginScreen.routeName,
        arguments: {
          'showMessage': ({String? message}) {
            avoidPrint('Login Success');
          }
        },
      );
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
        List<Map<String, dynamic>> variation = _variationStore!.selected.entries.map((e) {
          bool isInlineAttribute = _variationStore!.data!['attribute_ids'][e.key] == 0;
          return {
            'attribute': isInlineAttribute ? _variationStore!.data!['attribute_labels'][e.key] : e.key,
            'value': e.value,
          };
        }).toList();

        // Add to cart
        await _cartStore.addToCart({
          'id': _variationStore!.productVariation!.id,
          'quantity': _qty,
          'variation': variation,
          ..._preAddons(),
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
        await _cartStore.addToCart({'id': _product!.id, 'quantity': _qty, ..._preAddons()});
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

  _updateCartData(Map<String, dynamic> data) {
    setState(() {
      _addOns = data;
    });
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

    if (_product == null) {
      return Scaffold(
        appBar: baseStyleAppBar(context, title: ''),
        body: NotificationScreen(
          title:
              Text(AppLocalizations.of(context)!.translate('product_no'), style: Theme.of(context).textTheme.headline6),
          content: Text(AppLocalizations.of(context)!.translate('product_you_currently'),
              style: Theme.of(context).textTheme.bodyText2),
          iconData: FeatherIcons.box,
          textButton: Text(AppLocalizations.of(context)!.translate('product_back')),
          styleBtn: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 61)),
          onPressed: () => Navigator.pop(context),
        ),
      );
    }

    return Observer(builder: (_) {
      // Settings
      Data data = widget.store!.data!.screens!['product']!;
      String? appBarType = get(data.configs, ['appBarType'], 'floating');
      bool? extendBodyBehindAppBar = get(data.configs, ['extendBodyBehindAppBar'], true);
      bool enableAppbar = get(data.configs, ['enableAppbar'], true);
      bool enableBottomBar = get(data.configs, ['enableBottomBar'], false);
      bool enableCartIcon = get(data.configs, ['enableCartIcon'], false);
      String? cartIconType = get(data.configs, ['cartIconType'], 'pinned');
      String? floatingActionButtonLocation = get(data.configs, ['floatingActionButtonLocation'], 'centerDocked');

      // Configs
      WidgetConfig configs = data.widgets!['productDetailPage']!;

      // Config slideshow size
      dynamic size = get(configs.fields, ['productGallerySize'], {'width': 375, 'height': 440});
      double? height = ConvertData.stringToDouble(size is Map ? size['height'] : '440');

      // Layout
      String layout = configs.layout ?? Strings.productDetailLayoutDefault;

      // Style
      Color background = ConvertData.fromRGBA(
          get(configs.styles, ['background', themeModeKey]), Theme.of(context).scaffoldBackgroundColor);

      // Build Product Content
      List<dynamic>? rows = get(configs.fields, ['rows'], []);

      // Map<String, Widget> blocks = buildBlocksInfo(configs);
      List<Widget> rowList = buildRows(
        rows,
        background: background,
        themeModeKey: themeModeKey,
        languageKey: widget.store?.languageKey,
      );

      Widget? appbar = enableAppbar
          ? ProductAppbar(
              configs: data.configs,
              product: _product,
            )
          : null;

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

      if (layout == Strings.productDetailLayoutZoom) {
        return ProductLayoutZoomSlideshow(
          product: _product,
          appbar: appbar,
          bottomBar: bottomBar,
          slideshow: buildSlideshow(configs),
          productInfo: rowList,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          height: height,
          appBarType: appBarType,
          cartIcon: cartIcon,
          cartIconType: cartIconType,
          floatingActionButtonLocation: floatingActionButtonLocation,
        );
      }

      if (layout == Strings.productDetailLayoutScroll) {
        return ProductLayoutDraggableScrollableSheet(
          product: _product,
          appbar: appbar,
          bottomBar: bottomBar,
          slideshow: buildSlideshow(configs),
          productInfo: rowList,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          // height: height,
          // appBarType: appBarType,
          addToCart: _handleAddToCart,
          addToCartLoading: _addToCartLoading,
          cartIcon: cartIcon,
          cartIconType: cartIconType,
          floatingActionButtonLocation: floatingActionButtonLocation,
        );
      }

      return ProductLayoutDefault(
        product: _product,
        appbar: appbar,
        bottomBar: bottomBar,
        slideshow: buildSlideshow(configs),
        productInfo: rowList,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        cartIcon: cartIcon,
        cartIconType: cartIconType,
        floatingActionButtonLocation: floatingActionButtonLocation,
      );
    });
  }

  Widget buildCartIcon(BuildContext context) {
    bool isOutOfStock = _product?.stockStatus == 'outofstock';
    return FloatingActionButton(
      onPressed: isOutOfStock ? null : _handleAddToCart,
      child: _addToCartLoading
          ? entryLoading(context, color: Theme.of(context).colorScheme.onPrimary)
          : const Icon(Icons.shopping_cart),
      // backgroundColor: Theme.of(context).primaryColor,
    );
  }

  List<Widget> buildRows(
    List<dynamic>? rows, {
    Color background = Colors.white,
    String? themeModeKey,
    String? languageKey,
  }) {
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
              children: buildColumn(
                columns,
                themeModeKey: themeModeKey,
                languageKey: languageKey,
              ),
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

  List<Widget> buildColumn(List<dynamic>? columns, {String? themeModeKey, String? languageKey}) {
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
      String? layoutBlock = get(e, ['value', 'layout'], 'horizontal');

      Color foreground = ConvertData.fromRGBA(
          get(e, ['value', 'foreground', themeModeKey]), Theme.of(context).scaffoldBackgroundColor);

      String textHtml = get(e, ['value', 'textHtml', languageKey], '');
      String typeStatus = get(e, ['value', 'typeStatus'], 'text');

      // Removed block Type
      if ((type == ProductBlocks.type && _product!.type == ProductType.simple) ||
          (type == ProductBlocks.type && _product!.type == ProductType.external)) {
        return Container();
      }

      // Removed block Quantity
      if (type == ProductBlocks.quantity && _product!.type == ProductType.external) {
        return Container();
      }

      // Removed block Add-ons
      if (type == ProductBlocks.addOns && _product!.metaData!.indexWhere((e) => e['key'] == '_product_addons') == -1) {
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
            layoutBlock: layoutBlock,
            expand: expand,
            configs: configs,
            textHtml: textHtml,
            typeStatus: typeStatus,
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
    String? layoutBlock = 'horizontal',
    required ProductDetailValue configs,
    String textHtml = '',
    String typeStatus = 'text',
  }) {
    if (type == ProductBlocks.relatedProduct) {
      return ProductRelated(product: _product, padding: padding, align: align);
    }
    if (type == ProductBlocks.upsellProduct) {
      return ProductUpsell(product: _product, padding: padding, align: align);
    }

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
          align: align,
          typeStatus: typeStatus,
        );
      case ProductBlocks.addOns:
        return ProductAddOns(
          product: _product,
          onChange: _updateCartData,
          value: _addOns,
        );
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
      case ProductBlocks.relatedProduct:
        return ProductRelated(product: _product, padding: padding, align: align);
      case ProductBlocks.upsellProduct:
        return ProductUpsell(product: _product, padding: padding, align: align);
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
      case ProductBlocks.brand:
        return ProductBrandWidget(product: _product, layoutBlock: layoutBlock);
      case ProductBlocks.html:
        return CirillaHtml(html: textHtml);
      case ProductBlocks.advancedField:
        return ProductAdvancedFieldsCustom(
          product: _product,
          align: align,
          fieldName: configs.customFieldName,
        );
      default:
        return Text(type!);
    }
  }

  Widget buildSlideshow(WidgetConfig configs) {
    int scrollDirection = ConvertData.stringToInt(get(configs.fields, ['productGalleryScrollDirection'], 0));

    // Config size
    dynamic size = get(configs.fields, ['productGallerySize'], {'width': 375, 'height': 440});
    double? width = ConvertData.stringToDouble(size is Map ? size['width'] : '375');
    double? height = ConvertData.stringToDouble(size is Map ? size['height'] : '440');

    // Image fit
    String? productGalleryFit = get(configs.fields, ['productGalleryFit'], 'cover');

    return ProductSlideshow(
      images: _variationStore != null &&
              _variationStore!.productVariation != null &&
              _variationStore!.productVariation!.images!.isNotEmpty
          ? _variationStore!.productVariation!.images
          : [],
      product: _variationStore != null &&
              _variationStore!.productVariation != null &&
              _variationStore!.productVariation!.images!.isNotEmpty
          ? _variationStore!.productVariation!
          : _product!,
      scrollDirection: scrollDirection,
      width: width,
      height: height,
      productGalleryFit: productGalleryFit,
      configs: configs,
    );
  }
}

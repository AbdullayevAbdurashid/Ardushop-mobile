// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FilterStore on FilterStoreBase, Store {
  Computed<bool>? _$loadingAttributesComputed;

  @override
  bool get loadingAttributes => (_$loadingAttributesComputed ??=
          Computed<bool>(() => super.loadingAttributes, name: '_FilterStore.loadingAttributes'))
      .value;
  Computed<bool>? _$onSaleComputed;

  @override
  bool get onSale => (_$onSaleComputed ??= Computed<bool>(() => super.onSale, name: '_FilterStore.onSale')).value;
  Computed<bool>? _$inStockComputed;

  @override
  bool get inStock => (_$inStockComputed ??= Computed<bool>(() => super.inStock, name: '_FilterStore.inStock')).value;
  Computed<bool>? _$featuredComputed;

  @override
  bool get featured =>
      (_$featuredComputed ??= Computed<bool>(() => super.featured, name: '_FilterStore.featured')).value;
  Computed<ProductCategory?>? _$categoryComputed;

  @override
  ProductCategory? get category =>
      (_$categoryComputed ??= Computed<ProductCategory?>(() => super.category, name: '_FilterStore.category')).value;
  Computed<RangeValues>? _$rangePricesComputed;

  @override
  RangeValues get rangePrices =>
      (_$rangePricesComputed ??= Computed<RangeValues>(() => super.rangePrices, name: '_FilterStore.rangePrices'))
          .value;
  Computed<ProductPrices>? _$productPricesComputed;

  @override
  ProductPrices get productPrices => (_$productPricesComputed ??=
          Computed<ProductPrices>(() => super.productPrices, name: '_FilterStore.productPrices'))
      .value;
  Computed<ObservableList<Attribute>>? _$attributesComputed;

  @override
  ObservableList<Attribute> get attributes => (_$attributesComputed ??=
          Computed<ObservableList<Attribute>>(() => super.attributes, name: '_FilterStore.attributes'))
      .value;
  Computed<String>? _$valuesComputed;

  @override
  String get values => (_$valuesComputed ??= Computed<String>(() => super.values, name: '_FilterStore.values')).value;
  Computed<ObservableList<ItemAttributeSelected>>? _$attributeSelectedComputed;

  @override
  ObservableList<ItemAttributeSelected> get attributeSelected =>
      (_$attributeSelectedComputed ??= Computed<ObservableList<ItemAttributeSelected>>(() => super.attributeSelected,
              name: '_FilterStore.attributeSelected'))
          .value;

  final _$_attributesAtom = Atom(name: '_FilterStore._attributes');

  @override
  ObservableList<Attribute> get _attributes {
    _$_attributesAtom.reportRead();
    return super._attributes;
  }

  @override
  set _attributes(ObservableList<Attribute> value) {
    _$_attributesAtom.reportWrite(value, super._attributes, () {
      super._attributes = value;
    });
  }

  final _$_productPricesAtom = Atom(name: '_FilterStore._productPrices');

  @override
  ProductPrices get _productPrices {
    _$_productPricesAtom.reportRead();
    return super._productPrices;
  }

  @override
  set _productPrices(ProductPrices value) {
    _$_productPricesAtom.reportWrite(value, super._productPrices, () {
      super._productPrices = value;
    });
  }

  final _$_rangePricesAtom = Atom(name: '_FilterStore._rangePrices');

  @override
  RangeValues get _rangePrices {
    _$_rangePricesAtom.reportRead();
    return super._rangePrices;
  }

  @override
  set _rangePrices(RangeValues value) {
    _$_rangePricesAtom.reportWrite(value, super._rangePrices, () {
      super._rangePrices = value;
    });
  }

  final _$_featuredAtom = Atom(name: '_FilterStore._featured');

  @override
  bool get _featured {
    _$_featuredAtom.reportRead();
    return super._featured;
  }

  @override
  set _featured(bool value) {
    _$_featuredAtom.reportWrite(value, super._featured, () {
      super._featured = value;
    });
  }

  final _$_onSaleAtom = Atom(name: '_FilterStore._onSale');

  @override
  bool get _onSale {
    _$_onSaleAtom.reportRead();
    return super._onSale;
  }

  @override
  set _onSale(bool value) {
    _$_onSaleAtom.reportWrite(value, super._onSale, () {
      super._onSale = value;
    });
  }

  final _$_inStockAtom = Atom(name: '_FilterStore._inStock');

  @override
  bool get _inStock {
    _$_inStockAtom.reportRead();
    return super._inStock;
  }

  @override
  set _inStock(bool value) {
    _$_inStockAtom.reportWrite(value, super._inStock, () {
      super._inStock = value;
    });
  }

  final _$_categoryAtom = Atom(name: '_FilterStore._category');

  @override
  ProductCategory? get _category {
    _$_categoryAtom.reportRead();
    return super._category;
  }

  @override
  set _category(ProductCategory? value) {
    _$_categoryAtom.reportWrite(value, super._category, () {
      super._category = value;
    });
  }

  final _$_loadingAttributesAtom = Atom(name: '_FilterStore._loadingAttributes');

  @override
  bool get _loadingAttributes {
    _$_loadingAttributesAtom.reportRead();
    return super._loadingAttributes;
  }

  @override
  set _loadingAttributes(bool value) {
    _$_loadingAttributesAtom.reportWrite(value, super._loadingAttributes, () {
      super._loadingAttributes = value;
    });
  }

  final _$_attributeSelectedAtom = Atom(name: '_FilterStore._attributeSelected');

  @override
  ObservableList<ItemAttributeSelected> get _attributeSelected {
    _$_attributeSelectedAtom.reportRead();
    return super._attributeSelected;
  }

  @override
  set _attributeSelected(ObservableList<ItemAttributeSelected> value) {
    _$_attributeSelectedAtom.reportWrite(value, super._attributeSelected, () {
      super._attributeSelected = value;
    });
  }

  final _$itemExpandAtom = Atom(name: '_FilterStore.itemExpand');

  @override
  ObservableMap<String?, bool> get itemExpand {
    _$itemExpandAtom.reportRead();
    return super.itemExpand;
  }

  @override
  set itemExpand(ObservableMap<String?, bool> value) {
    _$itemExpandAtom.reportWrite(value, super.itemExpand, () {
      super.itemExpand = value;
    });
  }

  final _$_languageAtom = Atom(name: '_FilterStore._language');

  @override
  String get _language {
    _$_languageAtom.reportRead();
    return super._language;
  }

  @override
  set _language(String value) {
    _$_languageAtom.reportWrite(value, super._language, () {
      super._language = value;
    });
  }

  final _$getAttributesAsyncAction = AsyncAction('_FilterStore.getAttributes');

  @override
  Future<dynamic> getAttributes({Map<String, dynamic>? queryParameters, bool updateStore = true}) {
    return _$getAttributesAsyncAction
        .run(() => super.getAttributes(queryParameters: queryParameters, updateStore: updateStore));
  }

  final _$getMinMaxPricesAsyncAction = AsyncAction('_FilterStore.getMinMaxPrices');

  @override
  Future<void> getMinMaxPrices({ProductCategory? category, bool updateStore = true}) {
    return _$getMinMaxPricesAsyncAction.run(() => super.getMinMaxPrices(category: category, updateStore: updateStore));
  }

  final _$_FilterStoreActionController = ActionController(name: '_FilterStore');

  @override
  void expand(String? key) {
    final $actionInfo = _$_FilterStoreActionController.startAction(name: '_FilterStore.expand');
    try {
      return super.expand(key);
    } finally {
      _$_FilterStoreActionController.endAction($actionInfo);
    }
  }

  @override
  void selectAttribute(ItemAttributeSelected value) {
    final $actionInfo = _$_FilterStoreActionController.startAction(name: '_FilterStore.selectAttribute');
    try {
      return super.selectAttribute(value);
    } finally {
      _$_FilterStoreActionController.endAction($actionInfo);
    }
  }

  @override
  void setMinMaxPrice(double minPrice, double maxPrice) {
    final $actionInfo = _$_FilterStoreActionController.startAction(name: '_FilterStore.setMinMaxPrice');
    try {
      return super.setMinMaxPrice(minPrice, maxPrice);
    } finally {
      _$_FilterStoreActionController.endAction($actionInfo);
    }
  }

  @override
  void onChange(
      {Map<dynamic, dynamic>? sort,
      bool? onSale,
      bool? featured,
      bool? inStock,
      ProductCategory? category,
      ProductPrices? productPrices,
      RangeValues? rangePrices,
      List<Attribute>? attributes,
      List<ItemAttributeSelected>? attributeSelected,
      bool refresh = false}) {
    final $actionInfo = _$_FilterStoreActionController.startAction(name: '_FilterStore.onChange');
    try {
      return super.onChange(
          sort: sort,
          onSale: onSale,
          featured: featured,
          inStock: inStock,
          category: category,
          productPrices: productPrices,
          rangePrices: rangePrices,
          attributes: attributes,
          attributeSelected: attributeSelected,
          refresh: refresh);
    } finally {
      _$_FilterStoreActionController.endAction($actionInfo);
    }
  }

  @override
  void clearAll({ProductCategory? category}) {
    final $actionInfo = _$_FilterStoreActionController.startAction(name: '_FilterStore.clearAll');
    try {
      return super.clearAll(category: category);
    } finally {
      _$_FilterStoreActionController.endAction($actionInfo);
    }
  }

  @override
  void clearCategory({ProductCategory? category}) {
    final $actionInfo = _$_FilterStoreActionController.startAction(name: '_FilterStore.clearCategory');
    try {
      return super.clearCategory(category: category);
    } finally {
      _$_FilterStoreActionController.endAction($actionInfo);
    }
  }

  @override
  String toString() {
    return '''
itemExpand: ${itemExpand},
loadingAttributes: ${loadingAttributes},
onSale: ${onSale},
inStock: ${inStock},
featured: ${featured},
category: ${category},
rangePrices: ${rangePrices},
productPrices: ${productPrices},
attributes: ${attributes},
values: ${values},
attributeSelected: ${attributeSelected}
    ''';
  }
}

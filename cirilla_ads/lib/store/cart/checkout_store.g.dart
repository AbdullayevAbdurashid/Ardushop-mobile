// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CheckoutStore on CheckoutStoreBase, Store {
  final _$loadingAtom = Atom(name: '_CheckoutStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$shipToDifferentAddressAtom = Atom(name: '_CheckoutStore.shipToDifferentAddress');

  @override
  bool get shipToDifferentAddress {
    _$shipToDifferentAddressAtom.reportRead();
    return super.shipToDifferentAddress;
  }

  @override
  set shipToDifferentAddress(bool value) {
    _$shipToDifferentAddressAtom.reportWrite(value, super.shipToDifferentAddress, () {
      super.shipToDifferentAddress = value;
    });
  }

  final _$billingAddressAtom = Atom(name: '_CheckoutStore.billingAddress');

  @override
  Map<String, dynamic> get billingAddress {
    _$billingAddressAtom.reportRead();
    return super.billingAddress;
  }

  @override
  set billingAddress(Map<String, dynamic> value) {
    _$billingAddressAtom.reportWrite(value, super.billingAddress, () {
      super.billingAddress = value;
    });
  }

  final _$shippingAddressAtom = Atom(name: '_CheckoutStore.shippingAddress');

  @override
  Map<String, dynamic> get shippingAddress {
    _$shippingAddressAtom.reportRead();
    return super.shippingAddress;
  }

  @override
  set shippingAddress(Map<String, dynamic> value) {
    _$shippingAddressAtom.reportWrite(value, super.shippingAddress, () {
      super.shippingAddress = value;
    });
  }

  final _$checkoutAsyncAction = AsyncAction('_CheckoutStore.checkout');

  @override
  Future<dynamic> checkout(List<dynamic> paymentData) {
    return _$checkoutAsyncAction.run(() => super.checkout(paymentData));
  }

  final _$changeAddressAsyncAction = AsyncAction('_CheckoutStore.changeAddress');

  @override
  Future<void> changeAddress({Map<String, dynamic>? billing, Map<String, dynamic>? shipping}) {
    return _$changeAddressAsyncAction.run(() => super.changeAddress(billing: billing, shipping: shipping));
  }

  final _$updateAddressAsyncAction = AsyncAction('_CheckoutStore.updateAddress');

  @override
  Future<void> updateAddress() {
    return _$updateAddressAsyncAction.run(() => super.updateAddress());
  }

  final _$_CheckoutStoreActionController = ActionController(name: '_CheckoutStore');

  @override
  void onShipToDifferentAddress() {
    final $actionInfo = _$_CheckoutStoreActionController.startAction(name: '_CheckoutStore.onShipToDifferentAddress');
    try {
      return super.onShipToDifferentAddress();
    } finally {
      _$_CheckoutStoreActionController.endAction($actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
shipToDifferentAddress: ${shipToDifferentAddress},
billingAddress: ${billingAddress},
shippingAddress: ${shippingAddress}
    ''';
  }
}

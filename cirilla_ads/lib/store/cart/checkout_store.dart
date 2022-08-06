import 'package:cirilla/service/helpers/persist_helper.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import 'cart_store.dart';

part 'checkout_store.g.dart';

class CheckoutStore = CheckoutStoreBase with _$CheckoutStore;

abstract class CheckoutStoreBase with Store {
  final CartStore _cartStore;
  final PersistHelper _persistHelper;
  final RequestHelper _requestHelper;

  // Constructor: ------------------------------------------------------------------------------------------------------
  CheckoutStoreBase(this._persistHelper, this._requestHelper, this._cartStore) {
    _init();
    _reaction();
  }

  Future<void> _init() async {}

  // Observable: -------------------------------------------------------------------------------------------------------
  @observable
  bool loading = false;

  @observable
  bool shipToDifferentAddress = false;

  @observable
  Map<String, dynamic> billingAddress = {};

  @observable
  Map<String, dynamic> shippingAddress = {};

  // Action: -----------------------------------------------------------------------------------------------------------
  @action
  Future<dynamic> checkout(List<dynamic> paymentData) async {
    Map<String, dynamic> billing = {...?_cartStore.cartData?.billingAddress, ...billingAddress};

    Map<String, dynamic> shipping = {...?_cartStore.cartData?.shippingAddress, ...shippingAddress};

    try {
      loading = true;
      Map<String, dynamic> cartData = {
        'billing_address': billing,
        'customer_note': '',
        'extensions': {},
        'payment_data': paymentData,
        'payment_method': _cartStore.paymentStore.method,
        'shipping_address': shipping,
        'should_create_account': false,
      };
      Map<String, dynamic> json = await _requestHelper.checkout(
        cartKey: _cartStore.cartKey,
        data: cartData,
        token: _persistHelper.getToken(),
      );
      loading = false;
      return json;
    } on DioError {
      loading = false;
      rethrow;
    }
  }

  @action
  void onShipToDifferentAddress() {
    shipToDifferentAddress = !shipToDifferentAddress;
  }

  @action
  Future<void> changeAddress({Map<String, dynamic>? billing, Map<String, dynamic>? shipping}) async {
    Map<String, dynamic> oldBillingAddress = billingAddress;
    Map<String, dynamic> oldShippingAddress = shippingAddress;

    if (billing != null) billingAddress = billing;
    if (shipping != null) shippingAddress = shipping;

    if ((shipToDifferentAddress && shipping != null && shipping['country'] != oldShippingAddress['country']) ||
        (!shipToDifferentAddress && billing != null && billing['country'] != oldBillingAddress['country'])) {
      await updateAddress();
    }
  }

  @action
  Future<void> updateAddress() async {
    await _cartStore.updateCustomerCart(data: {'shipping_address': shippingAddress, 'billing_address': billingAddress});
  }

  // disposers:---------------------------------------------------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _reaction() {
    _disposers = [];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}

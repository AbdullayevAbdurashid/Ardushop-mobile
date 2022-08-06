import 'package:cirilla/models/auth/user.dart';
import 'package:cirilla/service/helpers/persist_helper.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/store/auth/country_store.dart';
import 'package:cirilla/store/auth/digits_store.dart';
import 'package:cirilla/store/cart/cart_store.dart';
import 'package:cirilla/store/wishlist/wishlist_store.dart';
import 'package:cirilla/store/post_wishlist/post_wishlist_store.dart';
import 'package:cirilla/store/product_recently/product_recently_store.dart';
import 'package:cirilla/utils/debug.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:cirilla/service/messaging.dart';

import 'change_password_store.dart';
import 'forgot_password_store.dart';
import 'login_store.dart';
import 'register_store.dart';
import 'location_store.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final PersistHelper _persistHelper;
  final RequestHelper _requestHelper;

  late LoginStore loginStore;
  late RegisterStore registerStore;
  late DigitsStore digitsStore;
  late ForgotPasswordStore forgotPasswordStore;
  late ChangePasswordStore changePasswordStore;
  late LocationStore locationStore;
  late AddressStore addressStore;
  late WishListStore? wishListStore;
  late ProductRecentlyStore? productRecentlyStore;
  late PostWishListStore? postWishListStore;
  late CartStore cartStore;

  @observable
  bool _isLogin = false;

  @action
  void setLogin(bool value) {
    _isLogin = value;
  }

  @observable
  String? _token;

  @action
  Future<bool> setToken(String value) async {
    _token = value;
    return await _persistHelper.saveToken(value);
  }

  @observable
  User? _user;

  @observable
  bool? _loadingEditAccount;

  @computed
  bool get isLogin => _isLogin;

  @computed
  User? get user => _user;

  @computed
  String? get token => _token;

  @computed
  bool? get loadingEditAccount => _loadingEditAccount;

  // Action: -----------------------------------------------------------------------------------------------------------
  @action
  void setUser(value) {
    _user = value;
  }

  @action
  Future<void> loginSuccess(Map<String, dynamic> data) async {
    try {
      _isLogin = true;
      // In the case data response from digits plugin ex: { "data": { "user": {} }}
      bool isSub = data.containsKey('success') && data.containsKey('data');
      _user = User.fromJson(isSub ? data['data']['user'] : data['user']);
      await setToken(isSub ? data['data']['token'] : data['token']);

      // Update FCM token to database
      String? token = await getToken();
      await updateTokenToDatabase(_requestHelper, token, topics: user?.roles);
    } catch (e) {
      avoidPrint('Error in loginSuccess');
    }
  }

  @action
  Future<bool> logout() async {
    _isLogin = false;
    _token = null;

    // Remove FCM token in database
    String? token = await getToken();
    try {
      await removeTokenInDatabase(_requestHelper, token, _user!.id, topics: _user?.roles);
    } catch (e) {
      avoidPrint('Logout error or not logged!');
    }

    return await _persistHelper.removeToken();
  }

  @action
  Future<bool> editAccount(Map<String, dynamic> data) async {
    _loadingEditAccount = true;
    try {
      await _requestHelper.postAccount(
        userId: _user!.id,
        data: data,
      );
      Map<String, dynamic> userCustomer = _user!.toJson();
      userCustomer.addAll({
        'first_name': data['first_name'] is String ? data['first_name'] : _user!.firstName,
        'last_name': data['last_name'] is String ? data['last_name'] : _user!.lastName,
        'display_name': data['name'] is String ? data['name'] : _user!.displayName,
        'user_email': data['email'] is String ? data['email'] : _user!.userEmail,
      });
      _user = User.fromJson(userCustomer);
      _loadingEditAccount = false;
      return true;
    } on DioError {
      _loadingEditAccount = false;
      rethrow;
    }
  }

  // Constructor: ------------------------------------------------------------------------------------------------------
  AuthStoreBase(this._persistHelper, this._requestHelper) {
    loginStore = LoginStore(_requestHelper, this as AuthStore);
    registerStore = RegisterStore(_requestHelper, this as AuthStore);
    digitsStore = DigitsStore(_requestHelper, this as AuthStore);
    forgotPasswordStore = ForgotPasswordStore(_requestHelper);
    changePasswordStore = ChangePasswordStore(_requestHelper);
    addressStore = AddressStore(_requestHelper);
    wishListStore = WishListStore(_persistHelper);
    productRecentlyStore = ProductRecentlyStore(_persistHelper);
    postWishListStore = PostWishListStore(_persistHelper);
    locationStore = LocationStore(_persistHelper);
    cartStore = CartStore(_persistHelper, _requestHelper, this as AuthStore);
    _init();
  }

  Future _init() async {
    _restore();
  }

  void _restore() async {
    String? token = _persistHelper.getToken();
    if (token != null && token != '') {
      try {
        Map<String, dynamic> json = await _requestHelper.current();
        _user = User.fromJson(json);
        _token = token;
        _isLogin = true;
      } catch (e) {
        await _persistHelper.removeToken();
      }
    }
  }
}

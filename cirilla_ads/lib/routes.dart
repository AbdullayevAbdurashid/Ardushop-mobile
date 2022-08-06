import 'package:flutter/material.dart';

import 'package:cirilla/store/store.dart';
import 'package:cirilla/screens/screens.dart';

///
/// Define route
class Routes {
  Routes._();

  static routes(SettingStore store) => <String, WidgetBuilder>{
        HomeScreen.routeName: (context) => HomeScreen(store: store),

        // Auth
        LoginScreen.routeName: (context) => LoginScreen(store: store),
        RegisterScreen.routeName: (context) => RegisterScreen(store: store),
        ForgotScreen.routeName: (context) => const ForgotScreen(),
        LoginMobileScreen.routeName: (context) => LoginMobileScreen(),

        // On Boarding
        OnBoardingScreen.routeName: (context) => OnBoardingScreen(store: store),

        // Ask permission
        AllowLocationScreen.routeName: (context) => AllowLocationScreen(store: store),

        Checkout.routeName: (context) => const Checkout(),
        CheckoutWebView.routeName: (context) => const CheckoutWebView(),

        AccountScreen.routeName: (context) => const AccountScreen(),
        EditAccountScreen.routeName: (context) => const EditAccountScreen(),
        ChangePasswordScreen.routeName: (context) => const ChangePasswordScreen(),
        AddressBookScreen.routeName: (context) => const AddressBookScreen(),
        AddressShippingScreen.routeName: (context) => const AddressShippingScreen(),
        HelpInfoScreen.routeName: (context) => HelpInfoScreen(store: store),
        SettingScreen.routeName: (context) => const SettingScreen(),
        OrderListScreen.routeName: (context) => const OrderListScreen(),
        ContactScreen.routeName: (context) => ContactScreen(store: store),
        DownloadScreen.routeName: (context) => const DownloadScreen(),
        WalletScreen.routeName: (context) => const WalletScreen(),

        BrandListScreen.routeName: (context) => BrandListScreen(store: store),
        LocationScreen.routeName: (context) => LocationScreen(store: store),
        FormAddressScreen.routeName: (context) => FormAddressScreen(store: store),
        SelectLocationScreen.routeName: (context) => SelectLocationScreen(store: store),

        ChatListScreen.routeName: (context) => ChatListScreen(store: store),
        ChatDetailScreen.routeName: (context) => ChatDetailScreen(store: store),
      };

  static onGenerateRoute(RouteSettings settings, SettingStore store) {
    Uri uri = Uri.parse(settings.name ?? '');
    Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>? ?? Map<String, dynamic>.of({});

    // Temporary fix for callback verify login OTP and Facebook
    if (uri.hasQuery && uri.queryParameters['deep_link_id'] != null) {
      return null;
    }

    // Deeplink has link
    if (uri.hasQuery && uri.queryParameters['link'] != null) {
      String link = uri.queryParameters['link']!;
      uri = Uri.parse(link);
    }

    String? name = uri.pathSegments.length > 1 ? "/${uri.pathSegments[0]}" : settings.name;
    dynamic args = uri.pathSegments.length > 1 ? {'id': uri.pathSegments[1]} : settings.arguments;

    if (RegExp(r'^\/post\/([\d]+)(\/.+)?$').hasMatch(uri.path)) {
      if (!arguments.containsKey('post')) {
        arguments.putIfAbsent('id', () => uri.pathSegments[1]);
      }
      return _getPageRoute(
        routeName: uri.path,
        arguments: args,
        screen: PostScreen(store: store, args: args),
      );
    }

    // Handling product route
    if (RegExp(r'^\/product\/([\d]+)(\/.+)?$').hasMatch(uri.path)) {
      if (!arguments.containsKey('product')) {
        arguments.putIfAbsent('id', () => uri.pathSegments[1]);
      }
      return _getPageRoute(
        routeName: uri.path,
        arguments: arguments,
        screen: ProductScreen(store: store, args: arguments),
      );
    }

    switch (name) {
      case PostListScreen.routeName:
        return _getPageRoute(screen: PostListScreen(store: store, args: args), routeName: name);
      case PostAuthorScreen.routeName:
        return _getPageRoute(screen: PostAuthorScreen(args: args), routeName: name);
      case ProductListScreen.routeName:
        return _getPageRoute(screen: ProductListScreen(store: store, args: args), routeName: name);
      case WebViewScreen.routeName:
        return _getPageRoute(screen: WebViewScreen(args: args), routeName: name);
      case PageScreen.routeName:
        return _getPageRoute(screen: PageScreen(args: args), routeName: name);
      case CustomScreen.routeName:
        return _getPageRoute(screen: CustomScreen(screenKey: args['key']), routeName: name);
      case NotificationList.routeName:
        return _getPageRoute(screen: const NotificationList(), routeName: name);
      case NotificationDetail.routeName:
        return _getPageRoute(screen: NotificationDetail(args: args), routeName: name);
      case VendorScreen.routeName:
        return _getPageRoute(screen: VendorScreen(store: store, args: args), routeName: name);
      case OrderDetailScreen.routeName:
        return _getPageRoute(screen: OrderDetailScreen(args: args), routeName: name);
      default:
        return null;
    }
  }

  static onUnknownRoute(RouteSettings settings) {
    return _getPageRoute(screen: const NotFound(), routeName: '/not-found');
  }
}

PageRoute _getPageRoute({String? routeName, Object? arguments, required Widget screen}) {
  return MaterialPageRoute(
    settings: RouteSettings(
      name: routeName,
      arguments: arguments,
    ),
    builder: (_) => screen,
  );
}

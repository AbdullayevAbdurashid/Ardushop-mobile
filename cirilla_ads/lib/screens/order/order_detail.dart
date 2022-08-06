import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/screens/order/widgets/order_billing.dart';
import 'package:cirilla/screens/order/widgets/order_item.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/models/order/order.dart';
import 'package:cirilla/store/auth/auth_store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:cirilla/types/types.dart';

import '../screens.dart';
import 'widgets/order_node.dart';

class OrderDetailScreen extends StatefulWidget {
  static const routeName = '/order_detail';
  final Map? args;

  const OrderDetailScreen({Key? key, this.args}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen>
    with Utility, LoadingMixin, AppBarMixin, NavigationMixin, OrderMixin, SnackMixin {
  late AuthStore _authStore;
  RequestHelper? _requestHelper;
  OrderData? _orderData;
  bool _loading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authStore = Provider.of<AuthStore>(context);
    _requestHelper = Provider.of<RequestHelper>(context);

    OrderData? data = widget.args!['orderDetail'] is OrderData && widget.args!['orderDetail'].id != null
        ? widget.args!['orderDetail']
        : null;

    if (data != null) {
      setState(() {
        _orderData = data;
        _loading = false;
      });
    } else {
      int id = ConvertData.stringToInt(widget.args!['id']);
      if (id > 0) {
        getOrderDetail(id);
      } else {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> getOrderDetail(int? id) async {
    try {
      OrderData data = await _requestHelper!.getOrderDetail(orderId: id, queryParameters: {});
      setState(() {
        _loading = false;
        _orderData = data;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      showError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    TranslateType translate = AppLocalizations.of(context)!.translate;

    TextTheme textTheme = theme.textTheme;

    Color? textColor = textTheme.subtitle1!.color;

    if (_orderData == null && _loading) {
      return Scaffold(
        appBar: baseStyleAppBar(context, title: translate('order_title', {'id': '#'})),
        body: Center(child: buildLoading(context, isLoading: _loading)),
      );
    }

    Map? billingData = _orderData!.billing;

    Map? shippingData = _orderData!.shipping;

    String? currencySymbol = get(_orderData!.currencySymbol, [], '');

    String? currency = get(_orderData!.currency, [], '');

    final lineItems = _orderData!.lineItems;

    final shippingLines = _orderData!.shippingLines;

    return Observer(
      builder: (_) => Scaffold(
        appBar: baseStyleAppBar(context, title: translate('order_title', {'id': '# ${get(_orderData!.id, [], '')}'})),
        body: ListView(
          padding: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).dividerColor), borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildItem(
                    padding: const EdgeInsetsDirectional.only(
                        start: itemPaddingMedium, end: itemPaddingMedium, top: itemPaddingMedium),
                    title: Text(translate('order_number'), style: textTheme.caption),
                    subTitle: Text(
                      _orderData!.id.toString(),
                      style: textTheme.subtitle2,
                    ),
                    trailing: buildStatus(theme, translate, _orderData!),
                  ),
                  buildItem(
                      padding: const EdgeInsetsDirectional.only(start: itemPaddingMedium),
                      title: Text(translate('order_date'), style: textTheme.caption),
                      subTitle: Text(formatDate(date: _orderData!.dateCreated!), style: textTheme.subtitle2)),
                  buildItem(
                      padding: const EdgeInsetsDirectional.only(start: itemPaddingMedium),
                      title: Text(translate('order_email'), style: textTheme.caption),
                      subTitle: Text(_authStore.user!.userEmail!, style: textTheme.subtitle2)),
                  buildItem(
                      padding: const EdgeInsetsDirectional.only(start: itemPaddingMedium),
                      title: Text(translate('order_total'), style: textTheme.caption),
                      subTitle: Text(
                          formatCurrency(context,
                              currency: _orderData!.currency,
                              price: _orderData!.total,
                              symbol: _orderData!.currencySymbol),
                          style: textTheme.subtitle2)),
                  buildItem(
                      padding: const EdgeInsetsDirectional.only(start: itemPaddingMedium),
                      title: Text(translate('order_payment_method'), style: textTheme.caption),
                      subTitle: Text(_orderData!.paymentMethodTitle ?? '', style: textTheme.subtitle2)),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: itemPaddingMedium, end: itemPaddingMedium, bottom: itemPaddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(translate('order_shipping_method'), style: textTheme.caption),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Text(shippingLines!.map((e) => e.methodTitle).join(' , '),
                                    style: textTheme.subtitle2)),
                            Text(
                                formatCurrency(context,
                                    currency: _orderData!.currency,
                                    price: _orderData!.shippingTotal,
                                    symbol: _orderData!.currencySymbol),
                                style: textTheme.subtitle2)
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            OrderNoteWidget(
              padding: const EdgeInsets.only(top: layoutPadding * 2),
              orderId: _orderData!.id!,
              color: textColor,
            ),
            Padding(
              padding: const EdgeInsets.only(top: layoutPadding * 2, bottom: itemPaddingLarge),
              child: Text(
                translate('order_information'),
                style: textTheme.subtitle1,
              ),
            ),
            ...List.generate(lineItems!.length, (index) {
              LineItems productData = lineItems.elementAt(index);
              int? id = productData.productId;
              return OrderItem(
                productData: productData,
                currency: currency,
                currencySymbol: currencySymbol,
                onClick: () {
                  Navigator.pushNamed(context, '${ProductScreen.routeName}/$id');
                },
              );
            }),
            Padding(
              padding: const EdgeInsets.only(top: layoutPadding * 2, bottom: itemPaddingMedium),
              child: Text(
                translate('order_billing_address'),
                style: textTheme.subtitle1,
              ),
            ),
            Container(
              padding: paddingMedium,
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).dividerColor), borderRadius: BorderRadius.circular(8)),
              child: OrderBilling(billingData: billingData, style: textTheme.bodyText2),
            ),
            Padding(
              padding: const EdgeInsets.only(top: layoutPadding * 2, bottom: itemPaddingMedium),
              child: Text(
                translate('order_shipping_address'),
                style: textTheme.subtitle1,
              ),
            ),
            Container(
              padding: paddingMedium,
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).dividerColor), borderRadius: BorderRadius.circular(8)),
              child: OrderBilling(billingData: shippingData, style: textTheme.bodyText2),
            ),
            const SizedBox(height: layoutPadding * 2),
            buildItem(
                leading: Text(translate('order_shipping'), style: textTheme.caption),
                trailing: Text(
                    formatCurrency(context,
                        currency: _orderData!.currency,
                        price: _orderData!.shippingTotal,
                        symbol: _orderData!.currencySymbol),
                    style: textTheme.caption!.copyWith(color: textColor))),
            buildItem(
                leading: Text(translate('order_shipping_tax'), style: textTheme.caption),
                trailing: Text(
                    formatCurrency(context,
                        currency: _orderData!.currency,
                        price: _orderData!.shippingTax,
                        symbol: _orderData!.currencySymbol),
                    style: textTheme.caption!.copyWith(color: textColor))),
            buildItem(
              leading: Text(translate('order_tax'), style: textTheme.caption),
              trailing: Text(
                formatCurrency(
                  context,
                  currency: _orderData!.currency,
                  price: _orderData!.cartTax,
                  symbol: _orderData!.currencySymbol,
                ),
                style: textTheme.caption!.copyWith(color: textColor),
              ),
            ),
            buildItem(
                leading: Text(translate('order_discount'), style: textTheme.caption),
                trailing: Text(
                    formatCurrency(context,
                        currency: _orderData!.currency,
                        price: _orderData!.discountTotal,
                        symbol: _orderData!.currencySymbol),
                    style: textTheme.caption!.copyWith(color: textColor))),
            buildItem(
                leading: Text(translate('order_discount_tax'), style: textTheme.caption),
                trailing: Text(
                    formatCurrency(context,
                        currency: _orderData!.currency,
                        price: _orderData!.discountTax,
                        symbol: _orderData!.currencySymbol),
                    style: textTheme.caption!.copyWith(color: textColor))),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(translate('order_total'), style: textTheme.subtitle2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                      formatCurrency(
                        context,
                        currency: _orderData!.currency,
                        price: _orderData!.total,
                        symbol: _orderData!.currencySymbol,
                      ),
                      style: textTheme.headline6),
                  Text(translate('order_include'), style: textTheme.overline)
                ],
              )
            ]),
            const SizedBox(height: 48)
          ],
        ),
      ),
    );
  }
}

Widget buildItem(
    {Widget? title,
    Widget? subTitle,
    Widget? leading,
    Widget? trailing,
    EdgeInsetsDirectional? padding,
    bool divider = true}) {
  return Column(
    children: [
      Padding(
          padding: padding ?? EdgeInsetsDirectional.zero,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            if (leading != null) leading,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [title ?? Container(), subTitle ?? Container()],
            ),
            if (trailing != null) trailing
          ])),
      if (divider)
        const Divider(
          height: itemPaddingExtraLarge,
          thickness: 1,
        ),
    ],
  );
}

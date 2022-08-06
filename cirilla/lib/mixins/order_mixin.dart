import 'package:cirilla/constants/color_block.dart';
import 'package:cirilla/models/order/order.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/cirilla_shimmer.dart';
import 'package:cirilla/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

mixin OrderMixin {
  Widget buildCode(ThemeData theme, OrderData order) {
    if (order.id == null) {
      return CirillaShimmer(
        child: Container(
          height: 24,
          width: 80,
          color: Colors.white,
        ),
      );
    }
    return Text(
      'ID: #${order.id}',
      style: theme.textTheme.caption,
    );
  }

  Widget buildName(ThemeData theme, OrderData order) {
    if (order.id == null) {
      return CirillaShimmer(
        child: Container(
          height: 24,
          width: 324,
          color: Colors.white,
        ),
      );
    }
    String text = order.lineItems!.map((e) => e.name).join(' - ');
    return CirillaHtml(html: text);
  }

  Widget buildDate(ThemeData theme, OrderData order) {
    if (order.id == null) {
      return CirillaShimmer(
        child: Container(
          height: 14,
          width: 90,
          color: Colors.white,
        ),
      );
    }
    return Text(formatDate(date: order.dateCreated!), style: theme.textTheme.caption);
  }

  Widget buildTotal(ThemeData theme, TranslateType translate, OrderData order) {
    if (order.id == null) {
      return CirillaShimmer(
        child: Container(
          height: 14,
          width: 70,
          color: Colors.white,
        ),
      );
    }
    return Text(translate('order_total'), style: theme.textTheme.overline);
  }

  Widget buildPrice(BuildContext context, ThemeData theme, OrderData order) {
    if (order.id == null) {
      return CirillaShimmer(
        child: Container(
          height: 18,
          width: 50,
          color: Colors.white,
        ),
      );
    }
    return Text(
      formatCurrency(
        context,
        currency: order.currency,
        price: order.total,
        symbol: order.currencySymbol,
      ),
      style: theme.textTheme.subtitle1,
    );
  }

  Widget buildStatus(ThemeData theme, TranslateType translate, OrderData order) {
    if (order.id == null) {
      return CirillaShimmer(
        child: Container(
          height: 18,
          width: 75,
          color: Colors.white,
        ),
      );
    }
    String status = order.status ?? 'processing';

    Map<String, dynamic> types = {
      'on-hold': ColorBlock.yellow,
      'processing': ColorBlock.blueBase,
      'refund': theme.errorColor,
      'successful': ColorBlock.green,
      'completed': ColorBlock.greenBase,
    };

    String textStatus = status.isNotEmpty ? status[0].toUpperCase() + status.substring(1) : status;

    switch (status) {
      case 'pending':
        textStatus = translate('order_pending');
        break;
      case 'processing':
        textStatus = translate('order_processing');
        break;
      case 'on-hold':
        textStatus = translate('order_on_hold');
        break;
      case 'completed':
        textStatus = translate('order_completed');
        break;
      case 'cancelled':
        textStatus = translate('order_cancelled');
        break;
      case 'refunded':
        textStatus = translate('order_refunded');
        break;
      case 'failed':
        textStatus = translate('order_failed');
        break;
      case 'trash':
        textStatus = translate('order_trash');
        break;
    }
    return Badge(
      text: Text(
        textStatus,
        style: theme.textTheme.overline!.copyWith(color: Colors.white),
      ),
      color: types[status] ?? theme.errorColor,
    );
  }
}

import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:ui/notification/notification_screen.dart';

class StepSuccess extends StatelessWidget with NavigationMixin {
  const StepSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return NotificationScreen(
      title: Text(translate('order_congrats'), style: Theme.of(context).textTheme.headline6),
      content: Text(
        translate('order_thank_you_purchase'),
        style: Theme.of(context).textTheme.bodyText2,
        textAlign: TextAlign.center,
      ),
      iconData: FeatherIcons.check,
      textButton: Text(translate('order_return_shop')),
      onPressed: () => navigate(context, {
        "type": "tab",
        "router": "/",
        "args": {"key": "screens_category"}
      }),
    );
  }
}

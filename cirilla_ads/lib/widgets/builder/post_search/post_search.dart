import 'package:cirilla/models/setting/setting.dart';
import 'package:cirilla/screens/screens.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:flutter/material.dart';
import '../product_search/search_widget.dart';

class PostSearchWidget extends SearchWidget {
  final WidgetConfig widgetConfig;

  const PostSearchWidget({
    Key? key,
    required this.widgetConfig,
  }) : super(
          key: key,
          widgetConfigData: widgetConfig,
        );

  @override
  void onPressed(BuildContext context) async {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    await showSearch<String?>(
      context: context,
      delegate: PostSearchDelegate(context, translate),
    );
  }
}

import 'package:cirilla/utils/convert_data.dart';
import 'package:cirilla/widgets/cirilla_html.dart';
import 'package:flutter_html/flutter_html.dart';

import 'banner_ads.dart';

Map<CustomRenderMatcher, CustomRender> appAdsCustomRenders = {
  classMatcher("mobile-ads"): CustomRender.widget(widget: (context, buildChildren) {
    String type = context.tree.element?.attributes["data-size"] ?? 'banner';
    String? width = context.tree.element?.attributes["data-width"];
    String? height = context.tree.element?.attributes["data-height"];
    return BannerAds(
      adSize: type,
      width: ConvertData.stringToInt(width, 250),
      height: ConvertData.stringToInt(height, 50),
    );
  }),
};
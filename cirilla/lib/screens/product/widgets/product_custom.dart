import 'package:cirilla/mixins/navigation_mixin.dart';
import 'package:cirilla/mixins/utility_mixin.dart';
import 'package:cirilla/models/builder/product_detail_value.dart';
import 'package:cirilla/store/setting/setting_store.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:cirilla/widgets/cirilla_icon_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCustom extends StatelessWidget with Utility, NavigationMixin {
  final ProductDetailValue configs;

  const ProductCustom({Key? key, required this.configs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildLayer(context, configs: configs);
  }

  Widget _buildLayer(BuildContext context, {required ProductDetailValue configs}) {
    ThemeData theme = Theme.of(context);

    SettingStore settingStore = Provider.of<SettingStore>(context);
    String themeModeKey = settingStore.themeModeKey;
    String languageKey = settingStore.languageKey;

    // Text
    String text = get(configs.text, [languageKey], '');
    TextStyle textStyle = ConvertData.toTextStyle(configs.text, themeModeKey);

    Widget child = Text(text, style: textStyle);

    if (configs.customType == 'button') {
      Map<String, dynamic>? buttonBg = get(configs.buttonBg, [themeModeKey], null);
      Map<String, dynamic>? buttonBorderColor = get(configs.buttonBorderColor, [themeModeKey], null);
      double borderWidth = ConvertData.stringToDouble(configs.buttonBorderWidth, 0);

      dynamic size = configs.buttonSize ?? {'width': 80, 'height': 32};
      double? height = ConvertData.stringToDouble(size is Map ? size['height'] : '80');
      double? width = ConvertData.stringToDouble(size is Map ? size['width'] : '32');

      double borderRadius = ConvertData.stringToDouble(configs.buttonBorderRadius, 0);

      child = Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ConvertData.fromRGBA(buttonBg, theme.primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: Border.all(color: ConvertData.fromRGBA(buttonBorderColor, theme.primaryColor), width: borderWidth),
        ),
        child: child,
      );
    }

    if (configs.customType == 'image') {
      String? src = get(configs.image, ['src'], '');
      dynamic size = configs.imageSize ?? {'width': 32, 'height': 32};
      double? height = ConvertData.stringToDouble(size is Map ? size['height'] : '32');
      double? width = ConvertData.stringToDouble(size is Map ? size['width'] : '32');
      child = src != '' ? Image.network(src!, width: width, height: height) : Container();
    }

    if (configs.customType == 'icon') {
      Map<String, dynamic>? icon = configs.icon;
      double? iconSize = configs.imageSize;
      Map<String, dynamic>? iconColor = get(configs.iconColor, [themeModeKey], null);
      child = CirillaIconBuilder(
        data: icon,
        size: iconSize,
        color: ConvertData.fromRGBA(iconColor, theme.primaryColor),
      );
    }

    return InkWell(
      onTap: () => navigate(context, configs.action),
      child: child,
    );
  }
}

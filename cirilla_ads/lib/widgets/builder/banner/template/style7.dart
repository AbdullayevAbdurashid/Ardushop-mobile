import 'package:cirilla/constants/app.dart';
import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/utility_mixin.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:cirilla/widgets/cirilla_cache_image.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class Style7Item extends StatelessWidget with Utility {
  final Map<String, dynamic>? item;
  final Size? size;
  final Color background;
  final double? radius;
  final Function(Map<String, dynamic>? action) onClick;
  final String language;
  final String themeModeKey;

  Style7Item({
    Key? key,
    required this.item,
    required this.onClick,
    this.language = defaultLanguage,
    this.themeModeKey = 'value',
    this.size = const Size(375, 330),
    this.background = Colors.transparent,
    this.radius = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    dynamic image = get(item, ['image'], '');
    BoxFit fit = ConvertData.toBoxFit(get(item, ['imageSize'], 'cover'));
    Map<String, dynamic>? action = get(item, ['action'], {});

    String? linkImage = ConvertData.imageFromConfigs(image, language);

    dynamic title = get(item, ['text1'], {});
    dynamic subTitle = get(item, ['text2'], {});

    String textTitle = ConvertData.stringFromConfigs(title, language)!;
    String textSubtitle = ConvertData.stringFromConfigs(subTitle, language)!;

    TextStyle titleStyle = ConvertData.toTextStyle(title, themeModeKey);
    TextStyle subtitleStyle = ConvertData.toTextStyle(subTitle, themeModeKey);

    String? typeAction = get(action, ['type'], 'none');

    return Container(
      width: size!.width,
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(radius!)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: ImageAlignmentItem(
        image: CirillaCacheImage(
          linkImage,
          width: size!.width,
          height: size!.height,
          fit: fit,
        ),
        title: Text(
          textTitle.toUpperCase(),
          style: theme.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.normal, fontSize: 18).merge(titleStyle),
          textAlign: TextAlign.center,
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(bottom: secondItemPaddingSmall),
          child: Text(
            textSubtitle.toUpperCase(),
            style:
                theme.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.normal, fontSize: 18).merge(subtitleStyle),
            textAlign: TextAlign.center,
          ),
        ),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        width: size!.width,
        onTap: () => typeAction != 'none' ? onClick(action) : null,
      ),
    );
  }
}

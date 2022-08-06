import 'package:cirilla/constants/app.dart';
import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/utility_mixin.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:cirilla/widgets/cirilla_cache_image.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class Style5Item extends StatelessWidget with Utility {
  final Map<String, dynamic>? item;
  final Size? size;
  final Color background;
  final double? radius;
  final Function(Map<String, dynamic>? action) onClick;
  final String language;
  final String themeModeKey;

  Style5Item({
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
    dynamic trailing = get(item, ['text2'], {});
    dynamic leading = get(item, ['text3'], {});

    String textTitle = ConvertData.stringFromConfigs(title, language)!;
    String textTrailing = ConvertData.stringFromConfigs(trailing, language)!;
    String textLeading = ConvertData.stringFromConfigs(leading, language)!;

    TextStyle titleStyle = ConvertData.toTextStyle(title, themeModeKey);
    TextStyle trailingStyle = ConvertData.toTextStyle(trailing, themeModeKey);
    TextStyle leadingStyle = ConvertData.toTextStyle(leading, themeModeKey);

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
        title: Padding(
          padding: secondPaddingVerticalTiny,
          child: Text(
            textTitle,
            style: theme.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.normal).merge(titleStyle),
            textAlign: TextAlign.center,
          ),
        ),
        trailing: Padding(
          padding: secondPaddingVerticalTiny,
          child: Text(
            textTrailing,
            style: theme.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.normal).merge(trailingStyle),
            textAlign: TextAlign.center,
          ),
        ),
        leading: Container(
          padding: secondPaddingVerticalSmall.copyWith(top: 15, bottom: 15),
          margin: secondPaddingVerticalTiny,
          color: leadingStyle.backgroundColor,
          child: Text(
            textLeading,
            style: theme.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.normal).merge(leadingStyle),
            textAlign: TextAlign.center,
          ),
        ),
        width: size!.width,
        onTap: () => typeAction != 'none' ? onClick(action) : null,
      ),
    );
  }
}

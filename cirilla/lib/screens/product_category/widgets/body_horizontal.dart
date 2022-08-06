import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/product_category/product_category.dart';
import 'package:cirilla/models/setting/setting.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/widgets.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'body.dart';
import 'list_category_scroll_load_more.dart';

/// Horizontal layout Category
///
class HorizontalCategory extends Body with LoadingMixin, Utility {
  const HorizontalCategory({
    Key? key,
    List<ProductCategory>? categories,
    WidgetConfig? widgetConfig,
    Map<String, dynamic>? configs,
    String? themeModeKey,
    String? languageKey,
  }) : super(
          key: key,
          categories: categories,
          widgetConfig: widgetConfig,
          configs: configs,
          languageKey: languageKey,
          themeModeKey: themeModeKey,
        );

  List<ProductCategory?>? getListItem(ProductCategory? parent, enableShowAll, positionShowAll) {
    if (enableShowAll) {
      if (positionShowAll == 'start') {
        return [parent, ...parent!.categories!];
      } else {
        return [...parent!.categories!, parent];
      }
    }
    return parent!.categories;
  }

  @override
  Widget buildBody(
    BuildContext context, {
    Widget? appBar,
    Widget? tab,
    ProductCategory? parent,
    Widget? banner,
    WidgetConfig? widgetConfig,
    String? languageKey,
    String? themeModeKey,
  }) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    // Config style view
    String? layoutView = get(widgetConfig!.fields, ['styleView'], Strings.layoutCategoryList);
    int col = ConvertData.stringToInt(get(widgetConfig.fields, ['columnGrid'], 2), 2);
    double? ratio = ConvertData.stringToDouble(get(widgetConfig.fields, ['childAspectRatio'], 1), 1);

    // Config item show all
    bool enableShowAll = get(widgetConfig.fields, ['enableShowAll'], true);
    bool? enableChangeNameShowAll = get(widgetConfig.fields, ['enableChangeNameShowAll'], true);
    String? positionShowAll = get(widgetConfig.fields, ['positionShowAll'], 'start');
    String? textShowAll =
        get(widgetConfig.fields, ['textShowAll', languageKey], translate('product_category_show_all'));

    double? pad = ConvertData.stringToDouble(get(widgetConfig.fields, ['padItem'], 16));

    Map<String, dynamic>? template =
        get(widgetConfig.fields, ['template'], {'template': Strings.productCategoryItemHorizontal, 'data': {}});

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        if (appBar != null) appBar,
        if (banner != null) banner,
        SliverPadding(
          padding: const EdgeInsets.only(bottom: itemPaddingLarge),
          sliver: SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: StickyTabBarDelegate(
              height: 33,
              child: tab!,
            ),
          ),
        ),
        SliverPadding(
          padding: paddingHorizontal,
          sliver: ListCategoryScrollLoadMore(
            categories: getListItem(parent, enableShowAll, positionShowAll),
            layout: layoutView,
            col: col,
            ratio: ratio,
            enableTextShowAll: enableChangeNameShowAll,
            textShowAll: textShowAll,
            idShowAll: parent!.id,
            template: template,
            styles: widgetConfig.styles ?? {},
            pad: pad,
            themeModeKey: themeModeKey,
          ),
        ),
      ],
    );
  }

  @override
  Widget buildTabs(
    BuildContext context, {
    TabController? tabController,
    List<ProductCategory>? categories,
    Function? onChanged,
    WidgetConfig? widgetConfig,
  }) {
    ThemeData theme = Theme.of(context);
    Map<String, dynamic> styles = widgetConfig?.styles ?? {};
    double sizeText = ConvertData.stringToDouble(get(styles, ['sizeText'], 16));
    return Container(
      color: theme.scaffoldBackgroundColor,
      margin: const EdgeInsets.only(left: layoutPadding, right: 4),
      transform: Matrix4.translationValues(-16, 0, 0.0),
      child: TabBar(
        labelPadding: paddingHorizontal,
        onTap: onChanged as void Function(int)?,
        isScrollable: true,
        labelColor: theme.primaryColor,
        controller: tabController,
        labelStyle: theme.textTheme.subtitle2,
        unselectedLabelColor: theme.textTheme.subtitle2!.color,
        indicatorWeight: 2,
        indicatorColor: theme.primaryColor,
        indicatorPadding: paddingHorizontalMedium,
        tabs: List.generate(
          categories!.length,
          (inx) => Container(
            height: 33,
            alignment: Alignment.center,
            child: Text(
              categories[inx].name!,
              style: TextStyle(fontSize: sizeText),
            ),
          ),
        ).toList(),
      ),
    );
  }

  // Build Layout App bar
  @override
  Widget? buildAppBar(BuildContext context, {Map<String, dynamic>? configs}) {
    String? type = get(configs, ['appBarType'], Strings.appbarFloating);
    bool enableSearch = get(configs, ['enableSearch'], true);
    bool? enableCart = get(configs, ['enableCart'], true);

    if (!enableSearch && !enableCart!) {
      return null;
    }
    // ==== Title
    Widget? title = enableSearch ? const SearchProductWidget() : null;

    // ==== Actions
    List<Widget> actions = [
      if (enableCart!)
        const Padding(
          padding: EdgeInsetsDirectional.only(end: 17),
          child: CirillaCartIcon(
            icon: Icon(FeatherIcons.shoppingCart),
            enableCount: true,
            color: Colors.transparent,
          ),
        ),
    ];
    return SliverAppBar(
      floating: type == Strings.appbarFloating,
      elevation: 0,
      primary: true,
      pinned: true,
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: title,
      actions: actions,
      expandedHeight: 73,
      titleSpacing: 20,
    );
  }

  // Build Banner
  @override
  Widget? buildBanner(BuildContext context, {Map<String, dynamic>? configs, String? languageKey}) {
    bool enableBanner = get(configs, ['enableBanner'], true);

    if (!enableBanner) {
      return null;
    }
    return SliverPadding(
      padding: paddingHorizontal.copyWith(bottom: itemPaddingMedium),
      sliver: SliverToBoxAdapter(
        child: BannerWidget(configs: configs, languageKey: languageKey),
      ),
    );
  }
}

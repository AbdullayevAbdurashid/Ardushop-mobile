import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:cirilla/mixins/utility_mixin.dart';
import 'package:cirilla/models/setting/setting.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:cirilla/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tab_item_count.dart';

class Tabs extends StatefulWidget {
  final String? selected;
  final Function? onItemTapped;
  final Data? data;

  const Tabs({
    Key? key,
    this.selected,
    this.onItemTapped,
    this.data,
  }) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> with Utility {
  int _currentIndex = 0;
  int fixedIndex = 0;
  bool active = false;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SettingStore settingStore = Provider.of<SettingStore>(context);
    String themeModeKey = settingStore.themeModeKey;
    String? languageKey = settingStore.languageKey;

    WidgetConfig widgetConfig = widget.data!.widgets!['tabs']!;

    List items = get(widgetConfig.fields, ['items'], []);

    _tabItems() {
      return List.generate(
        items.length,
        (index) {
          final item = items.elementAt(index);
          bool active = get(item, ['active'], false);
          bool enableCount = get(item, ['data', 'enableCount'], false);
          String countType = get(item, ['data', 'countType'], 'Cart');
          if (active) {
            setState(
              () {
                fixedIndex = index;
              },
            );
          }
          return TabItem(
            icon: getIconData(data: get(item, ['data', 'icon'], {'name': 'home', 'type': 'feather'})),
            title: get(item, ['data', 'title', languageKey], ''),
            key: get(item, ['data', 'action', 'args', 'key'], ''),
            count: enableCount ? TabItemCount(type: countType) : null,
          );
        },
      );
    }

    String layoutData = widgetConfig.layout ?? 'default';

    Color background =
        ConvertData.fromRGBA(get(widgetConfig.styles, ['background', themeModeKey], {}), theme.bottomAppBarColor);

    Color textColor = ConvertData.fromRGBA(get(widgetConfig.styles, ['color', themeModeKey], {}), Colors.black);

    Color activeColor =
        ConvertData.fromRGBA(get(widgetConfig.styles, ['colorActive', themeModeKey], {}), theme.primaryColor);

    Color colorOnActive =
        ConvertData.fromRGBA(get(widgetConfig.styles, ['colorOnActive', themeModeKey], {}), theme.primaryColor);

    double? radius = ConvertData.stringToDouble(get(widgetConfig.styles, ['radius'], 0));

    double? activeBorderRadius = ConvertData.stringToDouble(get(widgetConfig.styles, ['activeBorderRadius'], 30));

    bool? enableShadow = get(widgetConfig.styles, ['enableShadow'], true);
    bool? animated = get(widgetConfig.fields, ['animated'], true);
    bool? fixedActive = get(widgetConfig.fields, ['fixedActive'], false);

    double? padTop = ConvertData.stringToDouble(get(widgetConfig.styles, ['padTop'], 12));
    double? pad = ConvertData.stringToDouble(get(widgetConfig.styles, ['pad'], 4));
    double? padBottom = ConvertData.stringToDouble(get(widgetConfig.styles, ['padBottom'], 12));

    BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
    );

    indexSelected() {
      if (fixedActive! && !active) {
        return fixedIndex;
      }
      if (_tabItems().indexWhere((e) => e.key == widget.selected) == -1) {
        return _currentIndex;
      }
      return _tabItems().indexWhere((e) => e.key == widget.selected);
    }

    _onTap(int index) {
      _currentIndex = index;
      active = true;
      widget.onItemTapped!(_tabItems().elementAt(_currentIndex).key);
    }

    Widget styleBottomBar() {
      switch (layoutData) {
        case 'border_top':
          return BottomBarDivider(
            items: _tabItems(),
            colorSelected: activeColor,
            color: textColor,
            indexSelected: indexSelected(),
            backgroundColor: background,
            onTap: _onTap,
            top: padTop,
            bottom: padBottom,
            pad: pad,
            animated: animated!,
            enableShadow: enableShadow,
          );
        case 'border_bottom':
          return BottomBarDivider(
            items: _tabItems(),
            colorSelected: activeColor,
            color: textColor,
            indexSelected: indexSelected(),
            backgroundColor: background,
            onTap: _onTap,
            top: padTop,
            bottom: padBottom,
            pad: pad,
            animated: animated!,
            enableShadow: enableShadow,
            styleDivider: StyleDivider.bottom,
          );
        case 'salomon':
          return BottomBarSalomon(
            items: _tabItems(),
            color: textColor,
            backgroundColor: background,
            colorSelected: colorOnActive,
            backgroundSelected: activeColor,
            top: padTop,
            bottom: padBottom,
            animated: animated!,
            enableShadow: enableShadow,
            borderRadius: borderRadius,
            radiusSalomon: BorderRadius.circular(activeBorderRadius),
            indexSelected: indexSelected(),
            onTap: _onTap,
          );
        case 'inspired_inside':
          return BottomBarInspiredInside(
            items: _tabItems(),
            backgroundColor: background,
            color: textColor,
            colorSelected: colorOnActive,
            indexSelected: indexSelected(),
            animated: animated!,
            isAnimated: false,
            radius: radius,
            padTop: padTop,
            pad: pad,
            fixed: fixedActive!,
            fixedIndex: fixedIndex,
            padbottom: padBottom,
            onTap: _onTap,
            elevation: enableShadow == true ? 5 : 0,
            itemStyle: ItemStyle.circle,
            chipStyle: ChipStyle(convexBridge: true, background: activeColor),
          );
        case 'inspired_inside_hexagon':
          return BottomBarInspiredInside(
            items: _tabItems(),
            backgroundColor: background,
            color: textColor,
            colorSelected: colorOnActive,
            indexSelected: indexSelected(),
            animated: animated!,
            isAnimated: false,
            radius: radius,
            padTop: padTop,
            pad: pad,
            fixed: fixedActive!,
            fixedIndex: fixedIndex,
            padbottom: padBottom,
            elevation: enableShadow == true ? 5 : 0,
            onTap: _onTap,
            itemStyle: ItemStyle.hexagon,
            chipStyle: ChipStyle(isHexagon: true, background: activeColor),
          );
        case 'inspired_outside':
          return BottomBarInspiredOutside(
            items: _tabItems(),
            backgroundColor: background,
            color: textColor,
            colorSelected: colorOnActive,
            indexSelected: indexSelected(),
            animated: animated!,
            isAnimated: false,
            radius: radius,
            padTop: padTop,
            pad: pad,
            fixed: fixedActive!,
            fixedIndex: fixedIndex,
            padbottom: padBottom,
            elevation: enableShadow == true ? 5 : 0,
            onTap: _onTap,
            itemStyle: ItemStyle.circle,
            chipStyle: ChipStyle(notchSmoothness: NotchSmoothness.sharpEdge, background: activeColor),
          );
        case 'inspired_outside_hexagon':
          return BottomBarInspiredOutside(
            items: _tabItems(),
            backgroundColor: background,
            color: textColor,
            colorSelected: colorOnActive,
            indexSelected: indexSelected(),
            animated: animated!,
            isAnimated: false,
            elevation: enableShadow == true ? 5 : 0,
            onTap: _onTap,
            radius: radius,
            padTop: padTop,
            pad: pad,
            fixed: fixedActive!,
            fixedIndex: fixedIndex,
            padbottom: padBottom,
            itemStyle: ItemStyle.hexagon,
            chipStyle:
                ChipStyle(notchSmoothness: NotchSmoothness.defaultEdge, drawHexagon: true, background: activeColor),
          );
        case 'inspired_outside_deep':
          return BottomBarInspiredOutside(
            items: _tabItems(),
            backgroundColor: background,
            color: textColor,
            colorSelected: colorOnActive,
            indexSelected: indexSelected(),
            animated: animated!,
            isAnimated: false,
            elevation: enableShadow == true ? 5 : 0,
            onTap: _onTap,
            radius: radius,
            padTop: padTop,
            pad: pad,
            fixed: fixedActive!,
            fixedIndex: fixedIndex,
            padbottom: padBottom,
            itemStyle: ItemStyle.circle,
            chipStyle: ChipStyle(notchSmoothness: NotchSmoothness.verySmoothEdge, background: activeColor),
          );
        case 'inspired_outside_radius':
          return BottomBarInspiredOutside(
            items: _tabItems(),
            backgroundColor: background,
            color: textColor,
            colorSelected: colorOnActive,
            indexSelected: indexSelected(),
            animated: animated!,
            isAnimated: false,
            elevation: enableShadow == true ? 5 : 0,
            onTap: _onTap,
            radius: radius,
            padTop: padTop,
            pad: pad,
            fixed: fixedActive!,
            fixedIndex: fixedIndex,
            padbottom: padBottom,
            itemStyle: ItemStyle.circle,
            chipStyle: ChipStyle(notchSmoothness: NotchSmoothness.softEdge, background: activeColor),
          );
        case 'inspired_curve':
          return BottomBarCreative(
            items: _tabItems(),
            backgroundColor: background,
            borderRadius: borderRadius,
            color: textColor,
            colorSelected: activeColor,
            enableShadow: enableShadow,
            indexSelected: indexSelected(),
            highlightStyle: HighlightStyle(
              sizeLarge: true,
              background: activeColor,
              color: colorOnActive,
            ),
            top: padTop,
            pad: pad,
            bottom: padBottom,
            isFloating: true,
            onTap: _onTap,
          );
        case 'inspired_curve_hexagon':
          return BottomBarCreative(
            items: _tabItems(),
            backgroundColor: background,
            borderRadius: borderRadius,
            color: textColor,
            colorSelected: activeColor,
            enableShadow: enableShadow,
            indexSelected: indexSelected(),
            highlightStyle: HighlightStyle(
              isHexagon: true,
              sizeLarge: true,
              background: activeColor,
              color: colorOnActive,
            ),
            top: padTop,
            pad: pad,
            bottom: padBottom,
            isFloating: true,
            onTap: _onTap,
          );
        case 'creative':
          return BottomBarCreative(
            items: _tabItems(),
            backgroundColor: background,
            borderRadius: borderRadius,
            color: textColor,
            colorSelected: activeColor,
            enableShadow: enableShadow,
            indexSelected: indexSelected(),
            highlightStyle: HighlightStyle(
              background: activeColor,
              color: colorOnActive,
            ),
            top: padTop,
            pad: pad,
            bottom: padBottom,
            isFloating: false,
            onTap: _onTap,
          );
        case 'creative_hexagon':
          return BottomBarCreative(
            items: _tabItems(),
            backgroundColor: background,
            borderRadius: borderRadius,
            color: textColor,
            colorSelected: activeColor,
            enableShadow: enableShadow,
            indexSelected: indexSelected(),
            highlightStyle: HighlightStyle(
              isHexagon: true,
              sizeLarge: true,
              background: activeColor,
              color: colorOnActive,
            ),
            top: padTop,
            pad: pad,
            bottom: padBottom,
            isFloating: false,
            onTap: _onTap,
          );
        case 'fancy':
          return BottomBarInspiredFancy(
            items: _tabItems(),
            backgroundColor: background,
            color: textColor,
            colorSelected: activeColor,
            top: padTop,
            bottom: padBottom,
            pad: pad,
            borderRadius: borderRadius,
            indexSelected: indexSelected(),
            styleIconFooter: StyleIconFooter.dot,
            animated: animated!,
            enableShadow: enableShadow,
            onTap: _onTap,
          );
        case 'fancy_border':
          return BottomBarInspiredFancy(
            items: _tabItems(),
            backgroundColor: background,
            color: textColor,
            colorSelected: activeColor,
            top: padTop,
            bottom: padBottom,
            pad: pad,
            borderRadius: borderRadius,
            indexSelected: indexSelected(),
            styleIconFooter: StyleIconFooter.divider,
            animated: animated!,
            enableShadow: enableShadow,
            onTap: _onTap,
          );
        case 'floating':
          return Container(
            padding: const EdgeInsets.only(bottom: 30, left: 32, right: 32),
            child: BottomBarFloating(
              items: _tabItems(),
              backgroundColor: background,
              color: textColor,
              colorSelected: activeColor,
              indexSelected: indexSelected(),
              animated: animated!,
              borderRadius: BorderRadius.circular(radius),
              top: padTop,
              bottom: padBottom,
              pad: pad,
              enableShadow: enableShadow,
              onTap: _onTap,
            ),
          );
        case 'default_bg':
          return BottomBarBackground(
            items: _tabItems(),
            backgroundColor: background,
            color: textColor,
            colorSelected: colorOnActive,
            indexSelected: indexSelected(),
            backgroundSelected: activeColor,
            paddingVertical: 25,
            animated: animated!,
            top: padTop,
            pad: pad,
            borderRadius: borderRadius,
            bottom: padBottom,
            onTap: _onTap,
          );
        default:
          return BottomBarDefault(
            items: _tabItems(),
            backgroundColor: background,
            color: textColor,
            colorSelected: activeColor,
            animated: animated!,
            borderRadius: borderRadius,
            enableShadow: enableShadow,
            indexSelected: indexSelected(),
            top: padTop,
            bottom: padBottom,
            pad: pad,
            onTap: _onTap,
          );
      }
    }

    return styleBottomBar();
  }
}

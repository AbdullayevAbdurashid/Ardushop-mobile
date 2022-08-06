import 'package:flutter/material.dart';

class Accordion extends StatefulWidget {
  final int count;
  final IconData icon;
  final IconData activeIcon;
  final Widget Function(int index) buildTitle;
  final Widget Function(int index) buildExpansion;
  final Color? color;
  final Color? dividerColor;

  const Accordion({
    Key? key,
    required this.count,
    this.icon = Icons.add,
    this.activeIcon = Icons.remove,
    required this.buildExpansion,
    required this.buildTitle,
    this.color,
    this.dividerColor,
  })  : assert(count > 0),
        super(key: key);

  @override
  State<Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  List<bool> actives = [];

  @override
  void didChangeDependencies() {
    List<bool> data = List.generate(widget.count, (index) {
      return false;
    });
    setState(() {
      actives = data;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(widget.count, (index) {
          bool active = actives[index];
          return ListTileTheme(
            minLeadingWidth: 38,
            horizontalTitleGap: 0,
            minVerticalPadding: 0,
            contentPadding: EdgeInsets.zero,
            child: Column(
              children: [
                ExpansionTile(
                  leading: buildViewTile(child: Icon(active ? widget.activeIcon : widget.icon, size: 20)),
                  trailing: const SizedBox(),
                  title:
                      buildViewTile(child: widget.buildTitle(index), padding: const EdgeInsets.symmetric(vertical: 12)),
                  tilePadding: EdgeInsets.zero,
                  childrenPadding: const EdgeInsetsDirectional.fromSTEB(38, 0, 16, 16),
                  textColor: widget.color ?? Colors.black,
                  collapsedTextColor: widget.color ?? Colors.black,
                  iconColor: widget.color ?? Colors.black,
                  collapsedIconColor: widget.color ?? Colors.black,
                  onExpansionChanged: (_) {
                    List<bool> data = actives;
                    data[index] = !actives.elementAt(index);
                    setState(() {
                      actives = data;
                    });
                  },
                  children: [
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: widget.buildExpansion(index),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 38),
                  child: Divider(height: 1, thickness: 1, color: widget.dividerColor ?? Colors.black),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget buildViewTile({EdgeInsetsGeometry? padding, Widget? child}) {
    return Container(
      constraints: const BoxConstraints(minHeight: 53),
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [child ?? Container()],
      ),
    );
  }
}

import 'package:flutter/material.dart';

abstract class ContactItem extends StatefulWidget {
  final double? elevationValue;
  final Color? shadowColorValue;
  final ShapeBorder? shapeValue;
  final Color? colorValue;

  const ContactItem({
    Key? key,
    this.elevationValue,
    this.shadowColorValue,
    this.shapeValue,
    this.colorValue,
  }) : super(key: key);

  @override
  State<ContactItem> createState() => _ContactItemState();

  @protected
  Widget buildLayout(BuildContext context);
}

class _ContactItemState extends State<ContactItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: widget.shadowColorValue,
      elevation: widget.elevationValue ?? 0,
      margin: EdgeInsets.zero,
      shape: widget.shapeValue ?? const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      color: widget.colorValue ?? Colors.transparent,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: widget.buildLayout(context),
    );
  }
}

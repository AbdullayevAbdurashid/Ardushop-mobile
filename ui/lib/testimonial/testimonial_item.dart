import 'package:flutter/material.dart';

abstract class TestimonialItem extends StatefulWidget {
  final double? elevationTestimonial;
  final Color? shadowColorTestimonial;
  final ShapeBorder? shapeTestimonial;
  final Color? colorTestimonial;

  const TestimonialItem({
    Key? key,
    this.elevationTestimonial,
    this.shadowColorTestimonial,
    this.shapeTestimonial,
    this.colorTestimonial,
  }) : super(key: key);

  @override
  State<TestimonialItem> createState() => _TestimonialItemState();

  @protected
  Widget buildLayout(BuildContext context);
}

class _TestimonialItemState extends State<TestimonialItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: widget.shadowColorTestimonial,
      elevation: widget.elevationTestimonial ?? 0,
      margin: EdgeInsets.zero,
      shape: widget.shapeTestimonial ?? const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      color: widget.colorTestimonial,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: widget.buildLayout(context),
    );
  }
}

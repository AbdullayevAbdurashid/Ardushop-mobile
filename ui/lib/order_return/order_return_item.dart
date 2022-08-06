import 'package:flutter/material.dart';

class OrderReturnItem extends StatelessWidget {
  /// Widget name. It must required
  final Widget name;

  /// Widget button dateTime
  final Widget? dateTime;

  /// radius order
  final double radius;

  /// Color order of item
  final Color? color;

  /// Function click item
  final Function onClick;

  /// Padding item
  final EdgeInsets padding;

  /// code
  final Widget? code;

  /// status
  final Widget? status;

  /// total
  final Widget? total;

  /// price
  final Widget? price;

  const OrderReturnItem({
    Key? key,
    required this.name,
    required this.onClick,
    this.status,
    this.dateTime,
    this.code,
    this.color,
    this.radius = 8,
    this.padding = EdgeInsets.zero,
    this.total,
    this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Padding(
          padding: padding,
          child: Container(
            padding:const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: color,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          name,
                          const SizedBox(
                            height: 4,
                          ),
                          dateTime ?? Container()
                        ],
                      ),
                    ),
                    code ?? Container(),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (total != null) total ?? Container(),
                          if (price != null) price ?? Container(),
                        ],
                      ),
                    ),
                    status ?? Container(),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

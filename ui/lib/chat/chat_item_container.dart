import 'package:flutter/material.dart';

class ChatItemContainer extends StatelessWidget {
  final Widget image;
  final Widget name;
  final Widget time;
  final Widget message;
  final Widget? count;
  final double width;
  final Color? borderColor;
  final double padBorder;
  final EdgeInsetsGeometry? padding;
  final GestureTapCallback? onTap;

  const ChatItemContainer({
    Key? key,
    required this.image,
    required this.name,
    required this.time,
    required this.message,
    this.count,
    required this.width,
    this.borderColor,
    this.padBorder = 16,
    this.padding,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: const BoxDecoration(),
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              image,
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: name),
                        const SizedBox(width: 12),
                        time,
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: message),
                        if (count != null) ...[
                          const SizedBox(width: 12),
                          count ?? Container(),
                        ]
                      ],
                    ),
                    SizedBox(height: padBorder),
                    Divider(height: 1, thickness: 1, color: borderColor),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

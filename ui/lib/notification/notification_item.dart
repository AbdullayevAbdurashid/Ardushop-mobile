import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final Function onTap;
  final Widget title;
  final Widget? date;
  final Text? time;
  final Widget? leading;
  final Widget? trailing;
  const NotificationItem({
    Key? key,
    required this.title,
    required this.onTap,
    this.date,
    this.leading,
    this.trailing,
    this.time,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding:const EdgeInsets.all(24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                ),
                child: leading,
              ),
              const SizedBox(width: 16),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      date ?? Container(),
                      const SizedBox(width: 8),
                      time ?? Container(),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  title,
                ],
              )),
              trailing ?? Container(),
            ],
          ),
        ));
  }
}

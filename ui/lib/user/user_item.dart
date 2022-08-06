import 'package:flutter/material.dart';

abstract class UserItem extends StatefulWidget {
  final Color? colorUser;
  final BorderRadius? borderRadiusUser;
  final List<BoxShadow>? shadowUser;

  const UserItem({
    Key? key,
    this.colorUser,
    this.borderRadiusUser,
    this.shadowUser,
  }) : super(key: key);

  @override
  State<UserItem> createState() => _UserItemState();

  @protected
  Widget buildLayout(BuildContext context);
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.colorUser,
        borderRadius: widget.borderRadiusUser,
        boxShadow: widget.shadowUser,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: widget.buildLayout(context),
    );
  }
}

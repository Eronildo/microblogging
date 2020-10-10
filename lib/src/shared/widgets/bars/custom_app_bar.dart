import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget title;
  final bool centerTitle;
  final double elevation;
  final bool automaticallyImplyLeading;
  final List<Widget> actions;
  final double height;
  final Widget leading;

  const CustomAppBar({
    Key key,
    this.title,
    this.centerTitle = false,
    this.elevation = 0.0,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.height = 50.0,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
          leading: leading,
          titleSpacing: 0.0,
          automaticallyImplyLeading: automaticallyImplyLeading,
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          title: title,
          centerTitle: centerTitle,
          elevation: elevation,
          actions: actions),
    );
  }

  @override
  Size get preferredSize => Size(Get.width, height);
}

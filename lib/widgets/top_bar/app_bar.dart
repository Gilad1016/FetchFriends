import 'package:dogy_park/design/color_pallette.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final Widget? leadingWidget;
  final Widget? trailingWidget;

  const CustomAppBar({
    super.key,
    required this.titleText,
    this.leadingWidget,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        titleText,
        style: const TextStyle(
          color: AppColors.primaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      elevation: 0.0,
      centerTitle: true,
      leading: leadingWidget ?? Container(),
      actions: <Widget>[
        trailingWidget ?? Container(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final Function? leadingAction;
  final Function? trailingAction;

  const CustomAppBar({super.key,
    required this.titleText,
    this.leadingAction,
    this.trailingAction, required Null Function() onLeadingPressed, required Null Function() onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        titleText,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: leadingAction as void Function()?,
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            CupertinoIcons.back, // Use back arrow from cupertino_icons
            size: 20,
            color: Colors.black, // Customize arrow color
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: trailingAction as void Function()?,
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              CupertinoIcons.ellipsis, // Use ellipsis from cupertino_icons
              size: 20,
              color: Colors.black, // Customize ellipsis color
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}

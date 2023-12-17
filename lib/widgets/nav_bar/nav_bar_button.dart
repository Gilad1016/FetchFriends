import 'package:flutter/material.dart';

class NavBarButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const NavBarButton({
    super.key,
    required this.text,
    required this.onPressed,
    TextStyle? textStyle,
  });

  //currently not used

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 20,
              ),
            )));
  }
}

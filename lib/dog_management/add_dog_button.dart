import 'package:flutter/material.dart';

class AddDogButton extends StatelessWidget {
  final Future<void> Function() onPressed;

  const AddDogButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: Colors.grey,
            width: 4,
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.add,
            size: 50,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

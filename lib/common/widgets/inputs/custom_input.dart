import 'package:flutter/material.dart';

class CustomInputText extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextInputType keyboardType; // Optional
  final bool obscureText; // Optional
  final TextEditingController controller;
  final Icon prefixIcon;
  final IconButton suffixIcon;
  final void Function(String text)? onChanged;

  const CustomInputText(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.prefixIcon = const Icon(Icons.text_fields),
      this.suffixIcon = const IconButton(
        icon: Icon(Icons.clear),
        onPressed: null,
      ),
      this.onChanged});

  @override
  State<CustomInputText> createState() => _CustomInputTextState();
}

class _CustomInputTextState extends State<CustomInputText> {
  bool _showPassword = false; // Flag for password visibility only

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText || _showPassword,
        // Combine internal and widget state
        decoration: InputDecoration(
          labelText: widget.labelText,
          prefixIcon: widget.prefixIcon,
          // Adjust based on type
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(width: 3.0),
          ),
          suffixIcon: widget.obscureText
              ? IconButton(
                  // Show password toggle if obscure
                  icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off),
                  color: Colors.grey,
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                )
              : widget.suffixIcon,
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}

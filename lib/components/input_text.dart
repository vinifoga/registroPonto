import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Icon? icon;
  final TextInputType? keyboardType;

  const InputText({
    Key? key,
    required this.hintText,
    required this.labelText,
    this.icon,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hintText,
          labelText: labelText,
          suffixIcon: icon,
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}

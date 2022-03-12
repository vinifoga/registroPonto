import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Icon? icon;
  final TextInputType? keyboardType;
  final TextEditingController controller;

  const InputText({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    this.icon,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hintText,
          labelText: labelText,
          suffixIcon: icon,
        ),
        keyboardType: keyboardType,
        validator: (value) =>
        value!.isEmpty ? 'Não pode ser vazio' : null,
      ),
    );
  }
}

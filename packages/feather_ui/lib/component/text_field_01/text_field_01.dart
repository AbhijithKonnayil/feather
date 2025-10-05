import 'package:feather_core/feather_core.dart';
import 'package:flutter/material.dart';

part 'text_field_01.example.dart';

@ComponentMeta(
  id: 'text_field_01',
  name: 'TextField01',
  description: 'A simple TextField01 component for demo',
  files: [],
  screens: [Screens.mobile],
  types: [ComponentType.textField],
  categories: [
    ComponentCategory.formsInputs,
  ],
)
class TextField01 extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const TextField01({
    Key? key,
    required this.controller,
    required this.hint,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
    );
  }
}

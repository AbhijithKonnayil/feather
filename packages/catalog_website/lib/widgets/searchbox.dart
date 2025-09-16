import 'package:flutter/material.dart';

class FeatherSearchBox extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final FocusNode? focusNode;

  const FeatherSearchBox({
    super.key,
    this.hintText = "Search...",
    this.controller,
    this.onChanged,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white, // background color
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: const Icon(Icons.search, color: Colors.grey),
          hintText: hintText,
          border: InputBorder.none,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}

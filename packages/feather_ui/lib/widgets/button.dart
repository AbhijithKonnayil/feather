import 'package:flutter/material.dart';

class FeatherButton extends StatelessWidget {
  const FeatherButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      color: Colors.red,
      child: Text("Label"),
    );
  }
}

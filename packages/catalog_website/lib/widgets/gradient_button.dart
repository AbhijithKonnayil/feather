import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final BorderRadius borderRadius;
  final Gradient gradient;

  const GradientButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.borderRadius = const BorderRadius.all(Radius.circular(3)),
    this.gradient = const LinearGradient(
      colors: [Color(0xFF00C9A7), Color(0xFF0072FF)],
    ),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        height: 45,
        alignment: Alignment.center,
        decoration: isSelected
            ? BoxDecoration(gradient: gradient, borderRadius: borderRadius)
            : BoxDecoration(
                color: Colors.transparent,
                borderRadius: borderRadius,
                border: Border.all(
                  width: 2,
                  style: BorderStyle.solid,
                  // Border can't take gradient directly → use Shader
                  color: isSelected ? Colors.transparent : gradient.colors.last,
                ),
              ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : gradient.colors.last,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

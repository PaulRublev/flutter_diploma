import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const CustomIconButton(this.icon, {super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      visualDensity: VisualDensity.compact,
      splashRadius: 15,
      padding: const EdgeInsets.all(1),
      onPressed: () => onPressed(),
    );
  }
}

import 'package:flutter/material.dart';

class StyledIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const StyledIconButton(this.icon, {super.key, required this.onPressed});

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

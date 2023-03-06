import 'package:flutter/material.dart';

class StyledCircularProgressIndicator extends StatelessWidget {
  const StyledCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.background,
      ),
      child: const CircularProgressIndicator(),
    );
  }
}

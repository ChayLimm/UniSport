import 'package:flutter/material.dart';
import 'package:unitime/presentation/themes/theme.dart';

class UniButton extends StatelessWidget {
  final VoidCallback onTrigger;
  final Color color;
  final String label;
  const UniButton({super.key, required this.onTrigger, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTrigger,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: UniTextStyles.body,
          )
        ),
      ),
    );
  }
}
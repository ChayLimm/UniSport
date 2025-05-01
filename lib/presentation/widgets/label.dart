import 'package:flutter/material.dart';
import 'package:unitime/presentation/themes/theme.dart';

class Label extends StatelessWidget {
  final String label;
  const Label({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft, 
      child: Text(label,
      style: UniTextStyles.body.copyWith(color: UniColor.white),
      ),
    );
  }
}
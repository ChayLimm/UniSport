import 'package:flutter/material.dart';
class UnitSportBackground extends StatelessWidget {
  const UnitSportBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: Image.asset(
        'assets/images/image 2.png', // Path to your image
        fit: BoxFit.fill, // Adjust image fit to cover the container
      ),
    );
  }
}
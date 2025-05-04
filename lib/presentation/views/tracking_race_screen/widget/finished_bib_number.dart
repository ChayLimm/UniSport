import 'package:flutter/material.dart';
import 'package:unitime/presentation/themes/theme.dart';

class FinishedBibNumber extends StatelessWidget {
  const FinishedBibNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: UniColor.backGroundColor2.withOpacity(0.5), // dark background
        borderRadius: BorderRadius.circular(UniSpacing.radius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'BIB 001',
            style: UniTextStyles.heading.copyWith(color: UniColor.white),
          ),
          const SizedBox(height: 5),
          Text(
            'Finished in 00:01:30',
            style: UniTextStyles.body.copyWith(color: UniColor.white),
          ),
        ],
      ),
    );
  }
}
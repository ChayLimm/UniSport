import 'package:flutter/material.dart';
import 'package:unitime/presentation/themes/theme.dart';

class UnFinishedBibNumber extends StatelessWidget {
  final String bibNumber; // Example bib number
  const UnFinishedBibNumber({super.key,required this.bibNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: UniColor.backGroundColor, // dark background
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(bibNumber,
            style: UniTextStyles.heading.copyWith(color: UniColor.white),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:unitime/presentation/themes/theme.dart';

class UniBottomnav extends StatelessWidget {
  const UniBottomnav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: UniColor.black2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24), // reduce side spacing
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // closer than spaceAround
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.home_outlined, color: UniColor.grayDark, size: 30),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.timer_sharp, color: UniColor.primary, size: 30),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.leaderboard_outlined, color: UniColor.grayDark, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}

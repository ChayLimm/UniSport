import 'package:flutter/material.dart';
import 'package:unitime/presentation/themes/theme.dart';

class CustomSearchbar extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Function(String)? onChanged;

  const CustomSearchbar({
    super.key,
    this.controller,
    this.hintText = "Search",
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 160,
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 9),
      decoration: BoxDecoration(
        color: UniColor.backGroundColor2, // dark background
        borderRadius: BorderRadius.circular(UniSpacing.radius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.white70,fontSize: 18),
              ),
            ),
          ),
          const Icon(Icons.search, color: Colors.white,size: 20,),
        ],
      ),
    );
  }
}
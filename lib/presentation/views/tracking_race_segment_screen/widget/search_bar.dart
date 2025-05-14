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
      width: 160,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: UniColor.backGroundColor2, // dark background
        borderRadius: BorderRadius.circular(UniSpacing.radius),
      ),
      child:  Center(
        child: TextField(
                
                controller: controller,
                onChanged: onChanged,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search), // This is your trailing widge
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: UniTextStyles.body.copyWith(color: UniColor.grayDark)
                  ),
                ),
      ),
    );
      
   
  }
}
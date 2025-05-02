import 'package:flutter/material.dart';
import 'package:unitime/presentation/themes/theme.dart';

///
/// custom widget-component for use in participant view, tracking timer screen
///
class UniAppBar extends StatelessWidget {
  final String title;
  final String? subTitle;  //can be date/distance
  final VoidCallback onTapBack;

  const UniAppBar({super.key, 
    required this.title, 
    this.subTitle, 
    required this.onTapBack
  });

  @override
  Widget build(BuildContext context) {
    return Container( 
      decoration: BoxDecoration(
        color: UniColor.black1,
        borderRadius: BorderRadius.circular(9),
      ),
      child: ListTile(
        // minTileHeight: 80,
        contentPadding: EdgeInsets.zero,
        leading: IconButton(
          alignment: Alignment.topCenter,
          onPressed: onTapBack, 
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: UniColor.grayDark,
            size: 20,
          )
        ),

        title: Text(
          title,
          style: UniTextStyles.body.copyWith(color: UniColor.white,fontWeight: FontWeight.bold),
          ),
        
        subtitle: subTitle != null
          ? Text(
              subTitle!,
              style: UniTextStyles.body.copyWith(
                color: UniColor.grayDark,
              ),
            )
          : null,
      ),
    );
  }
}

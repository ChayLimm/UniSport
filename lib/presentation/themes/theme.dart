import 'package:flutter/material.dart';

class   UniColor{
  static Color primary            = const Color(0xFF00875F);
  static Color red                = const Color(0xFFFF3B30);
  static Color yellow             = const Color(0xFFF8A849);
  static Color backgroundColor    = const Color(0xFF121214);
  static Color black1            = const Color(0xFF29292E);
  static Color black2           = const Color(0xFF202024);
  

  // static Color neutralDark        = const Color(0xFF000000); 
  // static Color neutral            = const Color(0xFF757575);
  // static Color neutralLight       = const Color(0xFFD4D4D4);

  // Neutral Colors (can use for text, icons, borders, etc.) from system design
  static Color white = const Color(0xFFFFFFFF);  
  static Color grayLight = const Color(0xFFE1E1E6);  // gray_100
  static Color grayMedium = const Color(0xFFC4C4CC); // gray_200
  static Color grayDark = const Color(0xFF7C7C8A);   // gray_300

  // static Color white              =  Colors.white;  

  static Color get backGroundColor { 
    return UniColor.backgroundColor;
  }
  static Color get backGroundColor2 { 
    return UniColor.black2;
  }

  static Color get textNormal {
    return UniColor.white;
  }

  static Color get textLight {
    return UniColor.grayMedium;
  }

  static Color get iconNormal {
    return UniColor.white;
  }

  static Color get iconLight {
    return UniColor.grayMedium;
  }

  static Color get disabled {
    return UniColor.grayDark;
  }
}

///
/// Definition of App text styles.
///
class UniTextStyles {
  static TextStyle heading =  TextStyle(fontSize: 28, fontWeight: FontWeight.bold,color: UniColor.white);

  static TextStyle body =   TextStyle(fontSize: 14,color: UniColor.white);
  static TextStyle label =  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

  static TextStyle button =  TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: UniColor.white);
}
///
/// Definition of App spacings, in pixels.
/// Bascially small (S), medium (m), large (l), extra large (x), extra extra large (xxl)
///
class UniSpacing {
  static const double s = 12;
  static const double m = 16; 
  static const double l = 24; 
  static const double xl = 32; 
  static const double xxl = 40; 

  static const double radius = 10; 
  static const double radiusLarge = 14; 
}


///
/// Definition of App Theme.
///
ThemeData appTheme =  ThemeData(
  fontFamily: 'Roboto',
  scaffoldBackgroundColor: Colors.white,
  primaryColor: UniColor.primary
);
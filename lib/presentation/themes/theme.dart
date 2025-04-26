import 'package:flutter/material.dart';

class UniColor{
  static Color primary            = const Color(0xFF00875F);
  static Color red          = const Color(0xFFFF3B30);
  static Color yellow             = const Color(0xFFF8A849);

  static Color bgColor            = const Color(0xFF29292E);
  static Color bgColor2           = const Color.fromARGB(255, 91, 89, 89);
  

  static Color neutralDark        = const Color(0xFF000000); 
  static Color neutral            = const Color(0xFF757575);
  static Color neutralLight       = const Color(0xFFD4D4D4);

  static Color white              =  Colors.white;  

  static Color get backGroundColor { 
    return UniColor.bgColor;
  }
  static Color get backGroundColor2 { 
    return UniColor.bgColor2;
  }

  static Color get textNormal {
    return UniColor.neutralDark;
  }

  static Color get textLight {
    return UniColor.neutralLight;
  }

  static Color get iconNormal {
    return UniColor.neutral;
  }

  static Color get iconLight {
    return UniColor.neutralLight;
  }

  static Color get disabled {
    return UniColor.neutralLight;
  }
}

///
/// Definition of App text styles.
///
class UniTextStyles {
  static TextStyle heading = const TextStyle(fontSize: 28, fontWeight: FontWeight.bold);

  static TextStyle body =  const TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
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
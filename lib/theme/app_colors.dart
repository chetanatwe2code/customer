import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  /// OPACITY
  /// FF 1.0
  /// 00 0.0

  // HEX CODE
  // F,E,D,C,B,A,9,8,7,6,5,4,3,2,1,0
  // 0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F

  /// RGB CODE
  /// RED 255-0-0
  /// GREEN 0,0-255-0
  /// BLUE 0-0-255
  /// FF0000 RED
  /// 00FF00 GREEN
  /// 0000FF BLUE

  /// RED COLOR
  /// 0xFFFFFEFE => FE TO F0
  /// FF is added default
  /// FE Riped 2 Time
  /// 0xFFFFDFDF , 0xFFFFAFAFFF
  //static const Color test = Color(0x1A853232);
  static const Color transparent = Color(0xFF285E29);
  static const Color primary = Color(0xFF119744);
  static const Color primaryLight = Color(0xFF119744);
  static const Color secondary = Color(0xFFD86F0C);
  static const Color darkPrimary = Color(0xFF004219);
  static const Color green = Colors.green;
  static const Color cartButtonColor = primary;

  static const Color _black = Color(0xff000000);
  static const Color _text = Color(0xff37474f);
  static const Color text2 = Color(0xff39404a);
  static const Color _gray = Color(0xFF88887E);
  static const Color _red = Color(0xFFDD2339);
  static const Color _shimmerBase = Color(0x7088887E);
  static const Color _shimmerHighlight = Color(0x70119744);
  static const Color _white = Color(0xFFFFFFFF);
  static const Color ratingColor = Colors.orange;

  /// label color
  static const Color featured = Colors.deepPurpleAccent;
  static const Color outOfStock = Colors.red;
  static const Color discount = Colors.red;
  static const Color newProduct = primary;
  static const Color sale = Colors.red;

  static Color whiteColor() => _white;
  static Color redColor() => _red;
  static Color grayColor() => _gray;
  static Color blackColor() => _black;
  static Color primaryColor() => primary;
  static Color textColor() => _text;
  static Color iconColor() => text2;
  static Color shimmerBaseColor() => _shimmerBase;
  static Color shimmerHighlightColor() => _shimmerHighlight;

}

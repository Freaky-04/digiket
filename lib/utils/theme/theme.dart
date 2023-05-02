import 'package:digikit/Components/color.dart';
import 'package:flutter/material.dart';

class DAppTheme {
  static  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'JosefinSans',
    primaryColor: Color(0xFF07998C),
    scaffoldBackgroundColor: ColorConstants.dAscentColor,

    // primarySwatch: MaterialColor(0xFF07998C, <int, Color>{
    //   50: Color(0xFFD5E6E5),
    //   100: Color(0xFF3BAFA4),
    //   500: Color(0xFF07998C),
    // }),
    // primarySwatch: MaterialColor(0xFF07B7ED,
    //     <int, Color>{
    //       50: Color(0xFF0780A5),
    //       100: Color(0xFF07B7ED)}),
    // textTheme: TextTheme()
  );
}
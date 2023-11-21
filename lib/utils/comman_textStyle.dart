import 'package:flutter/material.dart';
import 'app_color.dart';

class TextStyles {
  static const String fontFamily = 'Outfit';
  static TextStyle textStyleFW400(Color color, double size,) {
    return TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w400);
  }
  static TextStyle textStyleFW500(Color color, double size,) {
    return TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w500);
  }
  static TextStyle textStyleFW600(Color color, double size,) {
    return TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w600);
  }

  //black color
  static const fontSize12 = TextStyle(
    color: AppColor.black,
    fontSize:  12,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );


}



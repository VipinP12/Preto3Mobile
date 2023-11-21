import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headline1: GoogleFonts.poppins(
        color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),
    headline2: GoogleFonts.poppins(
        color: Colors.black, fontSize: 34, fontWeight: FontWeight.w700),
    subtitle1: GoogleFonts.poppins(
        color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
    subtitle2: GoogleFonts.poppins(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
    bodyText1: GoogleFonts.poppins(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
    bodyText2: GoogleFonts.poppins(
        color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal),
    button: GoogleFonts.poppins(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
  );

  static TextTheme darkTextTheme = TextTheme(
    headline1: GoogleFonts.poppins(
        color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
    headline2: GoogleFonts.poppins(
        color: Colors.white, fontSize: 34, fontWeight: FontWeight.w700),
    subtitle1: GoogleFonts.poppins(
        color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
    subtitle2: GoogleFonts.poppins(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
    bodyText1: GoogleFonts.poppins(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),
    bodyText2: GoogleFonts.poppins(
        color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),
    button: GoogleFonts.poppins(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
  );
}

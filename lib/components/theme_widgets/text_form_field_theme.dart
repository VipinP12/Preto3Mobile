import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/utils/app_color.dart';

class AppTextFormFieldTheme{
  AppTextFormFieldTheme._();

  static InputDecorationTheme lightTextInputDecoration=InputDecorationTheme(
    labelStyle: GoogleFonts.poppins(
      color: AppColor.hintTextColor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    border: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: const BorderSide(color: AppColor.borderColor,width: 1),
    ),
    enabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: const BorderSide(color: AppColor.borderColor,width: 1),
    ),
    focusedBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: const BorderSide(color: AppColor.appPrimary,width: 1),
    ),
    disabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: const BorderSide(color: AppColor.borderColor,width: 1),
    ),
  );
  static InputDecorationTheme darkTextInputDecoration=InputDecorationTheme(
    labelStyle: GoogleFonts.poppins(
      color: AppColor.white,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    border: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: const BorderSide(color: AppColor.borderColor,width: 1),
    ),
    enabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: const BorderSide(color: AppColor.borderColor,width: 1),
    ),
    focusedBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: const BorderSide(color: AppColor.appPrimary,width: 1),
    ),
    disabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: const BorderSide(color: AppColor.borderColor,width: 1),
    ),
  );
}
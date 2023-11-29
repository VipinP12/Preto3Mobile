import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'app_assets.dart';
import 'app_color.dart';
import 'comman_textStyle.dart';

class CommonTextField extends StatelessWidget {
  final String? title;
  final  String  hintText;
  final  int?  maxLines;
  final bool? isEmailVerified;
  final Widget? suffixImage;
  final Widget? prefixIcon;
  // final  Color? borderColor;
  final TextEditingController? controller;
  final Function(String)? onSaved;
  // final Function(String)? onTap;
  final VoidCallback? onTap;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final InputBorder? border;
  final Color?fillColor;
  final bool?enabled;
  final EdgeInsetsGeometry?contentPadding;
  // final Color textColor;
  // final Size buttonSize;
  // final VoidCallback onPressed;


  const CommonTextField({Key? key,
      this.title,
    this.maxLines,
    required this.hintText,
    this.controller,
    this.isEmailVerified = false,
    this.suffixImage,
    this.prefixIcon,
    this.onSaved,
    this.keyboardType=TextInputType.text,
    this.validator,
    this.fillColor,
this.onTap,
this.border,
this.enabled,
this.contentPadding
    // required this.textColor,
    // required this.buttonSize,
    // required this.titleSize,

    // this.borderRadius = BorderRadius.circular(30),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(title!, style:TextStyles.textStyleFW500(AppColor.heavyTextColor, 14)),
          ),
        TextFormField(
          // validator: (value) {
          //   return authController.phoneNumberValidator(
          //       value.toString(), context);
          // },
          maxLines: maxLines,
          controller: controller,
          validator: validator,
          onChanged: (newText) {

          },
          onSaved: (newValue) {
            if (onSaved != null) {
            onSaved!(newValue!);
            }},
            onTap: onTap,
          decoration: InputDecoration(
            suffixIcon:  suffixImage,
            prefixIcon: prefixIcon,
            hintText: hintText,
            filled: true,
            fillColor: fillColor ?? Colors.white,
            border:border,
             contentPadding:contentPadding,
          ),
          enabled: enabled??true,
         keyboardType: keyboardType,
        ),
        const SizedBox(height: 20,),
      ],
    );
  }
}




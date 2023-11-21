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
  // final  Color? borderColor;
  final TextEditingController? controller;
  final Function(String)? onSaved;
  // final Color textColor;
  // final Size buttonSize;
  // final VoidCallback onPressed;


  const CommonTextField({Key? key,
      this.title,
    this.maxLines,
    required this.hintText,
      // this.borderColor,
    this.controller,
    this.isEmailVerified = false,
    this.suffixImage,
    this.onSaved,
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
          Text(title!, style:TextStyles.textStyleFW500(AppColor.heavyTextColor, 14)),
        TextFormField(
          // validator: (value) {
          //   return authController.phoneNumberValidator(
          //       value.toString(), context);
          // },
          maxLines: maxLines,
          controller: controller,
          onChanged: (newText) {

          },
          onSaved: (newValue) {
            if (onSaved != null) {
            onSaved!(newValue!);
            }},
          decoration: InputDecoration(
            suffixIcon:  suffixImage,
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        const SizedBox(height: 20,),
      ],
    );
  }
}



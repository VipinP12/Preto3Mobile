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
  final  Color? borderColor;
  final TextEditingController? controller;
  final Function(String)? onSaved;
  final String? Function(String?)? validator;
  // final Color textColor;
  // final Size buttonSize;
  // final VoidCallback onPressed;


  const CommonTextField({Key? key,
      this.title,
    this.maxLines,
    required this.hintText,
      this.borderColor,
    this.controller,
    this.isEmailVerified = false,
    this.suffixImage,
    this.onSaved,
    this.validator,
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
          validator: validator,
          maxLines: maxLines,
          controller: controller,
          onChanged: (newText) {

          },
          onSaved: (newValue) {
            if (onSaved != null) {
            onSaved!(newValue!);
            }},
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          decoration: InputDecoration(
            suffixIcon:  suffixImage,
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.borderColor,width: 1.5)
            ),
          ),
        ),
        const SizedBox(height: 20,),
      ],
    );
  }
}



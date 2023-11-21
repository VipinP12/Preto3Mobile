import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/components/rounded_button.dart';
import 'package:preto3/controller/sign_up_controller.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';

import '../utils/app_assets.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () => Get.back(result: false),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const Image(image: AssetImage(AppAssets.loginBg)),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Enter your email address",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.emailIcon,
                      height: 20,
                      width: 20,
                      color: signUpController.isEmailFocused.value
                          ? AppColor.appPrimary
                          : Colors.black,
                    ),
                    Expanded(
                      child: Form(
                        key: signUpController.signUpEmailKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          cursorColor: AppColor.appPrimary,
                          focusNode: signUpController.emailFocusNode,
                          onTap: () {
                            signUpController.focusEmailIcons(true);
                          },
                          style: GoogleFonts.poppins(
                              color: AppColor.hintTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          onEditingComplete: () =>
                              FocusScope.of(context).unfocus(),
                          decoration: InputDecoration(
                            hintText: "Email Address",
                            helperStyle: GoogleFonts.poppins(
                                color: AppColor.hintTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColor.hintTextColor),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColor.appPrimary),
                            ),
                            contentPadding: const EdgeInsets.all(16),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          controller: signUpController.emailController,
                          onSaved: (savedValue) {
                            signUpController.email.value = savedValue!;
                          },
                          validator: (valid) {
                            return signUpController
                                .emailValidator(valid.toString());
                          },
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                RoundedButton(
                  height: 50,
                  width: double.maxFinite,
                  color: AppColor.appPrimary,
                  text: 'Next',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                  onClick: () => signUpController.signEmailSession(),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () => Get.back(result: false),
                  child: Center(
                    child: RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                        text: 'Already a user ? ',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                        text: 'Log In',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w500),
                      ),
                    ])),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ));
  }
}

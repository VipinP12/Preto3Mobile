import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/forgot_password_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';

import '../components/rounded_button.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);

  final forgotPasswordController = Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
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
                onTap: () => Get.back(),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Image(image: AssetImage(AppAssets.loginBg)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Forgot password ?",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Please enter email address associated with your account.",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.emailIcon,
                    height: 16,
                    width: 16,
                  ),
                  Expanded(
                    child: Form(
                      key: forgotPasswordController.emailKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        cursorColor: AppColor.appPrimary,
                        focusNode: forgotPasswordController.emailFocusNode,
                        onTap: () {
                          forgotPasswordController.focusEmailIcons(true);
                        },
                        style: GoogleFonts.poppins(
                            color: AppColor.hintTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        onEditingComplete: () =>
                            FocusScope.of(context).unfocus(),
                        decoration: InputDecoration(
                          hintText: "Email address",
                          helperStyle: GoogleFonts.poppins(
                              color: AppColor.hintTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColor.hintTextColor),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.appPrimary),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        controller: forgotPasswordController.emailController,
                        onSaved: (savedValue) {
                          forgotPasswordController.emailController.text =
                              savedValue!;
                          forgotPasswordController.email.value = savedValue;
                        },
                        validator: (valid) {
                          return forgotPasswordController
                              .forgotPasswordValidator(valid.toString());
                        },
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              RoundedButton(
                height: 50,
                width: double.maxFinite,
                color: AppColor.appPrimary,
                text: 'Submit',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                onClick: () {
                  forgotPasswordController.validateSession(context);
                },
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/components/rounded_button.dart';
import 'package:preto3/controller/sign_up_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_dimens.dart';
import 'package:preto3/utils/app_routes.dart';

class SignUpFormPage extends StatelessWidget {
  SignUpFormPage({Key? key}) : super(key: key);

  final signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Text(
                "Sign Up",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppDimens.paddingVertical8),
                child: Form(
                  key: signUpController.signUpFirstNameKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
                    ],
                    cursorColor: AppColor.appPrimary,
                    style: GoogleFonts.poppins(
                        color: AppColor.hintTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    decoration: InputDecoration(
                      hintText: "First name",
                      helperStyle: GoogleFonts.poppins(
                          color: AppColor.hintTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.hintTextColor),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.appPrimary),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    controller: signUpController.firstNameController,
                    onSaved: (savedValue) {
                      signUpController.firstName.value = savedValue!;
                    },
                    validator: (valid) {
                      return signUpController
                          .firstNameValidator(valid.toString());
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppDimens.paddingVertical8),
                child: Form(
                  key: signUpController.signUpLastNameKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
                    ],
                    cursorColor: AppColor.appPrimary,
                    style: GoogleFonts.poppins(
                        color: AppColor.hintTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    decoration: InputDecoration(
                      hintText: "Last name",
                      helperStyle: GoogleFonts.poppins(
                          color: AppColor.hintTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.hintTextColor),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.appPrimary),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    controller: signUpController.lastNameController,
                    onSaved: (savedValue) {
                      signUpController.lastName.value = savedValue!;
                    },
                    validator: (valid) {
                      return signUpController
                          .lastNameValidator(valid.toString());
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppDimens.paddingVertical8),
                child: Form(
                  key: signUpController.signUpPhoneKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^[2-9]\d*$'),
                      ),
                    ],
                    cursorColor: AppColor.appPrimary,
                    style: GoogleFonts.poppins(
                        color: AppColor.hintTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    decoration: InputDecoration(
                      hintText: "Phone",
                      helperStyle: GoogleFonts.poppins(
                          color: AppColor.hintTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.hintTextColor),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.appPrimary),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    controller: signUpController.phoneController,
                    onSaved: (savedValue) {
                      signUpController.phone.value = savedValue!;
                    },
                    validator: (valid) {
                      return signUpController.phoneValidator(valid.toString());
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppDimens.paddingVertical8),
                child: Form(
                  key: signUpController.signUpEnrollmentKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(3),
                      FilteringTextInputFormatter.deny(RegExp('[\\.|\\,|\\-|]')),
                    ],
                    cursorColor: AppColor.appPrimary,
                    style: GoogleFonts.poppins(
                        color: AppColor.hintTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    decoration: InputDecoration(
                      hintText: "Enrollment capacity",
                      helperStyle: GoogleFonts.poppins(
                          color: AppColor.hintTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.hintTextColor),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.appPrimary),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    controller: signUpController.enrollmentController,
                    onSaved: (savedValue) {
                      signUpController.enrollment.value = savedValue!;
                    },
                    validator: (valid) {
                      return signUpController
                          .enrollmentValidator(valid.toString());
                    },
                  ),
                ),
              ),
              Obx(
                () => Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.passwordIcon,
                      height: 20,
                      width: 20,
                      color: signUpController.isPasswordFocused.value
                          ? AppColor.appPrimary
                          : Colors.black,
                    ),
                    Expanded(
                      child: Obx(()=>Form(
                        key: signUpController.signUpPasswordKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          cursorColor: AppColor.appPrimary,
                          focusNode: signUpController.passwordFocusNode,
                          obscureText: signUpController.isVisible.value,
                          onTap: () {
                            signUpController.focusPasswordIcons(true);
                            signUpController.focusCPasswordIcons(false);
                          },
                          style: GoogleFonts.poppins(
                              color: AppColor.hintTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          onEditingComplete: () =>
                              FocusScope.of(context).nextFocus(),
                          decoration: InputDecoration(
                              hintText: "Password",
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
                              suffixIcon: InkWell(
                                onTap: () =>
                                    signUpController.togglePasswordVisible(),
                                child: signUpController.isVisible.value
                                    ? Icon(
                                  Icons.visibility_off,
                                  color: signUpController
                                      .isPasswordFocused.value
                                      ? AppColor.appPrimary
                                      : Colors.grey,
                                )
                                    : Icon(
                                  Icons.visibility,
                                  color: signUpController
                                      .isPasswordFocused.value
                                      ? AppColor.appPrimary
                                      : Colors.grey,
                                ),
                              )),
                          controller: signUpController.passwordController,
                          onSaved: (savedValue) {
                            signUpController.password.value = savedValue!;
                          },
                          validator: (valid) {
                            return signUpController
                                .passwordValidator(valid.toString());
                          },
                        ),
                      ),)
                    ),
                  ],
                ),
              ),
              Obx(
                () => Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.passwordIcon,
                      height: 20,
                      width: 20,
                      color: signUpController.isConfirmPasswordFocused.value
                          ? AppColor.appPrimary
                          : Colors.black,
                    ),
                    Expanded(
                      child: Form(
                        key: signUpController.signUpConfirmPasswordKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          cursorColor: AppColor.appPrimary,
                          focusNode: signUpController.cPasswordFocusNode,
                          obscureText: signUpController.isConfirmVisible.value,
                          onTap: () {
                            signUpController.focusPasswordIcons(false);
                            signUpController.focusCPasswordIcons(true);
                          },
                          style: GoogleFonts.poppins(
                              color: AppColor.hintTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          onEditingComplete: () =>
                              FocusScope.of(context).unfocus(),
                          decoration: InputDecoration(
                            hintText: "Confirm Password",
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
                              suffixIcon: InkWell(
                                onTap: () =>
                                    signUpController.toggleCPasswordVisible(),
                                child: signUpController.isConfirmVisible.value
                                    ? Icon(
                                  Icons.visibility_off,
                                  color: signUpController
                                      .isPasswordFocused.value
                                      ? AppColor.appPrimary
                                      : Colors.grey,
                                )
                                    : Icon(
                                  Icons.visibility,
                                  color: signUpController
                                      .isPasswordFocused.value
                                      ? AppColor.appPrimary
                                      : Colors.grey,
                                ),
                              )
                          ),
                          controller: signUpController.cPasswordController,
                          onSaved: (savedValue) {
                            signUpController.password.value = savedValue!;
                          },
                          validator: (valid) {
                            return signUpController
                                .cPasswordValidator(valid.toString());
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
              ),
              RoundedButton(
                height: 50,
                width: double.maxFinite,
                color: AppColor.appPrimary,
                text: 'Create account',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                onClick: () => signUpController.signUpSession(),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () => Get.toNamed(AppRoute.login),
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
      ),
    );
  }
}

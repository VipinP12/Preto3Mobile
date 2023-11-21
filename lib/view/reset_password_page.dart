import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/components/rounded_button.dart';
import 'package:preto3/controller/reset_password_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({Key? key}) : super(key: key);
  final resetPasswordController = Get.find<ResetPasswordController>();
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
                child: Container(
                  width: 100,
                  height: 50,
                  alignment: Alignment.topLeft,
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Image(image: AssetImage(AppAssets.loginBg)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Set your password",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Obx(
                () => Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.passwordIcon,
                      height: 20,
                      width: 20,
                      color: resetPasswordController.isPasswordFocusedNew.value
                          ? AppColor.appPrimary
                          : Colors.black,
                    ),
                    Expanded(
                      child: Form(
                        key: resetPasswordController.newPasswordKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          cursorColor: AppColor.appPrimary,
                          focusNode: resetPasswordController.newFocusNode,
                          onTap: () {
                            // loginController.focusEmailIcons(false);
                            // loginController.focusPasswordIcons(true);
                          },
                          style: GoogleFonts.poppins(
                              color: AppColor.hintTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          onEditingComplete: () =>
                              FocusScope.of(context).unfocus(),
                          obscureText:
                              resetPasswordController.isVisibleNew.value,
                          decoration: InputDecoration(
                              hintText: "New Password",
                              helperStyle: GoogleFonts.poppins(
                                  color: AppColor.hintTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                    color: AppColor.borderColor),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                    color: AppColor.appPrimary),
                              ),
                              contentPadding: const EdgeInsets.all(16),
                              filled: true,
                              fillColor: Colors.white,
                              suffixIcon: InkWell(
                                onTap: () => resetPasswordController
                                    .togglePasswordVisibleNew(),
                                child:
                                    !resetPasswordController.isVisibleNew.value
                                        ? Icon(
                                            Icons.visibility,
                                            color: resetPasswordController
                                                    .isPasswordFocusedNew.value
                                                ? AppColor.appPrimary
                                                : Colors.grey,
                                          )
                                        : Icon(
                                            Icons.visibility_off,
                                            color: resetPasswordController
                                                    .isPasswordFocusedNew.value
                                                ? AppColor.appPrimary
                                                : Colors.grey,
                                          ),
                              )),
                          controller:
                              resetPasswordController.newPasswordController,
                          onSaved: (savedValue) {
                            resetPasswordController.newPassword.value =
                                savedValue!;
                          },
                          validator: (valid) {
                            return resetPasswordController
                                .newPasswordValidator(valid.toString());
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.passwordIcon,
                        height: 20,
                        width: 20,
                        color: resetPasswordController
                                .isPasswordFocusedConfirem.value
                            ? AppColor.appPrimary
                            : Colors.black,
                      ),
                      Expanded(
                        child: Form(
                          key: resetPasswordController.confirmPasswordKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            cursorColor: AppColor.appPrimary,
                            focusNode:
                                resetPasswordController.confiremFocusNode,
                            onTap: () {
                              // loginController.focusEmailIcons(false);
                              // loginController.focusPasswordIcons(true);
                            },
                            style: GoogleFonts.poppins(
                                color: AppColor.hintTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            onEditingComplete: () =>
                                FocusScope.of(context).unfocus(),
                            obscureText:
                                resetPasswordController.isVisibleConfirm.value,
                            decoration: InputDecoration(
                                hintText: "Confirm password",
                                helperStyle: GoogleFonts.poppins(
                                    color: AppColor.hintTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: const BorderSide(
                                      color: AppColor.borderColor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: const BorderSide(
                                      color: AppColor.appPrimary),
                                ),
                                contentPadding: const EdgeInsets.all(16),
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: InkWell(
                                  onTap: () => resetPasswordController
                                      .togglePasswordVisibleConform(),
                                  child: !resetPasswordController
                                          .isVisibleConfirm.value
                                      ? Icon(
                                          Icons.visibility,
                                          color: resetPasswordController
                                                  .isPasswordFocusedConfirem
                                                  .value
                                              ? AppColor.appPrimary
                                              : Colors.grey,
                                        )
                                      : Icon(
                                          Icons.visibility_off,
                                          color: resetPasswordController
                                                  .isPasswordFocusedConfirem
                                                  .value
                                              ? AppColor.appPrimary
                                              : Colors.grey,
                                        ),
                                )),
                            controller: resetPasswordController
                                .confirmPasswordController,
                            onSaved: (savedValue) {
                              // loginController.passwordController.text = savedValue!;
                              resetPasswordController.confirmPassword.value =
                                  savedValue!;
                            },
                            validator: (valid) {
                              return resetPasswordController
                                  .confirmPasswordValidator(valid.toString());
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              RoundedButton(
                height: 50,
                width: double.maxFinite,
                color: AppColor.appPrimary,
                text: 'Set password',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                onClick: () {
                  resetPasswordController.confirmPasswordSession(context);
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

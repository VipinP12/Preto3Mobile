import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/login_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/toast.dart';

import '../components/rounded_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final loginController = Get.find<LoginController>();

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
                InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.centerLeft,
                    //padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Image(image: AssetImage(AppAssets.loginBg)),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Log in",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 30,
                ),
                Obx(
                  () => Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.emailIcon,
                        height: 20,
                        width: 20,
                        color: loginController.isEmailFocused.value
                            ? AppColor.appPrimary
                            : Colors.black,
                      ),
                      /*Image(
                      image: const AssetImage(AppAssets.emailIcon),
                      height: 16,
                      width: 16,
                      color: loginController.isFocused.value?AppColor.appPrimary:Colors.black,
                    ),*/
                      Expanded(
                        child: Form(
                          key: loginController.loginEmailKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            cursorColor: AppColor.appPrimary,
                            focusNode: loginController.emailFocusNode,
                            onTap: () {
                              loginController.focusEmailIcons(true);
                              loginController.focusPasswordIcons(false);
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
                                  color: AppColor.heavyTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.borderColor),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.appPrimary),
                              ),
                              contentPadding: const EdgeInsets.all(16),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            controller: loginController.emailController,
                            onSaved: (savedValue) {
                              // loginController.emailController.text = savedValue!;
                              loginController.email.value = savedValue!;
                            },
                            validator: (valid) {
                              return loginController
                                  .emailValidator(valid.toString());
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Obx(
                  () => Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.passwordIcon,
                        height: 20,
                        width: 20,
                        color: loginController.isPasswordFocused.value
                            ? AppColor.appPrimary
                            : Colors.black,
                      ),
                      Expanded(
                        child: Form(
                          key: loginController.loginPasswordKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            cursorColor: AppColor.appPrimary,
                            focusNode: loginController.passwordFocusNode,
                            onTap: () {
                              loginController.focusEmailIcons(false);
                              loginController.focusPasswordIcons(true);
                            },
                            style: GoogleFonts.poppins(
                                color: AppColor.hintTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            onEditingComplete: () =>
                                FocusScope.of(context).unfocus(),
                            obscureText: loginController.isVisible.value,
                            decoration: InputDecoration(
                                hintText: "Password",
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
                                  onTap: () =>
                                      loginController.togglePasswordVisible(),
                                  child: loginController.isVisible.value
                                      ? Icon(
                                          Icons.visibility_off,
                                          color: loginController
                                                  .isPasswordFocused.value
                                              ? AppColor.appPrimary
                                              : Colors.grey,
                                        )
                                      : Icon(
                                          Icons.visibility,
                                          color: loginController
                                                  .isPasswordFocused.value
                                              ? AppColor.appPrimary
                                              : Colors.grey,
                                        ),
                                )),
                            controller: loginController.passwordController,
                            onSaved: (savedValue) {
                              // loginController.passwordController.text = savedValue!;
                              loginController.password.value = savedValue!;
                            },
                            validator: (valid) {
                              return loginController
                                  .passwordValidator(valid.toString());
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () => Get.toNamed(AppRoute.forgotPassword),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot password ?",
                        style: GoogleFonts.poppins(
                            color: Colors.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                RoundedButton(
                    height: 50,
                    width: double.maxFinite,
                    color: AppColor.appPrimary,
                    text: 'Log in',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    onClick: () => loginController.loginSession()),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () async {
                    if (await Get.toNamed(AppRoute.signUp)) {
                      messageToastWarning(context,
                          "You are already registered. Please login to continue using Preto3");
                    }
                  },
                  child: Center(
                    child: RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                        text: 'New on PREto3 ',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
                      ),
                      TextSpan(
                        text: ' Sign Up',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
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

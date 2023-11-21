import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/components/custom_dialog.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/argument_keys.dart';

class ForgotPasswordController extends GetxController with BaseController {
  var emailKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var email = "".obs;

  var isLoading = false.obs;
  var isValid = false.obs;
  var isFocused = false.obs;
  var isEmailValid = false;

  var isEmailFocused = false.obs;
  var isForgotPasswordValid = false;
  FocusNode emailFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  focusEmailIcons(bool value) {
    isEmailFocused.value = value;
    update();
  }

  String? forgotPasswordValidator(String value) {
    if (value.isNotEmpty &&
        RegExp(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
      return null;
    }
    return 'Please enter a valid email address';
  }

  void validateSession(BuildContext context) {
    isEmailValid = emailKey.currentState!.validate();

    Get.focusScope!.unfocus();
    if (isEmailValid) {
      emailKey.currentState!.save();

      log("SAVE ${email.value}");
      forgotApiCall(email.value, context);
    }
  }

  void forgotApiCall(String email, BuildContext context) async {
    var params = {'email': email};

    var response = await BaseClient()
        .patchWithOutAuth(
            ApiEndPoints.devBaseUrl, ApiEndPoints.forgotPassword, params)
        .catchError(handleError);

    if (response != null && response != "") {
      print("RESPONSE FORGOT PASSWORD:${response.toString()}");
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: 170,
              width: 300,
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: SvgPicture.asset(AppAssets.successIcon)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        response.toString(),
                        style: GoogleFonts.poppins(
                            color: AppColor.heavyTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Get.offAllNamed(AppRoute.resetPassword, arguments: {
                        //   ArgumentKeys.argumentUserEmail: emailController.text
                        // });

                        Get.back();
                        Get.back();
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'OK',
                          style: GoogleFonts.poppins(
                              color: AppColor.appPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}

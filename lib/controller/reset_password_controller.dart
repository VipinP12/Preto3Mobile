import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:http/http.dart' as http;
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/argument_keys.dart';

import '../utils/toast.dart';

class ResetPasswordController extends GetxController with BaseController {
  final storageBox = GetStorage();
  dynamic argumentData = Get.arguments;
  var isPasswordFocusedNew = false.obs;
  var isPasswordFocusedConfirem = false.obs;
  final newPasswordKey = GlobalKey<FormState>();
  final confirmPasswordKey = GlobalKey<FormState>();
  FocusNode newFocusNode = FocusNode();
  FocusNode confiremFocusNode = FocusNode();
  var isVisibleNew = true.obs;
  var isVisibleConfirm = true.obs;
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var newPassword = "".obs;
  var confirmPassword = "".obs;
  var isNewPasswordValid = false;
  var isConfirmPasswordValid = false;
  var userEmail = "".obs;

  @override
  void onInit() {
    super.onInit();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    userEmail.value = argumentData[ArgumentKeys.argumentUserEmail];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  void togglePasswordVisibleNew() {
    isVisibleNew.value = !isVisibleNew.value;
    update();
  }

  void togglePasswordVisibleConform() {
    isVisibleConfirm.value = !isVisibleConfirm.value;
    update();
  }

  String? newPasswordValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 8) {
      return 'Password must be minimum 8 characters.';
    }
    return null;
  }

  String? confirmPasswordValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter confirm password';
    } else if (value.length < 8) {
      return 'Password must be minimum 8 characters.';
    } else if (value != newPasswordController.text) {
      return 'Password must be same as new password';
    }
    return null;
  }

  void confirmPasswordSession(BuildContext context) async {
    //showLoading();
    isNewPasswordValid = newPasswordKey.currentState!.validate();
    isConfirmPasswordValid = confirmPasswordKey.currentState!.validate();
    Get.focusScope!.unfocus();
    if (isNewPasswordValid && isConfirmPasswordValid) {
      var body = {
        "email": userEmail.value.trim(),
        "password": newPasswordController.text.trim()
      };
      showLoading('check signup condition');
      final response = await http.patch(
          Uri.parse(
              "${ApiEndPoints.devBaseUrl}${ApiEndPoints.setUserPassword}"),
          body: json.encode(body),
          headers: {'Content-Type': 'application/json'});
      hideLoading();
      if (response.statusCode == 200) {
        messageToastSuccess(context, "",
            "Your password is successfully set. Please login to continue using PREto3");
        Future.delayed(const Duration(seconds: 4), () {
          Get.offAllNamed(AppRoute.login);
        });
      } else {
        messageToastWarning(context, "Something went wrong");
      }
    }
  }
}

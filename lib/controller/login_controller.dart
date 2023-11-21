import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/model/login_model.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/toast.dart';

class LoginController extends GetxController with BaseController {
  final storageBox = GetStorage();
  final loginEmailKey = GlobalKey<FormState>();
  final loginPasswordKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var email = "".obs;
  var password = "".obs;

  var isLoading = false.obs;
  var isVisible = true.obs;
  var isValid = false.obs;
  var isEmailFocused = false.obs;
  var isPasswordFocused = false.obs;

  var isEmailValid = false;
  var isPasswordValid = false;

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  focusEmailIcons(bool value) {
    isEmailFocused.value = value;
    update();
  }

  focusPasswordIcons(bool value) {
    isPasswordFocused.value = value;
    update();
  }

  void togglePasswordVisible() {
    if (isVisible.value == true) {
      isVisible.value = false;
    } else {
      isVisible.value = true;
    }
    update();
  }

  String? emailValidator(String value) {
    if (value.isNotEmpty &&
        RegExp(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
      return null;
    }
    return 'Please enter a valid email address';
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return "Password can't be empty.";
    }
    return null;
  }

  void loginSession() {
    isEmailValid = loginEmailKey.currentState!.validate();
    isPasswordValid = loginPasswordKey.currentState!.validate();
    Get.focusScope!.unfocus();
    if (isEmailValid && isPasswordValid) {
      showLoading();
      loginEmailKey.currentState!.save();
      loginPasswordKey.currentState!.save();

      log("SAVE ${email.value}");
      log("SAVE ${password.value}");
      loginApiCall(email.value, password.value);
    }
  }

  void loginApiCall(String email, String password) async {
    var params = {'userEmailid': email, 'userPassword': password};

    storageBox.write(AppKeys.keyEmail, email);
    storageBox.write(AppKeys.keyPassword, password);
    var response = await BaseClient()
        .loginPost(ApiEndPoints.devBaseUrl, ApiEndPoints.login, params)
        .catchError(handleError);
    if (response != null) {
      var loginRes = LoginModel.fromJson(jsonDecode(response));
      log("LOGIN RESPONSE EMAIL:${loginRes.email}");
      log("LOGIN RESPONSE PASSWORD:$password");
      log("LOGIN RESPONSE FIRST NAME:${loginRes.firstName}");
      log("LOGIN RESPONSE ROLE:${loginRes.roles![0]!.roleId}");
      if (loginRes.roles![0]!.roleId == 6) {
        storageBox.write(AppKeys.keyIsLogged, true);
        storageBox.write(AppKeys.keyPunchMasterId, loginRes.id);
        storageBox.write(
            AppKeys.keyPunchMasterRoleId, loginRes.roles![0]!.roleId);
        storageBox.write(
            AppKeys.keyPunchMasterSchoolId, loginRes.roles![0]!.schoolId);
        storageBox.write(
            AppKeys.keyPunchMasterSchoolName, loginRes.roles![0]!.schoolName);
        storageBox.write(AppKeys.keySchoolQRCode, loginRes.roles![0]!.qrCode);
        hideLoading();
        Get.offAllNamed(AppRoute.timeClock);
        // Get.toNamed(AppRoute.timeClock);
      } else {
        storageBox.write(AppKeys.keyIsLogged, true);
        storageBox.write(AppKeys.keyId, loginRes.id);
        storageBox.write(AppKeys.keyMobileNumber, loginRes.mobileNumber);
        storageBox.write(AppKeys.keyFirstName, loginRes.firstName);
        storageBox.write(AppKeys.keyLastName, loginRes.lastName);
        storageBox.write(AppKeys.keyProfilePic, loginRes.profilePic);
        storageBox.write(AppKeys.keySchoolLogo, loginRes.schoolLogo);
        storageBox.write(AppKeys.keySchoolId, loginRes.roles!.first!.schoolId);
        storageBox.write(
            AppKeys.keySchoolName, loginRes.roles!.first!.schoolName);
        storageBox.write(AppKeys.keyRoleId, loginRes.roles!.first!.roleId);
        storageBox.write(AppKeys.keyRoleName, loginRes.roles!.first!.roleName);
        storageBox.write(
            AppKeys.keySchoolQRCode, loginRes.roles!.first!.qrCode);
        storageBox.write(AppKeys.keyUserName, loginRes.userName);
        storageBox.write(AppKeys.keyEmailVerified, loginRes.emailVerified);
        storageBox.write(AppKeys.keyDOB, loginRes.dateOfBirth);
        storageBox.write(AppKeys.keyRoleList, loginRes.roles);

        Get.offAllNamed(AppRoute.selectRole);
      }
    }
    hideLoading();
  }
}

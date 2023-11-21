import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/model/school_type_model.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:http/http.dart' as http;
import 'package:preto3/utils/argument_keys.dart';

class SignUpController extends GetxController with BaseController {
  final signUpEmailKey = GlobalKey<FormState>();
  final signUpSchoolNameKey = GlobalKey<FormState>();
  final signUpFirstNameKey = GlobalKey<FormState>();
  final signUpLastNameKey = GlobalKey<FormState>();
  final signUpPhoneKey = GlobalKey<FormState>();
  final signUpEnrollmentKey = GlobalKey<FormState>();
  final signUpPasswordKey = GlobalKey<FormState>();
  final signUpConfirmPasswordKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var schoolNameController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var enrollmentController = TextEditingController();
  var passwordController = TextEditingController();
  var cPasswordController = TextEditingController();

  var email = "".obs;
  var schoolName = "".obs;
  var firstName = "".obs;
  var lastName = "".obs;
  var phone = "".obs;
  var enrollment = "".obs;
  var password = "".obs;
  var cPassword = "".obs;

  var isLoading = false.obs;
  var isVisible = true.obs;
  var isConfirmVisible = true.obs;
  var isValid = false.obs;
  var isFocused = false.obs;

  var isEmailValid = false;
  var isSchoolNameValid = false;
  var isFirstNameValid = false;
  var isLastNameValid = false;
  var isPhoneValid = false;
  var isEnrollmentValid = false;
  var isPasswordValid = false;
  var isCPasswordValid = false;

  var isEmailFocused = false.obs;
  var isPasswordFocused = false.obs;
  var isConfirmPasswordFocused = false.obs;

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode cPasswordFocusNode = FocusNode();
  var droppedValue = "".obs;
  var selectSchoolType = "".obs;

  SchoolTypeModel? mySchoolType;
  var selectedSchoolType = "".obs;
  var selectedSchoolTypeId = 0.obs;
  var isSchoolTypeValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    schoolNameController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
    enrollmentController = TextEditingController();
    passwordController = TextEditingController();
    cPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    schoolNameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    enrollmentController.dispose();
    passwordController.dispose();
    cPasswordController.dispose();
  }

  focusEmailIcons(bool value) {
    isEmailFocused.value = value;
    update();
  }

  focusPasswordIcons(bool value) {
    isPasswordFocused.value = value;
    update();
  }

  focusCPasswordIcons(bool value) {
    isConfirmPasswordFocused.value = value;
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

  void toggleCPasswordVisible() {
    if (isConfirmVisible.value == true) {
      isConfirmVisible.value = false;
    } else {
      isConfirmVisible.value = true;
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

  String? schoolNameValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter  school name';
    }
    return null;
  }

  String? firstNameValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter  first name';
    }
    return null;
  }

  String? lastNameValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter last name';
    }
    return null;
  }

  String? phoneValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter  phone number';
    } else if (value.isNotEmpty && value.length < 10) {
      return 'Please enter valid phone number';
    }
    return null;
  }

  String? enrollmentValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter  enrollment capacity';
    } else if (int.parse(value) > 120) {
      return 'maximum enrollment capacity is 120';
    }
    return null;
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter  password';
    } else if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?\d)(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(value)) {
      return 'Password must contain minimum eight characters, \nat least one uppercase letter, one lowercase letter,\none number and one special character.';
    }
    return null;
  }

  String? cPasswordValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter  confirm password';
    } else if (value.isNotEmpty && value != passwordController.text) {
      return 'Password mismatched';
    }
    return null;
  }

  void setSchoolType(SchoolTypeModel schoolTypeModel) {
    mySchoolType = schoolTypeModel;
    selectedSchoolType.value = schoolTypeModel.schoolTypeName;
    selectedSchoolTypeId.value = schoolTypeModel.schoolTypeId;
    isSchoolTypeValid.value = true;
    update();
  }

  void signEmailSession() async {
    isEmailValid = signUpEmailKey.currentState!.validate();
    Get.focusScope!.unfocus();
    if (isEmailValid) {
      signUpEmailKey.currentState!.save();
      showLoading('check signup condition');
      final response = await http.get(Uri.parse(
          "${ApiEndPoints.devBaseUrl}${ApiEndPoints.getSchoolJoin}?email=${emailController.text}"));
      hideLoading();
      if (response.statusCode == 200) {
        Get.toNamed(AppRoute.resetPassword,
            arguments: {ArgumentKeys.argumentUserEmail: emailController.text});
      } else if (response.statusCode == 400) {
        Get.toNamed(AppRoute.signUpSchool);
      } else {
        Get.back(result: true);
      }
    }
  }

  void signSchoolSession() {
    isSchoolNameValid = signUpSchoolNameKey.currentState!.validate();

    Get.focusScope!.unfocus();
    if (isSchoolNameValid && isSchoolTypeValid.value) {
      signUpSchoolNameKey.currentState!.save();
      Get.toNamed(AppRoute.signUpForm);
    } else {
      selectSchoolType.value = "Please select the school type";
    }
  }

  void signUpSession() {
    isFirstNameValid = signUpFirstNameKey.currentState!.validate();
    isLastNameValid = signUpLastNameKey.currentState!.validate();
    isPhoneValid = signUpPhoneKey.currentState!.validate();
    isEnrollmentValid = signUpEnrollmentKey.currentState!.validate();
    isPasswordValid = signUpPasswordKey.currentState!.validate();
    isCPasswordValid = signUpConfirmPasswordKey.currentState!.validate();

    Get.focusScope!.unfocus();
    if (isFirstNameValid &&
        isLastNameValid &&
        isPhoneValid &&
        isEnrollmentValid &&
        isCPasswordValid) {
      signUpFirstNameKey.currentState!.save();
      signUpLastNameKey.currentState!.save();
      signUpPhoneKey.currentState!.save();
      signUpEnrollmentKey.currentState!.save();
      signUpPasswordKey.currentState!.save();
      signUpConfirmPasswordKey.currentState!.save();

      log("SAVE ID ${selectedSchoolTypeId.value}");
      log("SAVE EMAIL ${email.value}");
      log("SAVE SCHOOL NAME ${schoolName.value}");
      log("SAVE FIRST NAME ${firstName.value}");
      log("SAVE LAST NAME${lastName.value}");
      log("SAVE PHONE NUMBER ${phone.value}");
      log("SAVE ENROLLMENT ${enrollment.value}");
      log("SAVE PASSWORD ${password.value}");
      signUpApiCall(
          selectedSchoolTypeId.value.toString(),
          email.value,
          schoolName.value,
          firstName.value,
          lastName.value,
          phone.value,
          enrollment.value,
          password.value);
    }
  }

  List<SchoolTypeModel> schoolTypeList = [
    SchoolTypeModel(
      schoolTypeId: 1,
      schoolTypeName: "Child Care/Pre School",
    ),
    SchoolTypeModel(
      schoolTypeId: 2,
      schoolTypeName: "After School",
    ),
    SchoolTypeModel(
      schoolTypeId: 3,
      schoolTypeName: "Camp",
    ),
    SchoolTypeModel(
      schoolTypeId: 4,
      schoolTypeName: "Pre School/ Kindergarten",
    ),
  ];

  void signUpApiCall(
      String id,
      String emailId,
      String schoolName,
      String firstname,
      String lastname,
      String phone,
      String enrollmentCount,
      String password) async {
    showLoading();
    var params = {
      "firstName": firstname,
      "lastName": lastname,
      "phoneNumber": phone,
      "email": emailId,
      "password": password,
      "schoolName": schoolName,
      "schoolTypeId": id,
      "enrollmentCapacity": enrollmentCount
    };

    var response = await BaseClient()
        .postWithoutAuth(
            ApiEndPoints.devBaseUrl, ApiEndPoints.schoolSignUp, params)
        .catchError(handleError);

    if (response != null) {
      hideLoading();
      Get.offAllNamed(AppRoute.login);
    }
  }
}

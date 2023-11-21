import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:preto3/components/custom_dialog.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_keys.dart';

class AddEmergencyController extends GetxController with BaseController {
  final storageBox = GetStorage();
  dynamic argumentData = Get.arguments;
  var staffScaffoldKey = GlobalKey<ScaffoldState>();

  final firstNameKey = GlobalKey<FormState>();
  final lastNameKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();
  final phoneKey = GlobalKey<FormState>();

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var email = "".obs;
  var phone = "".obs;
  var firstName = "".obs;
  var lastName = "".obs;

  var isEmailValid = false;
  var isPhoneValid = false;
  var isFirstNameValid = false;
  var isLastNameValid = false;

  var userId = "".obs;
  var roleId = 0.obs;
  var schoolId = 0.obs;
  @override
  void onInit() {
    userId.value = storageBox.read(AppKeys.keyId).toString();
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    super.onInit();
  }

  String? firstNameValidator(String value) {
    if (value.isNotEmpty) {
      return null;
    }
    return 'Please enter a valid first name';
  }

  String? lastNameValidator(String value) {
    if (value.isNotEmpty) {
      return null;
    }
    return 'Please enter a valid last name';
  }

  String? phoneValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter a number';
    } else if (value.length < 10) {
      return 'phone number must be valid.';
    }
    return null;
  }

  String? emailValidator(String value) {
    if (value.isNotEmpty &&
        RegExp(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
      return null;
    }
    return 'Please enter a valid email address';
  }

  void saveEmergencySession(BuildContext context) {
    showLoading();
    isFirstNameValid = firstNameKey.currentState!.validate();
    isLastNameValid = lastNameKey.currentState!.validate();
    isEmailValid = emailKey.currentState!.validate();
    isPhoneValid = phoneKey.currentState!.validate();
    Get.focusScope!.unfocus();
    if (isFirstNameValid && isLastNameValid && isEmailValid && isPhoneValid) {
      firstNameKey.currentState!.save();
      lastNameKey.currentState!.save();
      emailKey.currentState!.save();
      phoneKey.currentState!.save();

      addEmergencyApiCall(schoolId.value, roleId.value, userId.value,
          firstName.value, lastName.value, email.value, phone.value, context);
    }
  }

  void addEmergencyApiCall(
      int schoolId,
      int roleId,
      String userId,
      String firstname,
      String lastname,
      String email,
      String phone,
      BuildContext context) async {
    var params = {
      "schoolId": schoolId,
      "roleId": roleId,
      "id": userId,
      "emergencyFirstName": firstname,
      "emergencyLastName": lastname,
      "emergencyEmail": email,
      "emergencyPhoneNumber": phone
    };
    var response = await BaseClient()
        .post(ApiEndPoints.devBaseUrl, ApiEndPoints.addStaffEmergencyContact,
            params)
        .catchError(handleError);
    // Staff emergency contact details has been saved/updated successfully
    if (response != null && response != "") {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return CustomDialog(
            message:
                "Staff emergency contact details has been saved/updated successfully",
            roleId: roleId,
          );
        },
      );
      // Get.dialog();
    }
  }
}

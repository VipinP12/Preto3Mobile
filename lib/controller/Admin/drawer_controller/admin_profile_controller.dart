import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:preto3/model/language_model.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/toast.dart';
import '../../../model/admit/admin_profile.dart';
import '../../../network/api_end_points.dart';
import '../../../network/base_client.dart';
import '../../../utils/app_keys.dart';
import '../../base_controller.dart';
import 'package:get/get.dart';

class AdminProfileController extends GetxController with BaseController {
  final storageBox = GetStorage();
  var selectedDate = "".obs;
  LanguageModel? language;

  final adminProfileKey = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var dateOfBirthController = TextEditingController();
  var bioController = TextEditingController();
  var addressController = TextEditingController();
  var countryController = TextEditingController();
  var stateController = TextEditingController();
  var cityController = TextEditingController();
  var oldChangeController = TextEditingController();
  var newChangeController = TextEditingController();
  var confirmChangeController = TextEditingController();
  var firstName = "".obs;
  var lastName = "".obs;
  var email = "".obs;
  var roleId = 0.obs;
  var schoolId = 0.obs;
  var userId = 0.obs;

  var checkInCheckOut = ''.obs;
  var profilePic = "".obs;
  var isActive = true.obs;
  var isDropDown = false.obs;


  final passwordKey = GlobalKey<FormState>();
  final newPasswordKey = GlobalKey<FormState>();
  final cPasswordKey = GlobalKey<FormState>();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode cPasswordFocusNode = FocusNode();

  var isPasswordFocused = false.obs;
  var isNewPasswordFocused = false.obs;
  var isConfirmPasswordFocused = false.obs;

  var isPasswordValid = false;
  var isNewPasswordValid = false;
  var isCPasswordValid = false;

  final allLanguageList = <LanguageModel>[].obs;
  final setLangList = <LanguageModel>[].obs;
  final selectedLanguageIdList = <int?>[].obs;
  final selectedLanguageList = <String?>[].obs;
  var langId = 0.obs;
  var selectedLang = "".obs;

  var isEditProfileValid = true.obs;

  @override
  void onInit() {
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    userId.value = storageBox.read(AppKeys.keyId);
    oldChangeController = TextEditingController();
    newChangeController = TextEditingController();
    confirmChangeController = TextEditingController();
    super.onInit();
    update();
  }

  @override
  void onReady() async {
    getAdminProfileDetails(schoolId.value);
    getLanguages();
  }

  void selectDatePicker(BuildContext context) async {
    DateTime? datePicker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1999),
        lastDate: DateTime(2028));
    if (datePicker != null && datePicker.toString() != selectedDate.value) {
      selectedDate.value = DateFormat('dd/MM/yyyy').format(datePicker);
    }
    update();
  }

  void getAdminProfileDetails(int schoolId) async {
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.adminProfileDetail}' '?schoolId=$schoolId&roleId=2')
        .catchError(handleError);
    log(response);
    if (response != null) {
      var adminResponse = adminProfileFromJson(response);
      storageBox.write(AppKeys.keyCheckInOutPin, adminResponse.checkInOutPin);
      storageBox.read(
        AppKeys.keyCheckInOutPin,
      );
      userId.value = adminResponse.id;
      profilePic.value = adminResponse.userProfilePic;
      firstName.value = adminResponse.userFirstName;
      lastName.value = adminResponse.userLastName;
      firstNameController.text = adminResponse.userFirstName;
      lastNameController.text = adminResponse.userLastName;
      phoneNumberController.text = adminResponse.userPhoneNumber;
      addressController.text = adminResponse.userAddress;
      emailController.text = adminResponse.userEmail;
      dateOfBirthController.text = adminResponse.dateOfBirth;
      selectedDate.value = adminResponse.dateOfBirth;
      bioController.text = adminResponse.adminBio;
      final predictedParts = adminResponse.userAddress.split(",");

      if (predictedParts.length > 3) {
        int startIndex = predictedParts.length - 3;
        cityController.text = predictedParts[startIndex].trim();
        stateController.text = predictedParts[startIndex+1].trim();
        countryController.text = predictedParts[startIndex+2].trim();
        addressController.text=adminResponse.userAddress;
        log("COUNTRY:${countryController.text}");
        log("STATE:${stateController.text}");
        log("CITY:${ cityController.text}");
      }
      email.value = adminResponse.userEmail;
      checkInCheckOut.value = adminResponse.checkInOutPin;
      selectedLanguageIdList.value=adminResponse.spokenLanguages;
      log("vandana admin profile ${checkInCheckOut.value}");
      log("LANG admin profile ${adminResponse.spokenLanguagesStr}");
      update();
    }
  }

  //GET ALL LANGUAGES
  void getLanguages() async {
    showLoading('');
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl, ApiEndPoints.getAllLanguages)
        .catchError(handleError);
    if (response != null) {
      isOnline.value = true;
      allLanguageList.value = languageModelFromJson(response);
      log("ALL LANGUAGE LIST ${allLanguageList.length}");
      for (var element in allLanguageList) {
        log("ALL LANGUAGE ID ${element.id}");
        for (var langIdElement in selectedLanguageIdList) {
          if(element.id==langIdElement){
            setLanguage(element);
          }
        }
      }
      language = allLanguageList.first;
      hideLoading();
      update();
    }
  }

  //SET LANGUAGES
  void setLanguage(LanguageModel languageModel){
    language = languageModel;
    langId.value = languageModel.id;
    selectedLang.value = languageModel.name.toString();
    addLanguages(selectedLang.value, langId.value);
    update();
  }

  void addLanguages(String name, int id) {
    selectedLanguageIdList.add(id);
    selectedLanguageList.add(name);
    setLangList.add(LanguageModel(id: id, name: name, code: ""));
    log("LANGUAGE LENGTH IS ${setLangList.length}");
    update();
  }

  void removeLanguages(String name, int id) {
    selectedLanguageIdList.remove(id);
    selectedLanguageList.remove(name);
    setLangList.removeWhere((element) => element.id==id);
    log("LANGUAGE LENGTH IS ${setLangList.length}");
    if(setLangList.isNotEmpty){
      setDropDown(false);
    }
    update();
  }

  void setDropDown(bool drop){
    isDropDown.value=drop;
    log("DROP DOWN IS ${isDropDown.value}");
    update();
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter correct current/old password';
    }
    return null;
  }

  String? newPasswordValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    } else if (!RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?\d)(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(value)) {
      return 'Password must contain minimum eight characters, \nat least one uppercase letter, one lowercase letter,\none number and one special character.';
    }
    return null;
  }

  String? cPasswordValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter confirm password';
    } else if (value.isNotEmpty && value != newChangeController.text) {
      return 'Password mismatched';
    }
    return null;
  }
  //CHECK IF ALL FIELDS ARE VALIDATED
  void validateProfile() {
    isEditProfileValid.value = adminProfileKey.currentState!.validate();

    Get.focusScope!.unfocus();
    if (isEditProfileValid.isTrue) {
      showLoading();
      adminProfileKey.currentState!.save();

      log("SAVE SCHOOL ID ${schoolId.value}");
      log("SAVE ROLE ID ${roleId.value}");
      log("SAVE USER ID ${userId.value}");
      log("SAVE FIRST NAME ${firstNameController.text}");
      log("SAVE LAST NAME ${lastNameController.text}");
      log("SAVE ADMIN BIO ${bioController.text}");
      log("SAVE PHONE ${phoneNumberController.text}");
      log("SAVE DOB ${selectedDate.value}");
      log("SAVE ADDRESS LINE ${addressController.text}");
      log("SAVE COUNTRY ${countryController.text}");
      log("SAVE STATE  ${stateController.text}");
      log("SAVE CITY ${cityController.text}");
      updateProfile(
          schoolId.value,
          roleId.value,
          userId.value,
          firstNameController.text,
          lastNameController.text,
          bioController.text,
          phoneNumberController.text,
          selectedDate.value,
          selectedLanguageIdList,
          addressController.text,countryController.text,stateController.text,cityController.text,"");
    }
  }

  // CALL UPDATE API
  void updateProfile(
      int schoolId,
      int roleId,
      int userId,
      String firstname,
      String lastname,
      String adminBio,
      String phoneNumber,
      String dob,
      dynamic langList,
      String addressLine1,String country,String state,String city,String zipCode) async {
    var param = {
      "schoolId": schoolId,
      "roleId": roleId,
      "userId": userId,
      "userFirstName": firstname,
      "userLastName": lastname,
      "adminBio": adminBio,
      "userPhoneNumber": phoneNumber,
      "dateOfBirth": dob,
      "userProfilePic": "",
      "spokenLanguages": langList,
      "userAddress": addressLine1,
      "countryName": country,
      "stateName": state,
      "cityName": city,
      "zipCode": zipCode,
    };
    try{
      var response = await BaseClient()
          .post(ApiEndPoints.devBaseUrl, ApiEndPoints.adminUpdateProfileDetail,param)
          .catchError(handleError);
      if (response != null) {
        isOnline.value = true;
        log("Profile has been updated successfully");
        Get.back();
        hideLoading();
        update();
      }
    }catch(e){
      log("update exception:${e.toString()}");
    }
  }

  //CHANGE PASSWORD
  void changePasswordSession(BuildContext context) {
    isPasswordValid = passwordKey.currentState!.validate();
    isNewPasswordValid = newPasswordKey.currentState!.validate();
    isCPasswordValid = cPasswordKey.currentState!.validate();
    Get.focusScope!.unfocus();
    if (isPasswordValid && isCPasswordValid) {
      passwordKey.currentState!.save();
      cPasswordKey.currentState!.save();
      log("OLD PASSWORD SAVE ${oldChangeController.text}");
      log("NEW PASSWORD SAVE ${newChangeController.text}");
      log("CONFIRM PASSWORD SAVE ${confirmChangeController.text}");
      changePasswordAPICall(oldChangeController.text,confirmChangeController.text,context);
    }
  }

  void changePasswordAPICall(
      String currentPassword, String newPassword, BuildContext context) async {
    var param = {
      "currentPassword": currentPassword,
      "newPassword": newPassword
    };
    showLoading();
    print("PASSWORD PARAM ==>$param");
    var response = await BaseClient()
        .patch(ApiEndPoints.devBaseUrl, ApiEndPoints.changePassword, param)
        .catchError(handleError);
    if (response != null) {
      print("RESPONSE CHANGED PASSWORD :${response.toString()}");
      hideLoading();
      messageToastSuccess(context, "", "Password Changed Successfully");
      Get.offAllNamed(AppRoute.login);
    } else {
      isError.value = false;
    }
    update();
  }
}

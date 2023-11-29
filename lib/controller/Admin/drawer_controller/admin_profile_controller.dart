import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:preto3/model/language_model.dart';
import '../../../model/admit/admin_profile.dart';
import '../../../network/api_end_points.dart';
import '../../../network/base_client.dart';
import '../../../utils/app_keys.dart';
import '../../base_controller.dart';
import 'package:get/get.dart';

class AdminProfileController extends GetxController with BaseController {
  final storageBox = GetStorage();
  var selectedDate = "".obs;
  LanguageModel? selectedValue;

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

  final allLanguageList = <LanguageModel>[].obs;
  final setLangList = <LanguageModel>[].obs;
  final langIdList = <int>[].obs;

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
      countryController.text = adminResponse.countryName;
      stateController.text = adminResponse.stateName;
      cityController.text = adminResponse.cityName;
      email.value = adminResponse.userEmail;
      checkInCheckOut.value = adminResponse.checkInOutPin;
      langIdList.value=adminResponse.spokenLanguages;
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
        for (var langIdElement in langIdList) {
          if(element.id==langIdElement){
            setLanguage(element);
          }
        }
      }
      selectedValue = allLanguageList.first;
      hideLoading();
      update();
    }
  }

  void setLanguage(LanguageModel languageModel){
    selectedValue = languageModel;
    langIdList.add(languageModel.id);
    setLangList.add(languageModel);
    update();
  }
  // void setEdit(bool value){
  //    isActive.value =  value;
  //    log("edit value$isActive");
  //    update();
  // }
  // void selectDatePicker()async{
  //   DateTime? datepicker = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate ?? DateTime.now(),
  //       firstDate: DateTime(1999),
  //       lastDate:  DateTime(2028));
  //   if(datepicker!=null && datepicker !=selectedDate){
  //     setState(() {
  //       selectedDate = datepicker;
  //     });
  //   }
  // }

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
          langIdList,
          addressController.text,countryController.text,stateController.text,cityController.text,"");
    }
  }

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
        hideLoading();
        update();
      }
    }catch(e){
      log("update exception:${e.toString()}");
    }
  }
}

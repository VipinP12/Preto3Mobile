import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../../model/admit/admin_profile.dart';
import '../../../network/api_end_points.dart';
import '../../../network/base_client.dart';
import '../../../utils/app_keys.dart';
import '../../base_controller.dart';
import 'package:get/get.dart';

class AdminProfileController extends GetxController with BaseController{
  final storageBox = GetStorage();
  DateTime? selectedDate;
  String selectedValue = 'Hindi';

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
  var checkInCheckOut = ''.obs;
  var profilePic = "".obs;
 var isActive =  true.obs;
  @override
  void onInit() {
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    oldChangeController = TextEditingController();
    newChangeController = TextEditingController();
    confirmChangeController = TextEditingController();
    super.onInit();
    update();
  }

  @override
  void onReady() async {

    getAdminProfileDetails(schoolId.value);
  }

  void getAdminProfileDetails(int schoolId) async {
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
        '${ApiEndPoints.adminProfileDetail}' '?schoolId=$schoolId&roleId=2')
        .catchError(handleError);
    log(response);
    if (response != null) {
      var adminResponse = adminProfileFromJson(response);
      storageBox.write(AppKeys.keyCheckInOutPin,  adminResponse.checkInOutPin);
      storageBox.read(AppKeys.keyCheckInOutPin,);
      profilePic.value = adminResponse.userProfilePic;
      firstName.value = adminResponse.userFirstName;
      lastName.value = adminResponse.userLastName;
      firstNameController.text = adminResponse.userFirstName;
      lastNameController.text = adminResponse.userLastName;
      phoneNumberController.text = adminResponse.userPhoneNumber;
      addressController.text = adminResponse.userAddress;
      emailController.text = adminResponse.userEmail;
      dateOfBirthController.text = adminResponse.dateOfBirth;
      bioController.text = adminResponse.adminBio;
      countryController.text = adminResponse.countryName;
      stateController.text = adminResponse.stateName;
      cityController.text = adminResponse.cityName;
      email.value = adminResponse.userEmail;
      checkInCheckOut.value = adminResponse.checkInOutPin;
      log("vandana ${checkInCheckOut.value}");
      update();
    }
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
}
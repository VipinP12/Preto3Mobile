import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_dialog.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/argument_keys.dart';

class EditCheckInController extends GetxController with BaseController {
  final storageBox = GetStorage();
  dynamic argumentData = Get.arguments;

  var remarkController = TextEditingController().obs;
  final remarkKey = GlobalKey<FormState>();
  var roleId = 0.obs;
  var schoolId = 0.obs;
  var roomId = 0.obs;
  var isLoading = false.obs;

  var isEditCheckIn = false.obs;
  var isRemarkValid = false;
  var isTimeValid = false;
  var remark = "".obs;

  var currentInTime = TimeOfDay.now();
  var currentOutTime = TimeOfDay.now();

  var selectedDate = "".obs;
  var selectedInTime = "".obs;
  var selectedOutTime = "".obs;
  var classRoom = "".obs;
  var status = "".obs;
  var profilePic = "".obs;
  var first = "".obs;
  var last = "".obs;

  var checkInId = 0.obs;
  var checkInTime = 0.obs;
  var checkOutTime = 0.obs;
  var checkInMode = 2;
  var checkOutMode = 3;

  @override
  void onInit() {
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    selectedDate.value = argumentData[ArgumentKeys.argumentChildDate];
    classRoom.value = argumentData[ArgumentKeys.argumentClassRoom];
    status.value = argumentData[ArgumentKeys.argumentStatus];
    profilePic.value = argumentData[ArgumentKeys.argumentChildProfilePic];
    first.value = argumentData[ArgumentKeys.argumentChildFirstName];
    last.value = argumentData[ArgumentKeys.argumentChildLastName];
    selectedInTime.value = argumentData[ArgumentKeys.argumentInTime];
    selectedOutTime.value = argumentData[ArgumentKeys.argumentOutTime];
    checkInId.value = argumentData[ArgumentKeys.argumentCheckInId];
    remarkController.value = TextEditingController();
    log("CHECK IN ID:${checkInId.value}");
    log("DATE:${selectedDate.value}");
    log("CLASS NAME:${classRoom.value}");
    log("STATUS:${status.value}");
    log("PROFILE:${profilePic.value}");
    log("IN:${selectedInTime.value}");
    log("OUT:${selectedOutTime.value}");
    // checkInTime.value=DateFormat();
    // checkOutTime.value=tempDate.millisecondsSinceEpoch;
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    remarkController.value.dispose();
  }

  String? remarkValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter a remark';
    }
    return null;
  }

  void pickInTime(BuildContext context) async {
    var pickedTime = await showTimePicker(
      context: context,
      initialTime: currentInTime,
    );
    if (pickedTime != null && pickedTime != currentInTime) {
      currentInTime = pickedTime;
      print("CURRENT TIME:$currentInTime");
    }
    DateTime tempDate = DateFormat("hh:mm")
        .parse("${currentInTime.hour}:${currentInTime.minute}");
    var dateFormat = DateFormat("hh:mm a"); // you can change the format here

    checkInTime.value = tempDate.millisecondsSinceEpoch;
    selectedInTime.value = dateFormat.format(tempDate).toString();
    // selectedDate.value =DateFormat('hh:mm a').format(currentTime);
    print("CURRENT TIME SELECTED :${selectedInTime.value}");
    print("IN TIME EPOCH :${checkInTime.value}");
    update();
  }

  void pickOutTime(BuildContext context) async {
    var pickedTime = await showTimePicker(
      context: context,
      initialTime: currentOutTime,
    );
    if (pickedTime != null && pickedTime != currentOutTime) {
      currentOutTime = pickedTime;
    }
    DateTime tempDate = DateFormat("hh:mm")
        .parse("${currentOutTime.hour}:${currentOutTime.minute}");
    var dateFormat = DateFormat("hh:mm a"); // you can change the format here
    checkOutTime.value = tempDate.millisecondsSinceEpoch;
    selectedOutTime.value = dateFormat.format(tempDate).toString();
    // selectedDate.value =DateFormat('hh:mm a').format(currentTime);
    print("CURRENT TIME SELECTED :${selectedOutTime.value}");
    print("OUT TIME EPOCH :${checkOutTime.value}");
    update();
  }

  void editCheckInSession() {
    isRemarkValid = remarkKey.currentState!.validate();
    if (checkInTime.value > checkOutTime.value) {
      log("CHECK IN TIME CANNOT LESS");
      isTimeValid = false;
      update();
    } else {
      isTimeValid = true;
      update();
    }
    Get.focusScope!.unfocus();
    if (isRemarkValid && isTimeValid) {
      remarkKey.currentState!.save();
      upCheckedInApiCall(
          checkInId.value, checkInTime.value, checkOutTime.value, remark.value);
    } else {
      AppDialog.snackBarDialog(
          message: "Checkout time cannot be greater checkin time");
    }
  }

  void upCheckedInApiCall(
      int id, int checkIn, int checkOut, String remark) async {
    print("EDIT CHECK-IN ID $id ");
    print("EDIT CHECK-IN TIME $checkIn ");
    print("EDIT CHECK-OUT TIME $checkOut ");
    print("EDIT CHECK-OUT TIME $remark ");
    print("EDIT CHECK-OUT TIME $remark ");
    dynamic param = {
      "remarks": remark,
      "id": id,
      "editCheckInOutData": [
        {"time": checkIn, "mode": 2},
        {"time": checkOut, "mode": 3}
      ],
      "schoolId": schoolId.value
    };

    print("PARAM $param ");

    var response = await BaseClient()
        .post(
            ApiEndPoints.devBaseUrl, ApiEndPoints.editStudentCheckInOut, param)
        .catchError(handleError);
    if (response != null) {
      Get.back();
    }
  }
}

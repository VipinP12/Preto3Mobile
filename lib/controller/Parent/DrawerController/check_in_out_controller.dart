import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:preto3/controller/base_controller.dart';
import '../../../model/check_in_out_parent_model.dart';
import '../../../model/parent/parent_students_model.dart';
import '../../../network/api_end_points.dart';
import '../../../network/base_client.dart';
import '../../../utils/app_keys.dart';

class CheckInOutController extends GetxController with BaseController {
  final storageBox = GetStorage();
  dynamic argumentData = Get.arguments;
  var currentDate = DateTime.now();

  var allChildern = <ParentStudents>[].obs;
  var dropDownInitialValue = "Select child".obs;
  ParentStudents? allChildValue;
  var schoolId = 0.obs;
  var roleId = 0.obs;
  var datam = <Datum>[].obs;
  var studentId = 0.obs;
  var filterEndDate = "".obs;
  var filterStartDate = "".obs;

  @override
  void onInit() {
    super.onInit();
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    roleId.value = storageBox.read(AppKeys.keyRoleId);
  }

  @override
  void onReady() {
    getParentChildern();
  }

  void setStartFilterDate(val) {
    filterStartDate.value = val;
  }

  void setEndFilterDate(val) {
    filterEndDate.value = val;
  }

  pickDate(BuildContext context) async {
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null) {
      return DateFormat("yyyy-MM-dd").format(pickedDate);
    } else {
      return "";
    }
  }

  void getParentChildern() async {
    showLoading();
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.getParentMyChildern}?schoolId=${schoolId.value}')
        .catchError(handleError);

    allChildern.value = parentStudentsFromJson(response);
    hideLoading();
    update();
  }

  void getCheckInOutFilterDetails(bool isDateFlag) async {
    showLoading();
    var parems;
    if (isDateFlag) {
      parems = {
        "schoolId": schoolId.value,
        "roleId": roleId.value,
        "startDate": filterStartDate.value,
        "endDate": filterEndDate.value,
        "studentId": studentId.value
      };
    } else {
      parems = {
        "schoolId": schoolId.value,
        "roleId": roleId.value,
        "studentId": studentId.value
      };
    }
    print(json.encode(parems));
    var response = await BaseClient()
        .post(ApiEndPoints.devBaseUrl, ApiEndPoints.checkInOutParent, parems)
        .catchError(handleError);
    if (response != null) {
      print("getCheckInOutFilterDetails===>" + response);
      if (response.toString().trim().isNotEmpty) {
        var checkInOutData = checkInOutParentModelFromJson(response);
        if (checkInOutData.isNotEmpty) {
          datam.value = checkInOutData[0].data;
        } else {
          datam.value = [];
        }
      } else {
        datam.value = [];
      }
    }
    hideLoading();
    update();
  }

  bool dateDifference() {
    if (filterStartDate.isEmpty) {
      return false;
    }
    if (filterEndDate.isEmpty) {
      return false;
    }
    DateTime startDateCheck =
        DateFormat("yyyy-MM-dd").parseUTC(filterStartDate.value);
    DateTime endDateCheck =
        DateFormat("yyyy-MM-dd").parseUTC(filterEndDate.value);
    int diffInDays = endDateCheck.difference(startDateCheck).inDays;
    if (diffInDays == 0) {
      return true;
    } else if (diffInDays > 0) {
      return true;
    } else {
      return false;
    }
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../model/parent/authorize_pickup_model.dart';
import '../../../model/parent/parent_students_model.dart';
import '../../../utils/app_keys.dart';

class AuthorizePikupController extends GetxController with BaseController {
  final storageBox = GetStorage();
  dynamic argumentData = Get.arguments;

  //var authorizeLisst = <ParentStudents>[].obs;
  var refreshController = RefreshController();
  var listOfAuthorizePickup = <AuthorizePickupModel>[].obs;
  var schoolId = 0.obs;
  var roleId = 0.obs;
  var filterStartDate = "".obs;
  var filterEndDate = "".obs;
  var currentDate = DateTime.now();
  var url = ''.obs;
  var allChildern = <ParentStudents>[].obs;
  var student = [].obs;

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59);
    url.value =
        '?schoolId=${schoolId.value}&dateFrom=${startOfDay.toUtc().millisecondsSinceEpoch}&dateTo=${endOfDay.toUtc().millisecondsSinceEpoch}';
  }

  @override
  void onReady() {
    print(url.value);
    String url1 = '?schoolId=${schoolId.value}';
    getParentChildern(url1);
  }

  void getParentChildern(String urlVal) async {
    showLoading();
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.getParentMyChildern}$urlVal')
        .catchError(handleError);
    if (response != null) {
      allChildern.value = parentStudentsFromJson(response);
      student.value = [];
      for (ParentStudents parentStudents in allChildern.value) {
        print(parentStudents.id);
        student.value.add(parentStudents.id);
      }
      url.value =
          "${url.value}&studentIds=${student.value.toString().replaceAll("[", "").replaceAll("]", "")}";
      getListOfAuthorizePickup(url);
    }

    hideLoading();
    update();
  }

  void applyFilter() {
    if (filterEndDate.value.trim().isNotEmpty &&
        filterStartDate.value.trim().isNotEmpty) {
      url.value =
          '?schoolId=${schoolId.value}&dateFrom=${DateFormat("MM/dd/yyyy").parseUTC(filterStartDate.value).millisecondsSinceEpoch}&dateTo=${DateFormat("MM/dd/yyyy").parseUTC(filterEndDate.value).millisecondsSinceEpoch}&studentIds=${student.value.toString().replaceAll("[", "").replaceAll("]", "")}';
    } else {
      url.value =
          '?schoolId=${schoolId.value}&dateFrom=${DateFormat("MM/dd/yyyy").parseUTC(filterStartDate.value).millisecondsSinceEpoch}&dateTo=${DateFormat("MM/dd/yyyy").parseUTC(filterStartDate.value).millisecondsSinceEpoch}&studentIds=${student.value.toString().replaceAll("[", "").replaceAll("]", "")}';
    }
    print(url);
    getListOfAuthorizePickup(url.value);
  }

  void getListOfAuthorizePickup(var url) async {
    print('${ApiEndPoints.getParentMyChildern}$url');
    showLoading();
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl, '${ApiEndPoints.getAllPickUps}$url')
        .catchError(handleError);

    if (response != null && response.toString().trim().isNotEmpty) {
      listOfAuthorizePickup.value = authorizePickupModelFromJson(response);
    } else {
      listOfAuthorizePickup.value = [];
    }
    hideLoading();
    update();
  }

  Future<void> deleteAuthorizePickup(int pickupId) async {
    showLoading();
    var response = await BaseClient()
        .delete(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.deletePickUps}?schoolId=${schoolId.value}&roleId=${roleId.value}&authorizedPickUpId=$pickupId')
        .catchError(handleError);
    hideLoading();
    if (response != null) {
      getListOfAuthorizePickup(url.value);
    }
    hideLoading();
  }

  pickDate(BuildContext context) async {
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null) {
      return DateFormat("MM/dd/yyyy").format(pickedDate);
    } else {
      return "";
    }
  }

  dateDifference() {
    if (filterStartDate.isEmpty) {
      return false;
    }
    if (filterEndDate.isEmpty) {
      return false;
    }
    DateTime startDateCheck =
        DateFormat("MM/dd/yyyy").parseUTC(filterStartDate.value);
    DateTime endDateCheck =
        DateFormat("MM/dd/yyyy").parseUTC(filterEndDate.value);
    int diffInDays = endDateCheck.difference(startDateCheck).inDays;
    if (diffInDays == 0) {
      return true;
    } else if (diffInDays > 0) {
      return true;
    } else {
      return false;
    }
  }

  void setPickStartDate(var start) {
    filterStartDate.value = start.toString();
  }

  void setPickEndDate(var end) {
    filterEndDate.value = end.toString();
  }

  void onRefresh() async {
    filterStartDate.value = "";
    filterEndDate.value = "";
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59);
    url.value =
        '?schoolId=${schoolId.value}&dateFrom=${startOfDay.toUtc().millisecondsSinceEpoch}&dateTo=${endOfDay.toUtc().millisecondsSinceEpoch}';
    url.value =
        "${url.value}&studentIds=${student.value.toString().replaceAll("[", "").replaceAll("]", "")}";
    getListOfAuthorizePickup(url);
    await Future.delayed(const Duration(milliseconds: 500));
    refreshController.refreshCompleted();
  }
}

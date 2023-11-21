import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/model/daily_activity_model.dart';
import 'package:preto3/model/student_profile_model.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/argument_keys.dart';

class ParentStudentDetailsController extends GetxController
    with BaseController {
  final storageBox = GetStorage();
  dynamic argumentData = Get.arguments;
  var studentId = 0.obs;
  var schoolId = 0.obs;
  var roleId = 0.obs;
  var firstName = "".obs;
  var lastName = "".obs;
  var profilePic = "".obs;
  var checkinPin = "".obs;
  var inTime = "".obs;
  var outTime = "".obs;
  var totalHours = "".obs;
  var studentName = "".obs;
  var activityDate = "".obs;
  var startTime = "".obs;
  var endTime = "".obs;
  var startEpoch = 0.obs;
  var endEpoch = 0.obs;

  var notFound = false.obs;

  final allergiesList = <String?>[].obs;
  final medicationList = <String?>[].obs;
  final studentDailyActivity = <Student>[].obs;
  final activityList = <Activity>[].obs;
  StudentProfileModelDart? studentProfile;
  @override
  void onInit() {
    studentId.value = argumentData[ArgumentKeys.argumentStudentId];
    checkinPin.value = argumentData[ArgumentKeys.argumentCheckIn] ?? "";
    firstName.value =
        argumentData[ArgumentKeys.argumentChildFirstName].toString();
    lastName.value =
        argumentData[ArgumentKeys.argumentChildLastName].toString();
    profilePic.value =
        argumentData[ArgumentKeys.argumentChildProfilePic].toString();
    inTime.value = argumentData[ArgumentKeys.argumentInTime].toString();
    outTime.value = argumentData[ArgumentKeys.argumentOutTime].toString();
    totalHours.value = argumentData[ArgumentKeys.argumentTotalTime].toString();
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    studentProfile;
    super.onInit();
  }

  @override
  void onReady() {
    getActivityDetailByStudentId(schoolId.value, roleId.value, studentId.value);
    getStudentProfile(studentId.value, roleId.value);
    super.onReady();
  }

  void getActivityDetailByStudentId(int schoolId, roleId, int studentId) async {
    studentDailyActivity.clear();
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.allActivity}?studentId=$studentId&schoolId=$schoolId&roleId=$roleId')
        .catchError(handleError);
    if (response != null && response != "") {
      log("RESPONSE:${jsonDecode(response.toString())}");
      var activityResponse = dailyActivityModelFromJson(response);
      studentDailyActivity.value = activityResponse.first.student;
      for (var element in studentDailyActivity) {
        studentName.value =
            '${element.firstName.toString()} ${element.lastName.toString()}';
        if (element.studentId == studentId) {
          activityList.value = element.activities;
        }
        log("LENGTH:${activityList.length}");
      }

      notFound.value = false;
      update();
    } else {
      notFound.value = true;
      errorMessage.value;
      update();
    }
    /*try {

    } catch (e) {
      e.toString();
      print(e.toString());
    }*/
  }

  void getStudentProfile(int studentId, int roleId) async {
    showLoading();
    var response = await BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.studentProfileDetails}'
            '?id=$studentId&roleId=$roleId')
        .catchError(handleError);

    studentProfile = studentProfileModelDartFromJson(response);
    log("PROFILE RESP:${studentProfile!.studentPersonalDetails.firstName}");
    log("PROFILE ALLERGIES:${studentProfile!.emergencyContacts.length}");
    hideLoading();
    update();
  }
}

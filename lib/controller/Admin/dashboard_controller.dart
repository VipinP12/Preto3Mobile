import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/controller/daily_activity_controller.dart';
import 'package:preto3/model/admin_dashboard_model.dart';
import 'package:preto3/model/birthday_model.dart';
import 'package:preto3/model/daily_activity_model.dart';
import 'package:preto3/model/dashboard_categories_model.dart';
import 'package:preto3/model/staff/staff_dashboard_model.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/app_string.dart';
import 'package:preto3/utils/argument_keys.dart';

class DashboardController extends GetxController with BaseController {
  final storageBox = GetStorage();
  dynamic argumentData = Get.arguments;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var firstName = "".obs;
  var lastName = "".obs;
  var birthDate = "".obs;
  var roleId = 0.obs;
  var schoolId = 0.obs;
  var studentCheckedIn = 0.obs;
  var studentCheckedOut = 0.obs;
  var studentAbsent = 0.obs;
  var studentTotalCount = 0.obs;
  var staffCheckedIn = 0.obs;
  var staffCheckedOut = 0.obs;
  var staffAbsent = 0.obs;
  var staffTotalCount = 0.obs;
  var roomCount = 0.obs;
  bool isWebRequest = false;
  var activityDate = "".obs;
  final allBirthdayList = <BirthdayResponse?>[].obs;
  final dailyActivity = <DailyActivityModel>[].obs;
  final studentDailyActivity = <Student>[].obs;
  final activityList = <Activity>[].obs;

  var uniqueActivity = [].obs;
  Set<dynamic> seenIds = {};

  var notFound = false.obs;
  @override
  void onInit() {
    super.onInit();
    firstName.value = storageBox.read(AppKeys.keyFirstName);
    lastName.value = storageBox.read(AppKeys.keyLastName);
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    print("ROLE ID:${roleId.value}");
    print("SCHOOL ID:${schoolId.value}");
  }

  @override
  void onReady() {
    getAdminDashboard(roleId.value, schoolId.value, isWebRequest);
    Get.find<DailyActivityController>()
        .getAllActivity(schoolId.value, roleId.value);

  }

  //ADMIN DASHBOARD
  List<DashboardCategoriesModel> dashboardCategory = [
    DashboardCategoriesModel(
      name: AppString.room,
      subtitle: "0 Rooms",
      assetImage: AppAssets.dashboardRoom,
      colors: AppColor.dashRoomText,
      bgColors: AppColor.dashRoomBg,
    ),
    DashboardCategoriesModel(
        name: AppString.checkIn,
        assetImage: AppAssets.dashboardCheckIn,
        colors: AppColor.dashCheckInText,
        bgColors: AppColor.dashCheckInBg),
    DashboardCategoriesModel(
        name: AppString.communication,
        assetImage: AppAssets.dashboardComm,
        colors: AppColor.dashCommText,
        bgColors: AppColor.dashCommBg),
    DashboardCategoriesModel(
        name: AppString.fees,
        assetImage: AppAssets.dashboardFees,
        colors: AppColor.dashFeesText,
        bgColors: AppColor.dashFeesBg),
    DashboardCategoriesModel(
        name: AppString.schoolSetting,
        assetImage: AppAssets.dashboardSchoolSetting,
        colors: AppColor.dashSchoolSettingText,
        bgColors: AppColor.dashSchoolSettingBg),
  ];

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  void getAdminDashboard(int roleId, int schoolId, bool isWebRequest) async {
    showLoading('Fetching data');
    var response = await BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.adminDashboard}'
            '?roleId=$roleId&schoolId=$schoolId&isWebRequest=$isWebRequest')
        .catchError(handleError);
    print("DASHBOARD RESPONSE:$response");
    if (response != null) {
      isOnline.value = true;
      var dashResponse =
          AdminDashboardModel.fromJson(jsonDecode(response.toString()));
      studentCheckedIn.value =
          dashResponse.studentRatioResponse.inSideFacilityCount!;
      studentCheckedOut.value =
          dashResponse.studentRatioResponse.outSideFacilityCount!;
      studentAbsent.value = dashResponse.studentRatioResponse.notShowUpCount!;
      studentTotalCount.value = dashResponse.studentRatioResponse.totalCount!;
      staffCheckedIn.value =
          dashResponse.staffRatioResponse.inSideFacilityCount!;
      staffCheckedOut.value =
          dashResponse.staffRatioResponse.outSideFacilityCount!;
      staffAbsent.value = dashResponse.staffRatioResponse.notShowUpCount!;
      staffTotalCount.value = dashResponse.staffRatioResponse.totalCount!;
      roomCount.value = dashResponse.roomCount;
      roomCount.value = dashResponse.roomCount;
      allBirthdayList.value = dashResponse.birthdayResponse;
      if (allBirthdayList.isNotEmpty) {
        String formattedDate = DateFormat.Md()
            .format(DateTime.parse(allBirthdayList[0]!.dob.toString()));
        birthDate.value = formattedDate;
        print(formattedDate);
      }
      hideLoading();
      update();
    }
  }


  Future<void> removePushNotification() async {
    print("Delete Device token from server");
    var response = await BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.userDeleteDeviceInfo}'
            '?roleId=${roleId.value}&schoolId=${schoolId.value}')
        .catchError(handleError);
    if (response != null) {
      print(response);
    }
  }
}

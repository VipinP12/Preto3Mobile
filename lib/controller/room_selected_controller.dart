import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/model/room_selected_model.dart';
import 'package:preto3/model/room_selected_staff_model.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/argument_keys.dart';

import '../model/staff/check_in_model.dart';

class RoomSelectedController extends GetxController
    with GetSingleTickerProviderStateMixin, BaseController {
  final storageBox = GetStorage();
  dynamic argumentData = Get.arguments;
  var roleId = 0.obs;
  var schoolId = 0.obs;
  var classId = 0.obs;
  var isLoading = false.obs;
  var isVisible = true.obs;
  var isValid = false.obs;
  var isActive = true.obs;
  var nowDate = "".obs;
  var isSelected = false.obs;
  var currentDate = DateTime.now();

  late TabController tabController;
  final allRoomList = <CheckInModel>[].obs;

  final List<Tab> myTabs = const [
    Tab(
      text: "Student",
    ),
    Tab(
      text: "Staff",
    ),
  ];
  // final checkList = <CheckInModel>[].obs;
  final allStudentList = <RoomSelectedModel?>[].obs;
  final allStaffList = <RoomSelectedStaffModelDart?>[].obs;

  @override
  void onInit() {
    super.onInit();
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    classId.value = argumentData[ArgumentKeys.argumentClassId];
    // roomId.value = argumentData[ArgumentKeys.argumentClassRoom];
    // date.value = argumentData[ArgumentKeys.argumentChildDate];
    // nowDate.value = DateFormat('yyyy-MM-dd').format(currentDate).toString();
    log("ROLE ID:${roleId.value}");
    log("CLASS ID:${classId.value}");
    // log("room id:${roomId.value}");
    currentDate = DateTime.now();
    nowDate.value = DateFormat('yyyy-MM-dd').format(currentDate).toString();
    tabController = TabController(length: myTabs.length, vsync: this);

  }

  @override
  void onReady() {
    super.onReady();
    log("STAFF ROOM");
    getClassRoomStudent(roleId.value, classId.value, schoolId.value);
    getClassRoomStaff(schoolId.value, classId.value, isActive.value);
  }

  void getClassRoomStudent(int roleId, int classId, int schoolId ) async {
    showLoading();
    String timez = await configureLocalTimeZone();
    var response = await BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.checkList}'
            '?roleId=$roleId&schoolId=$schoolId&classId=$classId')
            // '?roleId=2&schoolId=1002939&classId=1002350')
        .catchError(handleError);
    allStudentList.value = roomSelectedModelFromJson(response);
    log("ALL STUDENTS :${allStudentList.length}");
    hideLoading();
    update();
  }
  // void getAllStudent(String date, int schoolId) async {
  //   if (allRoomList.value.isNotEmpty) {
  //     showLoading("");
  //     String timez = await configureLocalTimeZone();
  //     var response = await BaseClient()
  //         .get(
  //         ApiEndPoints.devBaseUrl,
  //         '${ApiEndPoints.checkList}'
  //             '?dateSelected=$date&schoolId=$schoolId&roleId=$roleId&timezone=$timez')
  //         .catchError(handleError);
  //     if (response != null && response != "") {
  //       checkList.value = checkInModelFromJson(response);
  //       isSelected.value = false;
  //       update();
  //     }
  //     hideLoading();
  //   }
  // }
  void getClassRoomStaff(int schoolId, int classId, bool isActive) async {
    showLoading();
    var response = await BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.allRoomStaff}'
            '?isActive=$isActive&schoolId=$schoolId&classId=$classId')
        .catchError(handleError);
    allStaffList.value = roomSelectedStaffModelDartFromJson(response)!;
    hideLoading();
    log("ALL STAFF :${allStaffList.length}");
    update();
  }
  Future<String> configureLocalTimeZone() async {
    const MethodChannel channel = MethodChannel('flutter_native_timezone');
    final String? localTimezone =
    await channel.invokeMethod("getLocalTimezone");
    print(localTimezone);
    return localTimezone!;
    // print(localTimezone);
    // tz.initializeTimeZones();
    // var locations = tz.timeZoneDatabase.locations;
    // print(locations);
    // return tz.getLocation(locations.keys.first).toString(); //Asia/Calcutta
  }
}

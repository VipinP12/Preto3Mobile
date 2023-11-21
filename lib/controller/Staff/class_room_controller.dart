import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/model/room_selected_model.dart';
import 'package:preto3/model/staff/check_in_model.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/argument_keys.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class ClassRoomController extends GetxController with BaseController {
  final storageBox = GetStorage();
  dynamic argumentData = Get.arguments;

  var roleId = 0.obs;
  var schoolId = 0.obs;
  var classId = 0.obs;
  var isLoading = false.obs;
  var isActive = true.obs;
  var isAllAbsent = false.obs;
  var notContentFound = false.obs;

  final allStudentList = <RoomSelectedModel?>[].obs;
  final allRoomList = <CheckInModel>[].obs;
  var nowDate = "".obs;
  var currentDate = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    classId.value = argumentData[ArgumentKeys.argumentClassId];
    isAllAbsent.value = argumentData[ArgumentKeys.argumentAllAbsent];
    log("ROLE ID:${roleId.value}");
    log("SCHOOL ID:${schoolId.value}");
    log("CLASS ID:${classId.value}");
    log("ALL ABSENT:${isAllAbsent.value}");
    currentDate = DateTime.now();
    nowDate.value = DateFormat('yyyy-MM-dd').format(currentDate).toString();
  }

  @override
  void onReady() {
    super.onReady();
    // getClassRoomStudent(roleId.value,schoolId.value,schoolId.value);
    getAllStudentByRoom(classId.value, nowDate.value, schoolId.value);
  }

  void getClassRoomStudent(int roleId, int schoolId, int classId) async {
    showLoading();
    var response = await BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.allRoomStudent}'
            '?roleId=$roleId&schoolId=$schoolId&classId=$classId')
        .catchError(handleError);
    allStudentList.value = roomSelectedModelFromJson(response);
    log("ALL STUDENTS :${allStudentList.length}");
    hideLoading();
    update();
  }

  void getAllStudentByRoom(int roomId, String date, int schoolId) async {
    String timez = await configureLocalTimeZone();
    var response = await BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.checkList}'
            '?roomId=$roomId&dateSelected=$date&schoolId=$schoolId&timezone=$timez&dateSelected=${DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()}')
        .catchError(handleError);
    if (response != null) {
      if (response == "") {
        notContentFound.value = true;
        update();
      } else {
        allRoomList.value = checkInModelFromJson(response);
        update();
      }
    }
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

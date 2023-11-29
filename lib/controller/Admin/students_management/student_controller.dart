import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/model/room_list_model.dart';
import 'package:preto3/model/room_selected_model.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/argument_keys.dart';

class StudentController extends GetxController with BaseController {
  final storageBox = GetStorage();
  dynamic argumentData = Get.arguments;

  var roleId = 0.obs;
  var schoolId = 0.obs;
  var classId = 0.obs;

  final allStudentList = <RoomSelectedModel?>[].obs;
  final allRoomList = <RoomListModel?>[].obs;

  RoomListModel? myRoom;
  var selectedClassRoom = "".obs;
  var selectedClassRoomId = 0.obs;
  var studentTotal = 0.obs;
  var studentCheckedIn = 0.obs;
  var studentCheckedOut = 0.obs;
  var studentAbsent = 0.obs;

  @override
  void onInit() {
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    log(argumentData.toString());
    studentTotal.value = argumentData[ArgumentKeys.argumentStudentTotal];
    studentCheckedIn.value = argumentData[ArgumentKeys.argumentStudentCheckIn];
    studentCheckedOut.value =
        argumentData[ArgumentKeys.argumentStudentCheckOut];
    studentAbsent.value = argumentData[ArgumentKeys.argumentStudentAbsent];
    log("TOTAL STUDENT:${studentTotal.value}");
    super.onInit();
  }

  @override
  void onReady() {
    getAllRoomList(roleId.value, schoolId.value);
    getAllActiveStudent(roleId.value, schoolId.value);
    super.onReady();
  }

  void getAllRoomList(int roomId, int schoolId) async {
    showLoading('Fetching data');
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.allRoom}' '?roleId=$roleId&schoolId=$schoolId')
        .catchError(handleError);
    if (response != null) {
      log("RESPONSE:$response");
      allRoomList.value = roomListModelFromJson(response)!;
      hideLoading();
      update();
    } else {
      log("ERROR BOOL:${isError.value}");
      log("ERROR RESPONSE:${errorMessage.toString()}");
      update();
    }
  }

  void setRoom(RoomListModel room) {
    myRoom = room;
    selectedClassRoom.value = room.className.toString();
    selectedClassRoomId.value = room.classId!.toInt();
    getAllActiveStudentInRoom(
        roleId.value, schoolId.value, selectedClassRoomId.value);
    update();
  }

  void getAllActiveStudent(int roleId, int schoolId) async {
    showLoading();
    var response = await BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.allRoomStudent}'
            '?roleId=$roleId&schoolId=$schoolId')
        .catchError(handleError);
    allStudentList.value = roomSelectedModelFromJson(response);
    log("ALL STUDENTS :${allStudentList.length}");
    hideLoading();
    update();
  }

  void getAllActiveStudentInRoom(int roleId, int schoolId, int classId) async {
    showLoading();
    var response = await BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.allRoomStudent}'
            '?roleId=$roleId&schoolId=$schoolId&classId=$classId')
        .catchError(handleError);
    allStudentList.value = roomSelectedModelFromJson(response);
    log("ALL STUDENTS IN ROOM :${allStudentList.length}");
    hideLoading();
    update();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/model/comm_staff_model.dart';
import 'package:preto3/model/comm_student_model.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_keys.dart';

class CreateGroupController extends GetxController
    with GetSingleTickerProviderStateMixin, BaseController {
  final storageBox = GetStorage();
  late TabController tabController;

  final List<Tab> myTabs = const [
    Tab(
      text: "Student",
    ),
    Tab(
      text: "Staff",
    ),
  ];

  var isSelectedStudent = false.obs;
  var isSelectedStaff = false.obs;
  final groupNameKey = GlobalKey<FormState>();
  var groupNameController = TextEditingController();

  final staffList = <CommStaffModel>[].obs;
  final studentList = <CommStudentModel>[].obs;
  final staffSelectList = <CommStaffModel>[].obs;
  final studentSelectList = <CommStudentModel>[].obs;

  var roleId = 0.obs;
  var schoolId = 0.obs;
  var userId = 0.obs;
  var firstname = "".obs;
  var username = "".obs;

  @override
  void onInit() {
    tabController = TabController(length: myTabs.length, vsync: this);
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    userId.value = storageBox.read(AppKeys.keyId);
    firstname.value = storageBox.read(AppKeys.keyFirstName);
    username.value = storageBox.read(AppKeys.keyUserName);
    super.onInit();
  }

  @override
  void onReady() {
    getAllStudent(schoolId.value, roleId.value);
    getAllStaff(schoolId.value, roleId.value);

    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  void getAllStaff(int schoolId, int roleId) async {
    showLoading("");
    var response = await BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.allStaffCommunication}'
            '?schoolId=$schoolId&roleId=$roleId&isGroup=true',
            flag: true)
        .catchError(handleError);
    if (response != null) {
      print(response);
      staffList.value = commStaffModelFromJson(response);
      isSelectedStaff.value = false;
      hideLoading();
      update();
    }
  }

  void getAllStudent(int schoolId, int roleId) async {
    showLoading("");
    var response = await BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.allStudent}'
            '?schoolId=$schoolId&roleId=$roleId&isGroup=true',
            flag: true)
        .catchError(handleError);
    if (response != null) {
      studentList.value = commStudentModelFromJson(response);
      isSelectedStudent.value = false;
      hideLoading();
      update();
    }
  }

  Future<bool> createGroup(List<int> studentids, List<int> staffids,
      String groupId, String groupNameVal) async {
    var param = {
      "schoolId": schoolId.value,
      "roleId": roleId.value,
      "isBroadcast": false,
      "roomName": groupNameVal,
      "roomId": groupId,
      "staffIds": staffids,
      "studentIds": studentids
    };
    print(param);
    var response = await BaseClient()
        .post(ApiEndPoints.devBaseUrl, ApiEndPoints.parentSaveGroup, param,
            flag: true)
        .catchError(handleError);
    if (response != null) {
      return true;
    } else {
      return false;
    }
  }

  String? groupNameValidator(String value) {
    if (value.trim().isNotEmpty) {
      return null;
    }
    return 'Group name can not be empty.';
  }
}

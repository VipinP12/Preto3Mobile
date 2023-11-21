import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/model/chat_message_model.dart';
import 'package:preto3/model/comm_get_staff_group_model.dart';
import 'package:preto3/model/comm_staff_model.dart';
import 'package:preto3/model/comm_student_model.dart';
import 'package:preto3/model/staff/student_group_create_details_model.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/network/socket_server.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../Parent/parent_dashboard_controller.dart';

class CommunicationController extends GetxController
    with GetSingleTickerProviderStateMixin, BaseController {
  final storageBox = GetStorage();
  var isLoading = false.obs;
  var isVisible = true.obs;
  var isValid = false.obs;
  var userCount = 0.obs;
  var userNameList = [].obs;

  bool isActive = true;
  final messageKey = GlobalKey<FormState>();

  var searchStaffController = TextEditingController();
  var messageController = TextEditingController();

  //late WebSocketChannel channel;

  late TabController tabController;
  var refreshController = RefreshController();
  var refreshControllerStaffs = RefreshController();
  var refreshControllerStudent = RefreshController();
  var refreshController1 = RefreshController();

  var adminRoleList = [
    "Parents",
    "Staff",
    "Create a Group",
    "Broadcast a message",
    "Message to Room"
  ];
  var staffRoleList = ["Parents", "Staff", "Create a Group"];
  var groupList = [];
  //var staffList = <ListContent>[].obs;
  var staffCommList = <CommStaffModel>[].obs;
  var studentCommList = <CommStudentModel>[].obs;
  var getStaffList = <CommGetStaffGroupModel>[].obs;
  var getStudentList = <CommGetStaffGroupModel>[].obs;
  var getGroupList = <CommGetStaffGroupModel>[].obs;
  var messageList = <MessageResponse>[].obs;
  var storeCreateGroupDetails = <StudentGroupCreateDetails>[].obs;
  var staffIdList = <int>[].obs;
  var studentIdList = <int>[].obs;
  var studentUsernameList = <String>[].obs;
  var staffUsernameList = <String>[].obs;
  var lastMessageTime = "".obs;
  var roomName = "".obs;

  var selectedStudentId = 0.obs;
  var selectedStaffId = 0.obs;
  var selectedClassId = 0.obs;

  var selectedChildIndex = 0;
  var isSelected = false.obs;
  var staffSelect = false.obs;
  var studentSelect = false.obs;
  var adminSelect = false.obs;
  var userId = 0.obs;
  var roleId = 0.obs;
  var schoolId = 0.obs;
  var groupId = "".obs;
  var firstname = "".obs;
  var username = "".obs;
  var searchStaff = "".obs;
  var flagCreateRoom = 0.obs;

  final List<Tab> myTabs = const [
    Tab(
      text: "Student",
    ),
    Tab(
      text: "Staff",
    ),
    Tab(
      text: "Groups",
    ),
  ];

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
    refreshController = RefreshController(initialRefresh: false);
    refreshControllerStaffs = RefreshController(initialRefresh: false);
    refreshControllerStudent = RefreshController(initialRefresh: false);
    refreshController1 = RefreshController(initialRefresh: false);
    getAllActiveStudents(schoolId.value, roleId.value);
    getAllStaff(schoolId.value, roleId.value);
    getStudentGroupFromBackend(schoolId.value, roleId.value);
    if (roleId.value != 4) {
      getGroupFromBackend();
      getStaffGroupFromBackend(schoolId.value, roleId.value);
    }
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  String? messageValidator(String value) {
    if (value.trim().isNotEmpty) {
      return null;
    }
    return 'Message can not be empty.';
  }

  String getTimeOrDate(DateTime date, BuildContext context) {
    DateTime now = DateTime.now();

    // Check if the input date is today
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      // Return the current time in "HH:mm a" format
      return DateFormat('hh:mm a').format(date);
    } else {
      // Check if the input date is in the past
      if (date.isBefore(now)) {
        // Return the input date in "MM/dd/yyyy" format
        return DateFormat('MM/dd/yyyy').format(date);
      } else {
        // Return an error message if the input date is in the future
        return DateFormat('hh:mm a').format(now);
      }
    }
  }

  Future<bool> staffCreateStudentGroup(String groupId, String groupName,
      String studentId, String staffId) async {
    var param = {
      "schoolId": schoolId.value,
      "roleId": roleId.value,
      "studentId": studentId,
      "staffId": staffId,
      "isBroadcast": false,
      "roomName": groupName,
      "roomId": groupId,
      "staffIds": [],
      "studentIds": [],
      "classIds": []
    };

    log("PAYLOAD Teacher :$param");
    try {
      var response = await BaseClient()
          .post(ApiEndPoints.devBaseUrl, ApiEndPoints.parentSaveGroup, param,
              flag: true)
          .catchError(handleError);
      if (response != null) {
        print("SAVE GROUP RESPONSE $response");
        return true;
      }
    } catch (e) {
      return false;
    }

    return false;
  }

  Future<bool> staffCreateStaffGroup(
      String groupId, String groupName, String staffId) async {
    var param = {
      "schoolId": schoolId.value,
      "roleId": roleId.value,
      "staffId": staffId,
      "isBroadcast": false,
      "roomName": groupName,
      "roomId": groupId
    };

    log("PRINT STAFF CREATE GROUP WITH STUDENT LIST $param");
    try {
      var response = await BaseClient().post(
          ApiEndPoints.devBaseUrl, ApiEndPoints.parentSaveGroup, param,
          flag: true);
      print("SAVE GROUP RESPONSE $response");
      if (response != null) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> createNewGroup() async {
    return await callParentSaveGroup(
        schoolId.value,
        roleId.value,
        selectedStudentId.value,
        selectedStaffId.value,
        false,
        roomName.value,
        groupId.value);
  }

  Future<bool> callParentSaveGroup(
      int schoolId,
      int roleId,
      int selectedStudentId,
      int selectedStaffId,
      bool isBroadcast,
      String roomName,
      String groupId) async {
    String groupName = Get.find<ParentDashboardController>()
        .childDetailsList[
            Get.find<ParentDashboardController>().selectedChildIndex]
        .firstName
        .toLowerCase();

    String groupId =
        "${Get.find<ParentDashboardController>().childDetailsList[Get.find<ParentDashboardController>().selectedChildIndex].firstName}${Get.find<ParentDashboardController>().childDetailsList[Get.find<ParentDashboardController>().selectedChildIndex].lastName}_${selectedStaffId}_${DateTime.now().millisecondsSinceEpoch}"
            .toLowerCase();

    var param = {
      "schoolId": schoolId,
      "roleId": roleId,
      "studentId": selectedStudentId,
      "staffId": selectedStaffId,
      "isBroadcast": false,
      "roomName": groupName,
      "roomId": groupId,
      "staffIds": [],
      "studentIds": [],
      "classIds": []
    };
    showLoading();
    log("PAYLOAD :$param");
    var response = await BaseClient()
        .post(ApiEndPoints.devBaseUrl, ApiEndPoints.parentSaveGroup, param,
            flag: true)
        .catchError(handleError);
    print("SAVE GROUP RESPONSE $response");
    if (response != null) {
      //await getStudentGroupFromBackend(schoolId, roleId);
      hideLoading();
      return true;
    } else {
      return false;
    }
  }

  void changeChildIndex(int index) {
    selectedChildIndex = index;
    selectedStudentId.value = studentCommList[index].id;
    print("SELECTED ${studentCommList[index].studentFullName}");
    print("SELECTED STUDENT ID${selectedStudentId.value}");
    update();
  }

  void getAllActiveStudents(int schoolId, int roleId) async {
    var response = await BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.allStudentCommunication}'
            '?schoolId=$schoolId&roleId=$roleId',
            flag: true)
        .catchError(handleError);
    if (response != null && response.toString().trim() != '') {
      print(response);
      studentCommList.value = commStudentModelFromJson(response);
      log("ALL STUDENT LIST:${studentCommList.length}");
      update();
    }
  }

  void getAllStaff(int schoolId, int roleId) async {
    showLoading("");
    var response = await BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.allStaffCommunication}'
            '?schoolId=$schoolId&roleId=$roleId',
            flag: true)
        .catchError(handleError);
    if (response != null && response != "") {
      staffCommList.value = commStaffModelFromJson(response);
      log("ALL STAFF LIST:${staffCommList.length}");
      isSelected.value = false;
      hideLoading();
      update();
    }
  }

  void addMessageInGroupLastMessage(MessageResponse message) {
    int index =
        getStudentList.indexWhere((item) => item.roomId == message.groupId);
    if (index != -1) {
      getStudentList.value[index].message = message.message;
      getStudentList.value[index].date = message.date!;
    }
    int indexStaffs =
        getStaffList.indexWhere((item) => item.roomId == message.groupId);
    if (indexStaffs != -1) {
      getStaffList.value[indexStaffs].message = message.message;
      getStaffList.value[indexStaffs].date = message.date!;
    }

    int indexGroup =
        getGroupList.indexWhere((item) => item.roomId == message.groupId);
    if (indexGroup != -1) {
      getGroupList.value[indexGroup].message = message.message;
      getGroupList.value[indexGroup].date = message.date!;
    }
    update();
  }

  void addMessageInGroupLastMessageNotification(MessageResponse message) {
    int index =
        getStudentList.indexWhere((item) => item.roomId == message.groupId);
    if (index != -1) {
      sendMessageNotification(message, getStudentList.value[index].isBroadcast);
    }
    int indexStaffs =
        getStaffList.indexWhere((item) => item.roomId == message.groupId);
    if (indexStaffs != -1) {
      sendMessageNotification(
          message, getStaffList.value[indexStaffs].isBroadcast);
    }

    int indexGroup =
        getGroupList.indexWhere((item) => item.roomId == message.groupId);
    if (indexGroup != -1) {
      sendMessageNotification(
          message, getGroupList.value[indexGroup].isBroadcast);
    }
    update();
  }

  void sendMessageNotification(MessageResponse message, bool isBrodcast) {
    BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.sendPushNotifications}'
            '?groupId=${message.groupId}&userName=${message.userName}&message=${message.message}&schoolId=${schoolId.value}&isBroadcast=$isBrodcast',
            flag: true)
        .catchError(handleError);
  }

  Future<void> getStudentGroupFromBackend(int schoolId, int roleId) async {
    var response = await BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.getGroups}'
            '?schoolId=$schoolId&roleId=$roleId&student=true',
            flag: true)
        .catchError(handleError);
    log("getStudentGroupFromBackend => $response");
    if (response != null && response != "") {
      getStudentList.value = commGetStaffGroupModelFromJson(response);
      for (var element in getStudentList) {
        SocketServer.instance!.socket.send(jsonEncode(
            {"groupId": element.roomId, "messageType": "JOIN_GROUP"}));
        SocketServer.instance!.socket.send(jsonEncode(
            {"groupId": element.roomId, "messageType": "GET_LAST_MESSAGE"}));
      }
      hideLoading();
      update();
    }
    isLoading.value=false;
  }

  Future<void> getStaffGroupFromBackend(int schoolId, int roleId) async {
    var response = await BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.getGroups}'
            '?schoolId=$schoolId&roleId=$roleId&staff=true',
            flag: true)
        .catchError(handleError);
    log("getStaffGroupFromBackend => $response");
    if (response != null && response != "") {
      getStaffList.value = commGetStaffGroupModelFromJson(response);
      for (var element in getStaffList) {
        SocketServer.instance!.socket.send(jsonEncode(
            {"groupId": element.roomId, "messageType": "JOIN_GROUP"}));
        SocketServer.instance!.socket.send(jsonEncode(
            {"groupId": element.roomId, "messageType": "GET_LAST_MESSAGE"}));
      }
      hideLoading();
      update();
    }
  }

  Future<void> getGroupFromBackend() async {
    var response = await BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.getGroups}'
            '?schoolId=${schoolId.value}&roleId=${roleId.value}',
            flag: true)
        .catchError(handleError);
    log("getStudentGroupFromBackend => $response");
    if (response != null && response != "") {
      getGroupList.value = commGetStaffGroupModelFromJson(response);
      for (var element in getGroupList) {
        SocketServer.instance!.socket.send(jsonEncode(
            {"groupId": element.roomId, "messageType": "JOIN_GROUP"}));
        SocketServer.instance!.socket.send(jsonEncode(
            {"groupId": element.roomId, "messageType": "GET_LAST_MESSAGE"}));
      }
      hideLoading();
      update();
    }
  }

  Future<void> deleteGroup(String roomId, int roll) async {
    var response = await BaseClient()
        .delete(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.deleteGroups}'
            '?roomId=$roomId',
            flag: true)
        .catchError(handleError);
    log("Roll in chat=>$roll");
    if (response != null) {
      log(response);
      SocketServer.instance!.deleteGroup(roomId);
      if (roll == 1) {
        await getStudentGroupFromBackend(schoolId.value, roleId.value);
        update();
      } else if (roll == 2) {
        getStaffGroupFromBackend(schoolId.value, roleId.value);
      } else if (roll == 3) {
        await getGroupFromBackend();
      } else {
        getStudentGroupFromBackend(schoolId.value, roleId.value);
        await getGroupFromBackend();
      }
    }
  }

  void onRefresh() async {
    getGroupFromBackend();
    await Future.delayed(const Duration(milliseconds: 500));
    refreshController.refreshCompleted();
  }

  void onRefreshStaffs() async {
    getAllStaff(schoolId.value, roleId.value);
    getStaffGroupFromBackend(schoolId.value, roleId.value);
    await Future.delayed(const Duration(milliseconds: 500));
    refreshControllerStaffs.refreshCompleted();
  }

  void onRefreshStudent() async {
    getAllActiveStudents(schoolId.value, roleId.value);
    getStudentGroupFromBackend(schoolId.value, roleId.value);
    await Future.delayed(const Duration(milliseconds: 500));
    refreshControllerStudent.refreshCompleted();
  }

  void onRefreshCommunicationListOnParent() async {
    getStudentGroupFromBackend(schoolId.value, roleId.value);
    getAllActiveStudents(schoolId.value, roleId.value);
    getAllStaff(schoolId.value, roleId.value);
    await Future.delayed(const Duration(milliseconds: 500));
    refreshController1.refreshCompleted();
  }
}

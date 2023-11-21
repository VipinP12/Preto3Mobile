import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/model/room_list_model.dart';
import 'package:preto3/model/staff/check_in_model.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_keys.dart';

class CheckInController extends GetxController with BaseController {
  final storageBox = GetStorage();
  dynamic argumentData = Get.arguments;
  // final staffDashboardController = Get.find<StaffDashboardController>();
  final remarkKey = GlobalKey<FormState>();
  var remarkController = TextEditingController().obs;
  var isRemarkValid = false;
  var isTimeValid = false;
  var roleId = 0.obs;
  var schoolId = 0.obs;
  var roomId = 0.obs;
  var isLoading = false.obs;
  var isSelected = false.obs;
  var canCheckIn = true.obs;
  var isVisible = true.obs;
  var isValid = false.obs;
  var isEditCheckIn = false.obs;
  var nowDate = "".obs;
  var currentDate = DateTime.now();
  var currentInTime = TimeOfDay.now();
  var currentOutTime = TimeOfDay.now();
  var selectedDate = "".obs;
  var selectedInTime = "".obs;
  var selectedOutTime = "".obs;
  var checkInTime = 0.obs;
  var checkOutTime = 0.obs;
  var checkInMode = 2;

  var checkOutMode = 3;
  var remark = "".obs;
  var isCheckButtonVisible = false.obs;

  var isEnableCheckInButton = false.obs;
  var isEnableCheckOutButton = false.obs;

  RoomListModel? room;
  final allRoomList = <RoomListModel?>[].obs;
  final checkList = <CheckInModel>[].obs;
  final checkAbsentList = <CheckInModel>[].obs;
  final checkPresentList = <CheckInModel>[].obs;
  final idList = <int>[].obs;

  var noContentFound = false.obs;
  var message = "".obs;

  @override
  void onInit() {
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    var currentDate = DateTime.now();
    nowDate.value = DateFormat('yyyy-MM-dd').format(currentDate).toString();
    selectedDate.value =
        DateFormat('EEE,MM/dd/yyyy').format(currentDate).toString();

    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await getAllRoomList(roleId.value, schoolId.value);
    getAllStudent(nowDate.value, schoolId.value);
  }

  Future<void> getAllRoomList(int roomId, int schoolId) async {
    showLoadingHideBackground('Fetching data');
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.allRoom}' '?roleId=$roleId&schoolId=$schoolId')
        .catchError(handleError);
    if (response != null) {
      print("RESPONSE:$response");
      allRoomList.value = roomListModelFromJson(response)!;
      hideLoadingHideBackground();
      update();
    } else {
      hideLoadingHideBackground();
      print("ERROR BOOL:${isError.value}");
      print("ERROR RESPONSE:${errorMessage.toString()}");
      update();
    }
  }

  String? remarkValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter a remark';
    }
    return null;
  }

  void setClassRoom(RoomListModel roomModel) {
    roomId.value = roomModel.classId!;
    room = roomModel;
    getAllStudentByRoom(roomId.value, nowDate.value, schoolId.value);
    update();
  }

  void selectStudent(bool selected) {
    isSelected.value = !selected;
    update();
  }

  void setAllStudent(bool selected) {
    isSelected.value = !selected;
    update();
  }

  void getAllStudentByRoom(int roomId, String date, int schoolId) async {
    String timez = await configureLocalTimeZone();
    var response = await BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.checkList}'
            '?roomId=$roomId&dateSelected=${nowDate.value}&schoolId=$schoolId&timezone=$timez')
        .catchError(handleError);
    if (response != null && response != "") {
      checkList.value = checkInModelFromJson(response);
      noContentFound.value = false;
      update();
    } else {
      checkList.value = [];
      noContentFound.value = true;
      message.value = errorMessage.value;
      print(message.value);
      update();
    }
  }

  void getAllStudent(String date, int schoolId) async {
    if (allRoomList.value.isNotEmpty) {
      showLoading("");
      String timez = await configureLocalTimeZone();
      var response = await BaseClient()
          .get(
              ApiEndPoints.devBaseUrl,
              '${ApiEndPoints.checkList}'
              '?dateSelected=$date&schoolId=$schoolId&roleId=$roleId&timezone=$timez')
          .catchError(handleError);
      if (response != null && response != "") {
        checkList.value = checkInModelFromJson(response);
        isSelected.value = false;
        update();
      }
      hideLoading();
    }
  }

  void pickDate(BuildContext context) async {
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2010),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != currentDate) {
      currentDate = pickedDate;
    }

    nowDate.value = DateFormat('yyyy-MM-dd').format(currentDate).toString();

    selectedDate.value = DateFormat('EEE,MM/dd/yyyy').format(currentDate);
    print("CURRENT DATE SELECTED :${selectedDate.value}");
    getAllStudent(nowDate.value, schoolId.value);
    update();
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
    DateTime tempDate = DateFormat("h:mm a")
        .parse("${currentInTime.hour}:${currentInTime.minute}");
    var dateFormat = DateFormat("h:mm a"); // you can change the format here

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
    DateTime tempDate = DateFormat("h:mm a")
        .parse("${currentOutTime.hour}:${currentOutTime.minute}");
    var dateFormat = DateFormat("h:mm a"); // you can change the format here
    checkOutTime.value = tempDate.millisecondsSinceEpoch;
    selectedOutTime.value = dateFormat.format(tempDate).toString();
    // selectedDate.value =DateFormat('hh:mm a').format(currentTime);
    print("CURRENT TIME SELECTED :${selectedOutTime.value}");
    print("OUT TIME EPOCH :${checkOutTime.value}");
    update();
  }

  void checkInSession() async {
    print("CHECKED IN ");
    var studentList = [];
    studentList.clear();
    print("ID LIST:${idList.length}");

    for (var element in idList) {
      var student = {};
      student["id"] = element;
      studentList.add(student);
    }
    var time = DateTime.now().toLocal().millisecondsSinceEpoch;

    print("TIMEZONE LOCAL:$time");
    print("BUTTON ENABLED$isEnableCheckInButton");
    print("BUTTON ENABLED$isEnableCheckOutButton");
    var params = {
      'schoolId': schoolId.value,
      'checkInMode': checkInMode,
      'checkInOutData': studentList
    };
    print("PAYLOAD :$params");
    var response = await BaseClient()
        .post(ApiEndPoints.devBaseUrl, ApiEndPoints.addCheckIn, params)
        .catchError(handleError);
    if (response != null) {
      print("RESPONSE CHECKIN:$response");
      isEnableCheckInButton.value = true;
      isEnableCheckOutButton.value = false;
      studentList.clear();
      idList.clear();
      getAllStudent(nowDate.value, schoolId.value);
      update();
    }
  }

  void checkOutSession() async {
    print("CHECKED IN ");
    var studentList = [];
    studentList.clear();

    for (var element in idList) {
      var student = {};
      student["id"] = element;
      studentList.add(student);
    }
    var params = {
      'schoolId': schoolId.value,
      'checkInMode': checkOutMode,
      'checkInOutData': studentList
    };
    print("PAYLOAD :$params");
    var response = await BaseClient()
        .post(ApiEndPoints.devBaseUrl, ApiEndPoints.addCheckIn, params)
        .catchError(handleError);
    if (response != null) {
      print("RESPONSE CHECKIN:$response");
      isEnableCheckInButton.value = true;
      isEnableCheckOutButton.value = false;
      studentList.clear();
      idList.clear();
      getAllStudent(nowDate.value, schoolId.value);
      // staffDashboardController.getStaffDashboard(schoolId.value);
      update();
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

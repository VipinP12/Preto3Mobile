import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/model/daily_activity_model.dart';
import 'package:preto3/model/daily_activity_type_model.dart';
import 'package:preto3/model/room_selected_model.dart';
import 'package:preto3/model/save_activity_model.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/app_string.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../components/custom_dialog.dart';
import '../model/room_list_model.dart';

class DailyActivityController extends GetxController with BaseController {
  final storageBox = GetStorage();
  var selectedAddIndex = 0;

  RoomListModel? room;
  final allRoomList = <RoomListModel?>[].obs;
  final checkList = <RoomSelectedModel>[].obs;
  final dailyActivity = <DailyActivityModel>[].obs;
  final studentDailyActivity = <Student>[].obs;
  // final activityTypeList = <DailyActivityTypeModel>[].obs;
  final activityDetailList = <ActivityDetail>[].obs;
  final filteredActivity = <DailyActivityTypeModel>[].obs;
  final filteredNew = <Student>[].obs;
  final activityList = <Activity>[].obs;
  var idList = <String>[].obs;
  var profilePicImageList = <String>[].obs;
  var activityImage = <String>[].obs;
  var activityId = <String>[].obs;

  var uniqueActivity = [].obs;
  Set<dynamic> seenIds = {};
  var refreshController = RefreshController();

  var roleId = 0.obs;
  var schoolId = 0.obs;
  var roomId = 0.obs;
  var nowDate = "".obs;
  var selectedAddStartDate = "".obs;
  var selectedStartDate = "".obs;
  var selectedEndDate = "".obs;
  var selectedStartTime = "".obs;
  var selectedEndTime = "".obs;
  var studentName = "".obs;
  var activityDate = "".obs;
  var activityName = "".obs;
  var activityStartTime = "".obs;
  var activityEndTime = "".obs;
  var activityDesc = "".obs;

  var isSelected = false.obs;
  var notFound = false.obs;
  var currentDate = DateTime.now();
  var currentStartTime = const TimeOfDay(hour: 8, minute: 30);
  var currentEndTime = const TimeOfDay(hour: 5, minute: 30);

  var selectedImagePath = "".obs;
  var selectedFileName = "".obs;
  var attachedUrl = "".obs;
  var filename = "".obs;
  var startTime = "".obs;
  var endTime = "".obs;
  var fromDate = 0.obs;
  var endDate = 0.obs;
  var startEpoch = 0.obs;
  var endEpoch = 0.obs;

  @override
  void onInit() {
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    nowDate.value = DateFormat('MM/dd/yyyy').format(currentDate).toString();
    refreshController = RefreshController(initialRefresh: false);
    selectedAddStartDate.value = DateFormat('MM/dd/yyyy').format(currentDate);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    if (roleId.value == 3||roleId.value == 2) {
      getAllRoomList(roleId.value, schoolId.value);
      getAllStudent(roleId.value, schoolId.value);
      getAllActivityBySchool(schoolId.value, roleId.value);
    }
    getAllActivity(schoolId.value, roleId.value);
  }

  addActivityIndex(int index) {
    if (activityTypeList[index].isSelected) {
      activityId.add(activityTypeList[index].activityId.toString());
      activityImage.add(activityTypeList[index].imageType);
      filename.value = activityTypeList[index].title;
      var activity = ActivityDetail(
          activityId: null,
          startTime: startEpoch.value,
          endTime: endEpoch.value,
          activityType: activityTypeList[index].activityId,
          description: activityTypeList[index].title,
          activityClassMapId: null);
      activityDetailList.add(activity);
      log("##ID ADDED## ${activityId.length}");
      log("##IMAG ADDED## ${activityImage.length}");
      log("##ACTIVITY ADDED## ${activityDetailList.length}");
      update();
    } else {
      activityId.remove(activityTypeList[index].activityId.toString());
      activityImage.remove(activityTypeList[index].imageType);
      var activity = ActivityDetail(
          activityId: null,
          startTime: startEpoch.value,
          endTime: endEpoch.value,
          activityType: activityTypeList[index].activityId,
          description: activityTypeList[index].title,
          activityClassMapId: null);
      activityDetailList.remove(activity);
      log("##ID REMOVED## ${activityId.length}");
      log("##IMAG REMOVED## ${activityImage.length}");
      log("##ACTIVITY REMOVED## ${activityDetailList.length}");
      update();
    }
  }

  addStudentIndex(int index) {
    if (checkList[index].isSelected) {
      String id = checkList[index].id.toString();
      idList.add(id);
      profilePicImageList.add(checkList[index].profilePic);
      log("##LIST## ${idList.length}");
      log("##IMAGE## ${checkList[index].profilePic}");
      update();
    } else {
      String id = checkList[index].id.toString();
      idList.remove(id);
      profilePicImageList.remove(checkList[index].profilePic);
      log("##LIST## ${idList.length}");
      update();
    }
    update();
  }

  void setClassRoom(RoomListModel roomModel) {
    roomId.value = roomModel.classId!;
    room = roomModel;
    log("ROOM ID:${roomId.value}");
    getAllStudentByRoom(roomId.value, roleId.value, schoolId.value);
    update();
  }

  void getAllRoomList(int roleId, int schoolId) async {
    showLoading('Fetching data');
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.allRoom}' '?roleId=$roleId&schoolId=$schoolId')
        .catchError(handleError);
    if (response != null) {
      log("RESPONSE:$response");
      allRoomList.value = roomListModelFromJson(response)!;
      room = allRoomList.first;
      roomId.value = allRoomList.first!.classId!;
      hideLoading();
      update();
    } else {
      isError.value;
      errorMessage.value;
      log("ERROR BOOL:${isError.value}");
      log("ERROR RESPONSE:${errorMessage.toString()}");
      hideLoading();
      update();
    }
  }

  void getAllStudent(int roleId, int schoolId) async {
    showLoading("");
    var response = await BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.allRoomStudent}'
            '?roleId=$roleId&schoolId=$schoolId')
        .catchError(handleError);
    log("STUDENT RESPONSE:${response.toString()}");
    if (response != null && response != "") {
      checkList.value = roomSelectedModelFromJson(response);
      isSelected.value = false;
      hideLoading();
      update();
    } else {
      isError.value;
      errorMessage.value = "No content found";
      log("ERROR BOOL:${isError.value}");
      log("ERROR RESPONSE:${errorMessage.toString()}");
      hideLoading();
      update();
    }
  }

  void getAllStudentByRoom(int roomId, int roleId, int schoolId) async {
    checkList.clear();
    var response = await BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.allRoomStudent}'
            '?roomId=$roomId&roleId=$roleId&schoolId=$schoolId')
        .catchError(handleError);
    log("STUDENTS RESPONSE==>${response.toString()}");
    if (response != null && response != "") {
      checkList.value = roomSelectedModelFromJson(response);

      if (idList.isNotEmpty) {
        for (String id in idList) {
          final index =
              checkList.indexWhere((element) => element.id.toString() == id);
          checkList.value[index].isSelected = true;
        }
      }
      final index =
          checkList.indexWhere((element) => element.isSelected == false);
      if (index != -1) {
        isSelected.value = false;
      } else {
        isSelected.value = true;
      }
      hideLoading();
      update();
    } else {
      isError.value;
      errorMessage.value = "No content found";
      log("ERROR BOOL:${isError.value}");
      log("ERROR RESPONSE:${errorMessage.toString()}");
      hideLoading();
      update();
    }
  }

  void getAllActivityBySchool(int schoolId, int roleId) async {
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.allActivityBySchool}?roleId=$roleId&schoolId=$schoolId')
        .catchError(handleError);
    if (response != null) {
      log("RESPONSE:${response.toString()}");
      // activityTypeList.value = dailyActivityTypeModelFromJson(response);
      notFound.value = false;
      update();
    } else {
      notFound.value = true;
      errorMessage.value = "No content found";
      log("ERROR BOOL:${isError.value}");
      log("ERROR RESPONSE:${errorMessage.toString()}");
      update();
    }
  }

  void getAllActivity(int schoolId, int roleId) async {
    showLoading();
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.allActivity}?schoolId=$schoolId&roleId=$roleId')
        .catchError(handleError);
    if (response != null && response != "") {
      log("RESPONSE ACTIVITY:${response.toString()}");
      try {
        dailyActivity.value = dailyActivityModelFromJson(response);
        activityDate.value = DateFormat('MM/dd/yyyy')
            .format(
                DateTime.fromMillisecondsSinceEpoch(dailyActivity.first.date))
            .toString();
        studentDailyActivity.value = dailyActivity.first.student;
        for (var dailyElement in studentDailyActivity) {
          activityList.value = dailyElement.activities;
        }

        for (var map in activityList) {
          log("ACTIVITY LIST:${map.name}");
          if (!seenIds.contains(map.activityType)) {
            uniqueActivity.add(map);
            seenIds.add(map.activityType);
          }
        }
        notFound.value = false;
      } catch (e) {
        log(e.toString());
      }
      update();
    } else {
      notFound.value = true;
      errorMessage.value;
      log("ERROR BOOL:${isError.value}");
      log("ERROR RESPONSE:${errorMessage.toString()}");
      update();
    }
    hideLoading();
  }

  void getActivityDetailByStudentId(
      int schoolId, int studentId, int roleId) async {
    studentDailyActivity.clear();

    try {
      var response = await BaseClient()
          .get(ApiEndPoints.devBaseUrl,
              '${ApiEndPoints.allActivity}?studentIds=$studentId&schoolId=$schoolId&roleId=$roleId')
          .catchError(handleError);
      if (response != null && response != "") {
        var activityResponse = dailyActivityModelFromJson(response);

        studentDailyActivity.value = activityResponse.first.student;
        for (var element in studentDailyActivity) {
          studentName.value =
              '${element.firstName.toString()} ${element.lastName.toString()}';
          activityList.value = element.activities;
        }
        for (var activityElement in activityList) {
          startTime.value = activityElement.activityStartTime;
          endTime.value = activityElement.activityEndTime;
          update();
        }
        activityDate.value = DateFormat('MM/dd/yyyy')
            .format(DateTime.parse(startTime.value))
            .toString();
        log("RESPONSE FOR STUDENT:${activityDate.value}");
        var startTimeV =
            DateFormat("hh:mm a").format(DateTime.parse(startTime.value));
        var endTimeV =
            DateFormat("hh:mm a").format(DateTime.parse(endTime.value));
        log(startTimeV);
        log(endTimeV);
        notFound.value = false;
        update();
      } else {
        notFound.value = true;
        errorMessage.value;
        update();
      }
    } catch (e) {
      e.toString();
      log(e.toString());
    }
  }

  void addStartDate(BuildContext context) async {
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != currentDate) {
      currentDate = pickedDate;
    }

    nowDate.value = DateFormat('MM/dd/yyyy').format(currentDate).toString();

    selectedAddStartDate.value = DateFormat('MM/dd/yyyy').format(currentDate);
    log("START DATE SELECTED :${selectedAddStartDate.value}");
    // getAllStudent(nowDate.value, schoolId.value);
    update();
  }

  void pickStartDate(BuildContext context) async {
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2010),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != currentDate) {
      currentDate = pickedDate;
    }
    // currentDate = currentDate.subtract(const Duration(days: 1));
    nowDate.value = DateFormat('MM/dd/yyyy').format(currentDate).toString();

    selectedStartDate.value = DateFormat('MM/dd/yyyy').format(currentDate);
    DateTime tempDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day, 00, 00);
    fromDate.value = tempDate.millisecondsSinceEpoch;
    log("START DATE SELECTED :${selectedStartDate.value}");
    log("HOUR SELECTED :${currentStartTime.hour}");
    log("MINUTES SELECTED :${currentStartTime.minute}");
    log("START EPOCH SELECTED :${fromDate.value}");
    // getAllStudent(nowDate.value, schoolId.value);
    update();
  }

  void setFilterStartDate() {
    String inputString = selectedEndDate.value;
    log(inputString);
    DateFormat dateFormat = DateFormat("MM/dd/yyyy");
    DateTime dateVal = dateFormat.parse(inputString);
    DateTime tempDate =
        DateTime(dateVal.year, dateVal.month, dateVal.day, 00, 00);
    log(tempDate.toString());
    fromDate.value = tempDate.millisecondsSinceEpoch;
    update();
  }

  void setFilterEndDate() {
    String inputString = selectedStartDate.value;
    selectedEndDate.value = inputString;
    log(inputString);
    DateFormat dateFormat = DateFormat("MM/dd/yyyy");
    DateTime dateVal = dateFormat.parse(inputString);
    DateTime tempDate =
        DateTime(dateVal.year, dateVal.month, dateVal.day, 23, 59);
    log(tempDate.toString());
    endDate.value = tempDate.millisecondsSinceEpoch;
    update();
  }

  void pickEndDate(BuildContext context) async {
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2010),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != currentDate) {
      currentDate = pickedDate;
    }

    nowDate.value = DateFormat('MM/dd/yyyy').format(currentDate).toString();

    selectedEndDate.value = DateFormat('MM/dd/yyyy').format(currentDate);
    DateTime tempDate = DateTime(
        currentDate.year, currentDate.month, currentDate.day, 23, 59, 59);
    endDate.value = tempDate.millisecondsSinceEpoch;
    log("END DATE SELECTED :${selectedEndDate.value}");
    log("HOUR SELECTED :${currentStartTime.hour}");
    log("MINUTES SELECTED :${currentStartTime.minute}");
    log("END EPOCH SELECTED :${endDate.value}");
    // getAllStudent(nowDate.value, schoolId.value);
    update();
  }

  void pickStartTime(BuildContext context, int index) async {
    var pickedTime = await showTimePicker(
      context: context,
      initialTime: currentStartTime,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child ?? Container(),
        );
      },
    );
    if (pickedTime != null && pickedTime != currentStartTime) {
      currentStartTime = pickedTime;
      log("CURRENT TIME:$currentStartTime");
    }
    DateTime tempDate = DateTime(currentDate.year, currentDate.month,
        currentDate.day, currentStartTime.hour, currentStartTime.minute);
    var dateFormat = DateFormat("hh:mm a"); // you can change the format here

    startEpoch.value = tempDate.millisecondsSinceEpoch;
    selectedStartTime.value = dateFormat.format(tempDate);
    activityDetailList[index].startTime = startEpoch.value;
    activityDetailList[index].selectedStartTime = selectedStartTime.value;
    // selectedDate.value =DateFormat('hh:mm a').format(currentTime);
    log("IN TIME EPOCH :${startTime.value}");
    log("SELECTED INDEX TIME :${activityDetailList[index].selectedStartTime} at index $index");
    log("CURRENT TIME SELECTED :${selectedStartTime.value}");
    update();
  }

  void pickEndTime(BuildContext context, int index) async {
    var pickedTime = await showTimePicker(
      context: context,
      initialTime: currentEndTime,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child ?? Container(),
        );
      },
    );
    if (pickedTime != null && pickedTime != currentEndTime) {
      currentEndTime = pickedTime;
    }
    DateTime tempDate = DateTime(currentDate.year, currentDate.month,
        currentDate.day, currentEndTime.hour, currentEndTime.minute);
    var dateFormat = DateFormat(
        "hh:mm a"); // you can change the format hereyou can change the format here
    endEpoch.value = tempDate.millisecondsSinceEpoch;
    selectedEndTime.value = dateFormat.format(tempDate).toString();
    activityDetailList[index].endTime = endEpoch.value;
    activityDetailList[index].selectedEndTime = selectedEndTime.value;
    // selectedDate.value =DateFormat('hh:mm a').format(currentTime);
    log("CURRENT TIME SELECTED :${selectedEndTime.value}");
    log("SELECTED INDEX TIME :${activityDetailList[index].selectedEndTime} at index $index");
    log("OUT TIME EPOCH :${endTime.value}");
    update();
  }

  void saveSession(BuildContext context) async {
    showLoading();
    var param = {
      "classId": roomId.value,
      "schoolId": schoolId.value,
      "roleId": roleId.value,
      "studentIds": idList,
      "activityDetail": activityDetailList.toJson(),
      "activityImgUrl": []
    };
    if (selectedFileName.isNotEmpty) {
      try {
        await uploadActivityFile(
            selectedImagePath.value, selectedFileName.value);
        if (attachedUrl.value != "") {
          param = {
            "classId": roomId.value,
            "schoolId": schoolId.value,
            "roleId": roleId.value,
            "studentIds": idList,
            "activityDetail": activityDetailList.toJson(),
            "activityImgUrl": [attachedUrl.value]
          };
        }
      } catch (e) {
        log(e.toString());
      }
    }

    log("PARAM:${jsonEncode(param)}");
    var response = await BaseClient()
        .post(ApiEndPoints.devBaseUrl, ApiEndPoints.saveActivity, param)
        .catchError(handleError);
    if (response != null) {
      log("RESPONSE:${response.toString()}");
      hideLoading();
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialog(
            message: "Activity saved successfully",
            roleId: roleId.value,
          );
        },
      );
      // Get.dialog(
      //     barrierDismissible: false,
      //     CustomDialog(
      //       message: "Activity saved successfully",
      //       roleId: roleId.value,
      //     ));
    } else {
      hideLoading();
    }
  }

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      final fileBytes = await File(pickedFile.path).readAsBytes();
      if (fileBytes.lengthInBytes > 2097152) {
        Get.snackbar(
            "Error", "The image file size cannot be greater than 2 MB.",
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
    }
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedFileName.value =
          filename.value + DateTime.now().millisecondsSinceEpoch.toString();
      log("FILE NAME $selectedFileName");
    } else {
      Get.snackbar("Error", "No Image Selected",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void filterActivitySession() async {
    showLoading();
    var param = {
      "dateFrom": fromDate.value,
      "dateTo": endDate.value,
      "schoolId": schoolId.value,
      "roleId": roleId.value,
    };
    log("PARAM FILTER:$param");
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.allActivity}?schoolId=${schoolId.value}&roleId=${roleId.value}&dateFrom=${fromDate.value}&dateTo=${endDate.value}')
        .catchError(handleError);
    if (response != null && response != "") {
      // log("RESPONSE ACTIVITY:${response.toString()}");
      dailyActivity.value = dailyActivityModelFromJson(response);
      log("DAILY ACTIVITY:${dailyActivity.length}");
      for (var dailyElement in dailyActivity) {
        studentDailyActivity.value = dailyElement.student;
        log("STUDENT DAILY ACTIVITY:${studentDailyActivity.length}");
        update();
      }
      hideLoading();
      update();
    } else {
      notFound.value = true;
      errorMessage.value;
      log("ERROR BOOL:${isError.value}");
      log("ERROR RESPONSE:${errorMessage.toString()}");
      update();
    }
    hideLoading();
    update();
  }

  void filterActivitySessionWithRoomId() async {
    showLoading();
    var param = {
      "dateFrom": fromDate.value,
      "dateTo": endDate.value,
      "schoolId": schoolId.value,
      "roleId": roleId.value,
      "roomId": roomId.value
    };
    log("PARAM FILTER:$param");
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.allActivity}?schoolId=${schoolId.value}&roleId=${roleId.value}&roomId=${roomId.value}&dateFrom=${fromDate.value}&dateTo=${endDate.value}')
        .catchError(handleError);
    if (response != null && response != "") {
      // log("RESPONSE ACTIVITY:${response.toString()}");
      dailyActivity.value = dailyActivityModelFromJson(response);
      log("DAILY ACTIVITY:${dailyActivity.length}");
      for (var dailyElement in dailyActivity) {
        studentDailyActivity.value = dailyElement.student;
        log("STUDENT DAILY ACTIVITY:${studentDailyActivity.length}");
        update();
      }
      hideLoading();
      update();
    } else {
      notFound.value = true;
      errorMessage.value;
      log("ERROR BOOL:${isError.value}");
      log("ERROR RESPONSE:${errorMessage.toString()}");
      update();
    }
    hideLoading();
    update();
  }

  void removeFromList(int index) {
    activityDetailList.removeAt(index);
    update();
  }

  Future<void> uploadActivityFile(String imagePath, String imageName) async {
    var response = await BaseClient()
        .postMultipart(ApiEndPoints.devBaseUrl,
            ApiEndPoints.uploadDailyActivityFile, imagePath, imageName)
        .catchError(handleError);
    if (response.statusCode == 200) {
      log("UPLOAD FILE ACTIVITY RESPONSE:${response.toString()}");
      var resp = await http.Response.fromStream(response);
      var data = json.encode(resp.body);
      attachedUrl.value = json.decode(data);
      log("ATTACHED URL:$attachedUrl");
    }
  }

  List<DailyActivityTypeModel> activityTypeList = [
    DailyActivityTypeModel(
      activityId: 12,
      title: AppString.lunch,
      imageType: AppAssets.lunchIcon,
      isSelected: false,
    ),
    DailyActivityTypeModel(
      activityId: 19,
      title: AppString.outdoor,
      imageType: AppAssets.playIcon,
      isSelected: false,
    ),
    DailyActivityTypeModel(
      activityId: 4,
      title: AppString.noon,
      imageType: AppAssets.noonSnack,
      isSelected: false,
    ),
    DailyActivityTypeModel(
      activityId: 3,
      title: AppString.nap,
      imageType: AppAssets.sleepIcon,
      isSelected: false,
    ),
    DailyActivityTypeModel(
      activityId: 2,
      title: AppString.evening,
      imageType: AppAssets.eveningSnack,
      isSelected: false,
    ),
  ];

  void refreshPage() {
    getAllActivity(schoolId.value, roleId.value);
  }

  void refreshPageBySmartRefresher() async {
    await Future.delayed(const Duration(milliseconds: 500));
    refreshController.refreshCompleted();
  }

  dateDifference(String startDateVal, String endDateVal) {
    DateTime startDateCheck = DateFormat("MM/dd/yyyy").parseUTC(startDateVal);
    DateTime endDateCheck = DateFormat("MM/dd/yyyy").parseUTC(endDateVal);
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

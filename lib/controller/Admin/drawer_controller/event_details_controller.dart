import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/model/all_event_model.dart';
import 'package:preto3/model/event_action_model.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/app_string.dart';
import 'package:preto3/utils/argument_keys.dart';

class EventDetailsController extends GetxController with BaseController {
  final storageBox = GetStorage();
  dynamic argumentData = Get.arguments;
  AllEventModel? allEventModel;
  var inviteeList = <String>[].obs;
  var schoolName = "".obs;
  var userId = 0.obs;
  var roleId = 0.obs;
  var schoolId = 0.obs;
  var selectedAction = 4.obs;
  var eventId = 0.obs;
  var responseStatus = 4.obs;
  var isPastEvent = false.obs;
  double x = 5.0;
  double y = 0.0;
  var noContentFound = false.obs;
  var eventList = <AllEventModel>[].obs;
  var studentList = <EventStudentMap>[].obs;
  var parentList = <EventStudentParentMap>[].obs;

  @override
  void onInit() {
    userId.value = storageBox.read(AppKeys.keyId);
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    allEventModel = argumentData[ArgumentKeys.argumentEventMap];
    schoolName.value = storageBox.read(AppKeys.keySchoolName);
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    var outputChatDate = DateFormat('MM/dd/yyyy').parse(DateFormat('MM/dd/yyyy')
        .format(DateTime.parse(allEventModel!.eventStartTime)));
    var currentChatDate = DateFormat('MM/dd/yyyy')
        .parse(DateFormat('MM/dd/yyyy').format(DateTime.now()));
    var outputChatEndDate = DateFormat('MM/dd/yyyy').parse(
        DateFormat('MM/dd/yyyy')
            .format(DateTime.parse(allEventModel!.eventEndTime)));
    if (dateDifference(outputChatDate, currentChatDate) &&
        dateDifference(outputChatEndDate, currentChatDate)) {
      isPastEvent.value = true;
    }
    for (var element
        in allEventModel!.eventStudentMaps.first.eventStudentParentMaps) {
      inviteeList.add(element.firstName);
      update();
    }
    for (var element in allEventModel!.eventStaffMaps) {
      inviteeList.add(element.profilePic.toString());
      update();
    }
    eventId.value = allEventModel!.eventId;
    log("INVITED LIST LENGTH:${inviteeList.length}");
    super.onInit();
  }

  dateDifference(DateTime startDateCheck, DateTime endDateCheck) {
    int diffInDays = endDateCheck.difference(startDateCheck).inDays;
    if (diffInDays == 0) {
      return true;
    } else if (diffInDays > 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void onReady() {
    getEventDetails(schoolId.value, roleId.value, eventId.value);
    super.onReady();
  }

  void setAction(int index) {
    var responseId = eventActionList[index].respondStatus;
    print(responseId);

    eventResponseSession(
        responseId, eventId.value, schoolId.value, roleId.value);
    update();
  }

  void setResponseStatus(int responseCode) {
    selectedAction.value = responseCode;
    update();
  }

  List<EventActionModel> eventActionList = [
    EventActionModel(
        name: AppString.accept,
        colors: AppColor.paidColor,
        bgColors: AppColor.acceptBg,
        respondStatus: 1),
    EventActionModel(
        name: AppString.decline,
        colors: AppColor.declinedColor,
        bgColors: AppColor.declineBg,
        respondStatus: 2),
    EventActionModel(
      name: AppString.maybe,
      colors: AppColor.invoiceNumberColor,
      bgColors: AppColor.maybeBg,
      respondStatus: 3,
    ),
  ];
  List<EventActionModel> eventActionListDisable = [
    EventActionModel(
        name: AppString.accept,
        colors: AppColor.disableTextColor,
        bgColors: AppColor.acceptBg,
        respondStatus: 1),
    EventActionModel(
        name: AppString.decline,
        colors: AppColor.disableTextColor,
        bgColors: AppColor.declineBg,
        respondStatus: 2),
    EventActionModel(
      name: AppString.maybe,
      colors: AppColor.disableTextColor,
      bgColors: AppColor.maybeBg,
      respondStatus: 3,
    ),
  ];

  void eventResponseSession(
      int responseId, int eventId, int schoolId, int roleId) async {
    var param = {
      "id": eventId,
      "respondStatus": responseId,
      "schoolId": schoolId,
      "roleId": roleId,
    };
    print("PARAM:${jsonEncode(param)}");
    var response = await BaseClient()
        .put(ApiEndPoints.devBaseUrl, ApiEndPoints.eventResponse, param)
        .catchError(handleError);
    if (response != null) {
      print("RESPONSE:$response");
      getEventDetails(schoolId, roleId, eventId);
    }
  }

  void getEventDetails(int schoolId, int roleId, int eventId) async {
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.allEvents}?roleId=$roleId&schoolId=$schoolId&id=$eventId')
        .catchError(handleError);
    if (response != null && response != "") {
      var eventResponse = allEventModelFromJson(response);
      if (eventResponse.isNotEmpty) {
        eventList.value = eventResponse;
        for (var element in eventList) {
          studentList.value = element.eventStudentMaps;
        }
        for (var parentElement in studentList) {
          parentList.value = parentElement.eventStudentParentMaps;
        }
        for (var parentElement in parentList) {
          if (parentElement.parentId == userId.value) {
            responseStatus.value = parentElement.respondStatus;
            responseStatus.value == 1
                ? setResponseStatus(0)
                : responseStatus.value == 2
                    ? setResponseStatus(1)
                    : responseStatus.value == 3
                        ? setResponseStatus(2)
                        : setResponseStatus(4);
            update();
          } else {
            log("RESPONSE STATUS:${parentElement.respondStatus}");
          }
        }
      }
      hideLoading();
      log("PARENT STATUS:${responseStatus.value}");
      log("ACTION STATUS:${selectedAction.value}");
      update();
    } else {
      noContentFound.value = true;
      hideLoading();
      update();
    }
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/model/all_event_model.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_dialog.dart';
import 'package:preto3/utils/app_keys.dart';

class EventController extends GetxController with BaseController {
  final storageBox = GetStorage();

  var currentDate = DateTime.now();
  var selectedDate = "".obs;
  var startEpoch = 0.obs;
  var endEpoch = 0.obs;

  var roleId = 0.obs;
  var schoolId = 0.obs;

  var eventList = <AllEventModel>[].obs;
  AllEventModel? dataJson;

  var filteredDate = false.obs;
  var noContentFound = false.obs;
  var isUpcoming = false.obs;
  var nowDate = "".obs;
  var selectedStartDate = "".obs;
  var selectedEndDate = "".obs;
  var filteredStartDate = "".obs;
  var filteredEndDate = "".obs;
  var fromDate = 0.obs;
  var toDate = 0.obs;
  var upcomingEvent = <AllEventModel>[].obs;
  var pastEvent = <AllEventModel>[].obs;
  var ongoingEvent = <AllEventModel>[].obs;
   RxBool isAllDayEventChecked = false.obs;
  RxBool isAnnouncementChecked = false.obs;
  @override
  void onInit() {
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    selectedDate.value = DateFormat("MM/dd/yyyy").format(currentDate);
    DateTime tempStartDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    fromDate.value = tempStartDate.millisecondsSinceEpoch;
    DateTime tempEndDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day, 23, 59);
    toDate.value = tempEndDate.millisecondsSinceEpoch;
    log("EVENT ROLE ID:${roleId.value}");
    super.onInit();
  }

  @override
  void onReady() {
    getEventDetailsNextDate(
      schoolId.value,
      roleId.value,
      false,
      fromDate.value,
      toDate.value,
    );
    //getEventDetails(schoolId.value, roleId.value, true);
    super.onReady();
  }


void allDayEventCheckbox(bool? value) {
    if (value != null && value != isAllDayEventChecked.value) {
      isAllDayEventChecked.value = value;
      if (value) {
        isAnnouncementChecked.value = false; // Uncheck the other option
      }
    }
  }

  void announcementCheckbox(bool? value) {
    if (value != null && value != isAnnouncementChecked.value) {
      isAnnouncementChecked.value = value;
      if (value) {
        isAllDayEventChecked.value = false; // Uncheck the other option
      }
    }
  }

  void nextDate() {
    currentDate = currentDate.toUtc().add(const Duration(days: 1));
    selectedDate.value = DateFormat("MM/dd/yyyy").format(currentDate);
    print("NEXT DATE:${selectedDate.value}");
    print(
        "NEXT DATE MILLISECOND:${currentDate.toUtc().millisecondsSinceEpoch}");
    DateTime tempStartDate = DateTime(
        currentDate.year, currentDate.month, currentDate.day, 00, 00, 00);
    fromDate.value = tempStartDate.toUtc().millisecondsSinceEpoch;
    print("FROM DATE:${fromDate.value}");
    DateTime tempEndDate = DateTime(
        currentDate.year, currentDate.month, currentDate.day, 23, 59, 59);
    toDate.value = tempEndDate.toUtc().millisecondsSinceEpoch;
    getEventDetailsNextDate(
      schoolId.value,
      roleId.value,
      true,
      fromDate.value,
      toDate.value,
    );
  }

  void previousDate() {
    currentDate = currentDate.toUtc().subtract(const Duration(days: 1));
    selectedDate.value = DateFormat("MM/dd/yyyy").format(currentDate);
    print("PREVIOUS DATE:${selectedDate.value}");
    print("PREVIOUS DATE MILLISECOND:${currentDate.millisecondsSinceEpoch}");
    DateTime tempStartDate = DateTime(
        currentDate.year, currentDate.month, currentDate.day, 00, 00, 00);
    fromDate.value = tempStartDate.toUtc().millisecondsSinceEpoch;
    DateTime tempEndDate = DateTime(
        currentDate.year, currentDate.month, currentDate.day, 23, 59, 59);
    toDate.value = tempEndDate.toUtc().millisecondsSinceEpoch;
    isUpcoming.value = false;
    getEventDetailsPreviousDate(
        schoolId.value, roleId.value, false, fromDate.value, toDate.value);
  }

  // void getEventDetails(int schoolId, int roleId, bool upcoming) async {
  //   showLoading('');
  //   var response = await BaseClient()
  //       .get(ApiEndPoints.devBaseUrl,
  //           '${ApiEndPoints.allEvents}?roleId=$roleId&schoolId=$schoolId&isUpcomingOnly=$upcoming')
  //       .catchError(handleError);
  //   if (response != null && response != "") {
  //     var eventResponse = allEventModelFromJson(response);
  //     if (eventResponse.isNotEmpty) {
  //       for (var element in eventResponse) {
  //         dataJson = AllEventModel(
  //             firstName: element.firstName,
  //             announcement: element.announcement,
  //             description: element.description,
  //             eventId: element.eventId,
  //             eventLink: element.eventLink,
  //             eventStaffMaps: element.eventStaffMaps,
  //             eventStartTime: element.eventStartTime,
  //             eventStudentMaps: element.eventStudentMaps,
  //             eventVenueAddress: element.eventVenueAddress,
  //             fullDay: element.fullDay,
  //             isUpcoming: upcoming,
  //             lastName: element.lastName,
  //             mapStatus: element.mapStatus,
  //             recurringEvent: element.recurringEvent,
  //             eventEndTime: element.eventEndTime,
  //             eventTitle: element.eventTitle);
  //         eventList.add(dataJson!);
  //       }
  //     }
  //     hideLoading();
  //     noContentFound.value = false;
  //     update();
  //   } else {
  //     noContentFound.value = true;
  //     hideLoading();
  //     update();
  //   }
  // }

  void getEventDetailsNextDate(int schoolId, int roleId, bool isUpcoming,
      int startDate, int endDate) async {
    showLoading('');
    eventList.clear();
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.allEvents}?roleId=$roleId&schoolId=$schoolId&startDate=$startDate&endDate=$endDate')
        .catchError(handleError);
    if (response != null && response != "") {
      var eventResponse = allEventModelFromJson(response);
      pastEvent.value = [];
      upcomingEvent.value = [];
      ongoingEvent.value = [];
      print("FILTER NEXT DATE:${eventResponse.length}");
      if (eventResponse.isNotEmpty) {
        for (AllEventModel element in eventResponse) {
          var outputChatDate = DateFormat('MM/dd/yyyy').parse(
              DateFormat('MM/dd/yyyy')
                  .format(DateTime.parse(element.eventStartTime)));
          var currentChatDate = DateFormat('MM/dd/yyyy')
              .parse(DateFormat('MM/dd/yyyy').format(DateTime.now()));
          var outputChatEndDate = DateFormat('MM/dd/yyyy').parse(
              DateFormat('MM/dd/yyyy')
                  .format(DateTime.parse(element.eventEndTime)));
          String flag = dateDifference(outputChatDate, currentChatDate) &&
                  dateDifference(outputChatEndDate, currentChatDate)
              ? "Past Events"
              : dateDifference(currentChatDate, outputChatDate) ||
                      dateDifference(outputChatEndDate, currentChatDate)
                  ? "Upcoming Events"
                  : "Ongoing Events";
          if (flag == "Past Events") {
            pastEvent.add(element);
          } else if (flag == "Upcoming Events") {
            upcomingEvent.add(element);
          } else {
            ongoingEvent.add(element);
          }
        }
        eventList.value = eventResponse;
      }
      noContentFound.value = false;
      filteredDate.value = false;
      hideLoading();
      update();
    } else {
      noContentFound.value = true;
      filteredDate.value = false;
      hideLoading();
      update();
    }
  }

  void getEventDetailsPreviousDate(int schoolId, int roleId, bool isUpcoming,
      int startDate, int endDate) async {
    showLoading('');
    eventList.clear();
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.allEvents}?roleId=$roleId&schoolId=$schoolId&startDate=$startDate&endDate=$endDate')
        .catchError(handleError);
    if (response != null && response != "") {
      var eventResponse = allEventModelFromJson(response);
      print("FILTER PREVIOUS DATE:${eventResponse.length}");
      pastEvent.value = [];
      upcomingEvent.value = [];
      ongoingEvent.value = [];

      if (eventResponse.isNotEmpty) {
        for (AllEventModel element in eventResponse) {
          var outputChatDate = DateFormat('MM/dd/yyyy').parse(
              DateFormat('MM/dd/yyyy')
                  .format(DateTime.parse(element.eventStartTime)));
          var currentChatDate = DateFormat('MM/dd/yyyy')
              .parse(DateFormat('MM/dd/yyyy').format(DateTime.now()));
          var outputChatEndDate = DateFormat('MM/dd/yyyy').parse(
              DateFormat('MM/dd/yyyy')
                  .format(DateTime.parse(element.eventEndTime)));
          String flag = dateDifference(outputChatDate, currentChatDate) &&
                  dateDifference(outputChatEndDate, currentChatDate)
              ? "Past Events"
              : dateDifference(currentChatDate, outputChatDate) ||
                      dateDifference(outputChatEndDate, currentChatDate)
                  ? "Upcoming Events"
                  : "Ongoing Events";
          if (flag == "Past Events") {
            pastEvent.value.add(element);
          } else if (flag == "Upcoming Events") {
            upcomingEvent.value.add(element);
          } else {
            ongoingEvent.value.add(element);
          }
        }
        eventList.value = eventResponse;
      }
      hideLoading();
      noContentFound.value = false;
      filteredDate.value = false;
      update();
    } else {
      noContentFound.value = true;
      filteredDate.value = false;
      print("FILTER RESPONSE NULL:${response}");
      hideLoading();
      update();
    }
  }

  void getEventDetailsFilterWithDate(int schoolId, int roleId, bool isUpcoming,
      int startDate, int endDate) async {
    showLoading('');
    eventList.clear();
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.allEvents}?roleId=$roleId&schoolId=$schoolId&startDate=$startDate&endDate=$endDate')
        .catchError(handleError);
    if (response != null && response != "") {
      pastEvent.value = [];
      upcomingEvent.value = [];
      ongoingEvent.value = [];

      var eventResponse = allEventModelFromJson(response);
      if (eventResponse.isNotEmpty) {
        for (AllEventModel element in eventResponse) {
          var outputChatDate = DateFormat('MM/dd/yyyy').parse(
              DateFormat('MM/dd/yyyy')
                  .format(DateTime.parse(element.eventStartTime)));
          var currentChatDate = DateFormat('MM/dd/yyyy')
              .parse(DateFormat('MM/dd/yyyy').format(DateTime.now()));
          var outputChatEndDate = DateFormat('MM/dd/yyyy').parse(
              DateFormat('MM/dd/yyyy')
                  .format(DateTime.parse(element.eventEndTime)));
          String flag = dateDifference(outputChatDate, currentChatDate) &&
                  dateDifference(outputChatEndDate, currentChatDate)
              ? "Past Events"
              : dateDifference(currentChatDate, outputChatDate) ||
                      dateDifference(outputChatEndDate, currentChatDate)
                  ? "Upcoming Events"
                  : "Ongoing Events";
          if (flag == "Past Events") {
            pastEvent.value.add(element);
          } else if (flag == "Upcoming Events") {
            upcomingEvent.value.add(element);
          } else {
            ongoingEvent.value.add(element);
          }
        }
        eventList.value = eventResponse;
      }
      filteredStartDate.value = "";
      filteredEndDate.value = "";
      hideLoading();
      noContentFound.value = false;
      update();
    } else {
      noContentFound.value = true;
      hideLoading();
      update();
    }
  }

  void pickStartDate(BuildContext context) async {
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (pickedDate != null && pickedDate != currentDate) {
      currentDate = pickedDate;
    }
    DateTime tempStartDate = DateTime(currentDate.toUtc().year,
        currentDate.toUtc().month, currentDate.toUtc().day, 00, 00, 00);
    startEpoch.value = tempStartDate.millisecondsSinceEpoch;
    print("FILTER START UTC TIME :${startEpoch.value}");
    nowDate.value = DateFormat('MM/dd/yyyy').format(currentDate).toString();
    filteredStartDate.value = DateFormat('MM/dd/yyyy').format(currentDate);
    update();
  }

  void pickEndDate(BuildContext context) async {
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (pickedDate != null && pickedDate != currentDate) {
      currentDate = pickedDate;
    }
    DateTime tempEndDate = DateTime(currentDate.toUtc().year,
        currentDate.toUtc().month, currentDate.toUtc().day, 23, 59, 59);
    endEpoch.value = tempEndDate.toUtc().millisecondsSinceEpoch;
    print("FILTER END UTC TIME :${endEpoch.value}");
    nowDate.value = DateFormat('MM/dd/yyyy').format(currentDate).toString();

    filteredEndDate.value = DateFormat('MM/dd/yyyy').format(currentDate);

    update();
  }

  void filterEvent(int startEpoch, int endEpoch) {
    if (filteredStartDate.value.isNotEmpty ||
        filteredEndDate.value.isNotEmpty) {
      selectedStartDate.value = filteredStartDate.value;
      selectedEndDate.value = filteredEndDate.value;
      if (currentDate.toUtc().millisecondsSinceEpoch < startEpoch) {
        isUpcoming.value = true;
        update();
      } else {
        isUpcoming.value = false;
        update();
      }
      if (startEpoch > endEpoch) {
        filteredDate.value = false;
        AppDialog.snackBarWarningDialog(
            message: 'start date cannot be less than end date');
      } else {
        getEventDetailsFilterWithDate(schoolId.value, roleId.value,
            isUpcoming.value, startEpoch, endEpoch);
      }
    }
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
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:preto3/model/admit/events/event_types_model.dart';
import 'package:preto3/utils/app_keys.dart';

class AdminEventController extends GetxController{

  final storageBox = GetStorage();

  //FORM KEY
  final eventTitle = GlobalKey<FormState>();
  final eventVenue = GlobalKey<FormState>();
  final eventDesc = GlobalKey<FormState>();

  //TEXT EDITING CONTROLLER
  var eventTitleController = TextEditingController();
  var eventVenueController = TextEditingController();
  var eventDescController = TextEditingController();

  var currentDate = DateTime.now();
  var selectedDate = "".obs;
  var startEpoch = 0.obs;
  var endEpoch = 0.obs;

  var roleId = 0.obs;
  var schoolId = 0.obs;

  var nowDate = "".obs;
  var selectedAddStartDate = "".obs;
  var selectedEndDate = "".obs;
  var selectedStartTime = "".obs;
  var selectedEndTime = "".obs;
  var checkEventType=false.obs;

  var eventTypeList=<EventTypeModel>[].obs;
  EventTypeModel? eventTypeModel;
  var currentStartTime = const TimeOfDay(hour: 8, minute: 30);
  var currentEndTime = const TimeOfDay(hour: 5, minute: 30);
  @override
  void onInit() {
    // TODO: implement onInit
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    selectedDate.value = DateFormat("MM/dd/yyyy").format(currentDate);
    eventTypeList.value=[
      EventTypeModel(eventTypeIsChecked: false,eventTypeName: "All Day Event"),
      EventTypeModel(eventTypeIsChecked: false,eventTypeName: "Announcement")
    ];
    eventTypeModel=eventTypeList.first;

    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  //VALIDATION

  String? eventTitleValidator(String value) {
    if (value.isNotEmpty) {
      return null;
    }
    return 'This field cannot be empty';
  }

  String? eventVenueValidator(String value) {
    if (value.isNotEmpty) {
      return null;
    }
    return 'This field cannot be empty';
  }

  String? eventDescValidator(String value) {
    if (value.isNotEmpty) {
      return null;
    }
    return 'This field cannot be empty';
  }

  // EVENT TYPE
  void setEventTypeCheck(int typeIndex){
    eventTypeList[typeIndex].eventTypeIsChecked=!eventTypeList[typeIndex].eventTypeIsChecked;
    log("CHECKED NAME:${eventTypeList[typeIndex].eventTypeName}");
    log("CHECKED TYPE:${eventTypeList[typeIndex].eventTypeIsChecked}");
    update();
  }

  //PICK DATE
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
  void addEndDate(BuildContext context) async {
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 7)));
    if (pickedDate != null && pickedDate != currentDate) {
      currentDate = pickedDate;
    }

    nowDate.value = DateFormat('MM/dd/yyyy').format(currentDate).toString();

    selectedEndDate.value = DateFormat('MM/dd/yyyy').format(currentDate);
    log("START DATE SELECTED :${selectedEndDate.value}");
    // getAllStudent(nowDate.value, schoolId.value);
    update();
  }

  //PICK TIME
  void pickStartTime(BuildContext context,) async {
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
    log("CURRENT TIME SELECTED :${selectedStartTime.value}");
    update();
  }

  void pickEndTime(BuildContext context) async {
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

    log("CURRENT TIME SELECTED :${selectedEndTime.value}");

    update();
  }
}
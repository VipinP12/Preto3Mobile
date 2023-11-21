import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/model/race_model.dart';
import 'package:preto3/model/room_list_model.dart';
import 'package:preto3/model/school_programme_model.dart';
import 'package:preto3/model/student_profile_model.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/app_string.dart';

import '../model/enrollment_model.dart';
import '../model/gender_model.dart';

class ProfileStudentController extends GetxController with BaseController {
  final storageBox = GetStorage();

  final addAllergiesKey = GlobalKey<FormState>();
  final addMedicationKey = GlobalKey<FormState>();

  var allergiesController = TextEditingController();
  var medicationController = TextEditingController();

  var allergies = "".obs;
  var medication = "".obs;

  var isAllergiesFocused = false.obs;
  var isMedicationFocused = false.obs;

  var isAllergiesValid = false;
  var isMedicationValid = false;
  FocusNode allergiesFocusNode = FocusNode();
  FocusNode medicationFocusNode = FocusNode();

  var roleId = 0.obs;
  var schoolId = 0.obs;
  var studentId = 1006488.obs;
  var genderIndex = 0.obs;
  var enrollmentIndex = 0.obs;
  final raceList = <RaceList?>[].obs;
  final ethnicityList = <EthnicityList?>[].obs;
  final schoolProgrammeList = <SchoolProgrammeModelDart?>[].obs;
  final allRoomList = <RoomListModel?>[].obs;
  final allergiesList = <String?>[].obs;
  final medicationList = <String?>[].obs;

  RaceList? raceType;
  SchoolProgrammeModelDart? programmeType;
  EthnicityList? ethnicType;
  RoomListModel? roomType;
  var raceId = 0.obs;
  var selectedRace = "".obs;
  var ethnicityId = 0.obs;
  var selectedEthnicity = "".obs;
  var roomId = 0.obs;
  var selectedRoom = "".obs;

  var programmeId = 0.obs;
  var selectedProgramme = "".obs;

  @override
  void onInit() {
    super.onInit();
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    schoolId.value = storageBox.read(AppKeys.keySchoolId);

    allergiesController = TextEditingController();
    medicationController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
    getStudentProfile(studentId.value, roleId.value);
    getSchoolProgrammer(schoolId.value);
    getAllRoomList(roleId.value, schoolId.value);
    getRace();
  }

  @override
  void dispose() {
    super.dispose();
    allergiesController.dispose();
    medicationController.dispose();
  }

  String? allergyValidator(String value) {
    if (value.isNotEmpty) {
      return null;
    }
    return 'Please add an allergies';
  }

  String? medicationValidator(String value) {
    if (value.isNotEmpty) {
      return null;
    }
    return 'Please add a medication';
  }

  focusAllergies(bool value) {
    isAllergiesFocused.value = value;
    update();
  }

  focusMedication(bool value) {
    isMedicationFocused.value = value;
    update();
  }

  void getStudentProfile(int studentId, int roleId) async {
    showLoading();
    try {
      var response = await BaseClient()
          .get(
              ApiEndPoints.devBaseUrl,
              '${ApiEndPoints.studentProfileDetails}'
              '?id=$studentId&roleId=$roleId')
          .catchError(handleError);

      var profileResponse = studentProfileModelDartFromJson(response);
      log("PROFILE RESP:${profileResponse.studentPersonalDetails.firstName}");
      log("PROFILE RESP:${profileResponse.studentEnrollmentDetails.programName}");
      log("PROFILE RESP:${profileResponse.parents.length}");
    } catch (e) {
      log(e.toString());
    }
    hideLoading();

    update();
  }

  List<GenderModel> genderList = [
    GenderModel(name: AppString.boy),
    GenderModel(name: AppString.girl),
    GenderModel(name: AppString.other),
  ];

  List<EnrollmentModel> enrollmentList = [
    EnrollmentModel(name: AppString.fullTime),
    EnrollmentModel(name: AppString.partTime),
  ];

  void changeGender(int index) {
    genderIndex.value = index;
    update();
  }

  void changeEnrollment(int index) {
    enrollmentIndex.value = index;
    update();
  }

  void getRace() async {
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl, ApiEndPoints.getUserRace)
        .catchError(handleError);

    var data = RaceModelDart.fromJson(jsonDecode(response));
    raceList.value = data.raceList!;
    raceType = raceList.first;
    ethnicityList.value = data.ethnicityList!;
    update();
  }

  void setRace(RaceList race) {
    raceType = race;
    raceId.value = race.raceId!;
    selectedRace.value = race.raceDescription.toString();
    update();
  }

  void setEthnic(EthnicityList ethnicity) {
    ethnicType = ethnicity;
    ethnicityId.value = ethnicity.ethnicityId!;
    selectedEthnicity.value = ethnicity.ethnicityIdDescription.toString();
    update();
  }

  void setProgramme(SchoolProgrammeModelDart programme) {
    programmeType = programme;
    programmeId.value = programme.programId!;
    selectedProgramme.value = programme.programName.toString();
    update();
  }

  void setClassRoom(RoomListModel room) {
    roomType = room;
    roomId.value = room.classId!;
    selectedRoom.value = room.className.toString();
    update();
  }

  void allergySession() {
    isAllergiesValid = addAllergiesKey.currentState!.validate();
    Get.focusScope!.unfocus();
    if (isAllergiesValid) {
      addAllergiesKey.currentState!.save();
      allergiesController.clear();
      addAllergies(allergies.value);
    }
  }

  void medicationSession() {
    isMedicationValid = addMedicationKey.currentState!.validate();
    Get.focusScope!.unfocus();
    if (isMedicationValid) {
      addMedicationKey.currentState!.save();
      medicationController.clear();
      addMedications(medication.value);
    }
  }

  void addAllergies(String name) {
    allergiesList.add(name);
    update();
  }

  void removeAllergies(String name) {
    allergiesList.remove(name);
    update();
  }

  void addMedications(String name) {
    medicationList.add(name);
    update();
  }

  void removeMedication(String name) {
    medicationList.remove(name);
    update();
  }

  void getSchoolProgrammer(int schoolId) async {
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.getSchoolProgramme}' '?schoolId=$schoolId')
        .catchError(handleError);
    schoolProgrammeList.value = schoolProgrammeModelDartFromJson(response)!;
    update();
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
}

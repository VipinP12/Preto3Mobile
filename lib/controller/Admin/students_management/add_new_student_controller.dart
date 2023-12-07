import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../../model/race_model.dart';
import '../../../model/room_list_model.dart';
import '../../../model/school_programme_model.dart';
import '../../../network/api_end_points.dart';
import '../../../network/base_client.dart';
import '../../../utils/app_keys.dart';
import '../../../utils/app_string.dart';
import '../../base_controller.dart';


class ProfileAddStudentController extends GetxController with BaseController{
  final storageBox = GetStorage();
  final addAllergiesKey = GlobalKey<FormState>();
  final addStudentsKey = GlobalKey<FormState>();
  // final addMedicationKey = GlobalKey<FormState>();
  final addPrimaryParentKey = GlobalKey<FormState>();
  final addSecondaryParentKey = GlobalKey<FormState>();
  var genderIndex = 0.obs;
  var enrollmentIndex = 0.obs;
  var raceId = 0.obs;
  var selectedRace = "".obs;
  var selectedImagePath = ''.obs;
  var selectedFileName = ''.obs;

  RaceList? raceType;
  EthnicityList? ethnicType;
  var ethnicityId = 0.obs;
  var selectedEthnicity = "".obs;
  var isAllergiesValid = false;
  var isMedicationValid = false;
  var allergies = "".obs;
  var medication = "".obs;
  var programmeId = 0.obs;
  var selectedProgramme = "".obs;
  SchoolProgrammeModelDart? programmeType;
  var roomId = 0.obs;
  var userId = 0.obs;
  var selectedRoom = "".obs;
  RoomListModel? roomType;
  var firstNameController = TextEditingController();
  var allergiesController = TextEditingController();
  var medicationController = TextEditingController();
  String selectedValue = 'Hindi';
  String selectedRole = 'Teacher';
  String selectedAssignName = 'Assign New Room';
  bool isSwitched = false;
  var roleId = 0.obs;
  var schoolId = 0.obs;

  final raceList = <RaceList?>[].obs;
  final ethnicityList = <EthnicityList?>[].obs;
  final allRoomList = <RoomListModel?>[].obs;
  final schoolProgrammeList = <SchoolProgrammeModelDart?>[].obs;

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
    // getStudentProfile(studentId.value, roleId.value);
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

  List<GenderModel> genderList = [
    GenderModel(name: AppString.boy),
    GenderModel(name: AppString.girl),
    GenderModel(name: AppString.other),
  ];

  List<EnrollmentModel> enrollmentList = [
    EnrollmentModel(name: AppString.fullTime),
    EnrollmentModel(name: AppString.partTime),
  ];
  final allergiesList = <String?>[].obs;
  final medicationList = <String?>[].obs;



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

  void allergySession() {
    isAllergiesValid = addStudentsKey.currentState!.validate();
    Get.focusScope!.unfocus();
    if (isAllergiesValid) {
      addStudentsKey.currentState!.save();
      allergiesController.clear();
      addAllergies(allergies.value);
    }
  }
  void medicationSession() {
    isMedicationValid = addStudentsKey.currentState!.validate();
    Get.focusScope!.unfocus();
    if (isMedicationValid) {
      addStudentsKey.currentState!.save();
      medicationController.clear();
      addMedications(medication.value);
    }
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

  void changeGender(int index) {
    genderIndex.value = index;
    update();
  }

  void changeEnrollment(int index) {
    enrollmentIndex.value = index;
    update();
  }
  void addAllergies(String name) {
    allergiesList.add(name);
    update();
  }

  void removeAllergies(String name) {
    allergiesList.remove(name);
    update();
  }
  void removeMedication(String name) {
    medicationList.remove(name);
    update();
  }
  void addMedications(String name) {
    medicationList.add(name);
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
  void getSchoolProgrammer(int schoolId) async {
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
        '${ApiEndPoints.getSchoolProgramme}' '?schoolId=$schoolId')
        .catchError(handleError);
    schoolProgrammeList.value = schoolProgrammeModelDartFromJson(response)!;
    update();
  }
  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedFileName.value =
          firstNameController.text + userId.value.toString();
      print("FILE NAME ${selectedFileName}");
    } else {
      Get.snackbar("Error", "No Image Selected",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

}




class GenderModel{
  final String name;

  GenderModel({required this.name});
}

class EnrollmentModel{
  final String name;

  EnrollmentModel({required this.name});
}
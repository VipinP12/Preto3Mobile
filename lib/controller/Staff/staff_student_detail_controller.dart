import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:preto3/model/student_profile_model.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/argument_keys.dart';

import '../base_controller.dart';

class StaffStudentDetailsController extends GetxController with BaseController {
  final storageBox = GetStorage();
  dynamic argumentData = Get.arguments;
  StudentProfileModelDart? studentProfile;

  var studentId = 0.obs;
  var roleId = 0.obs;
  var checkInOutPin = "".obs;
  var firstName = "".obs;
  var lastName = "".obs;
  var profilePic = "".obs;
  //
  var stufirstName = "".obs;
  var stuLastName = "".obs;
  var stuGender = "".obs;
  var stuBirthDay = "".obs;
  var stuRace = "".obs;
  var stuEthnicity = "".obs;
  var stuDoctorName = "".obs;
  var stuDoctorPhoneNum = "".obs;
  var stuAllergies = "".obs;
  var stuMedications = "".obs;

  @override
  void onInit() {
    studentId.value = argumentData[ArgumentKeys.argumentStudentId];
    checkInOutPin.value = argumentData[ArgumentKeys.argumentCheckIn].toString();
    roleId.value = storageBox.read(AppKeys.keyRoleId);

    firstName.value =
        argumentData[ArgumentKeys.argumentChildFirstName].toString();
    lastName.value =
        argumentData[ArgumentKeys.argumentChildLastName].toString();
    profilePic.value =
        argumentData[ArgumentKeys.argumentChildProfilePic].toString();
    print("STUDENT ID:${studentId.value}");
    // studentProfile;
    super.onInit();
  }

  @override
  void onReady() {
    getStudentProfile(studentId.value, roleId.value);
    super.onReady();
  }

  void getStudentProfile(int studentId, int roleId) async {
    showLoading();
    var response = await BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.studentProfileDetails}'
            '?id=$studentId&roleId=$roleId')
        .catchError(handleError);

    if (response != null && response != "") {
      studentProfile = studentProfileModelDartFromJson(response);
      stufirstName.value =
          studentProfile!.studentPersonalDetails.firstName.toString();
      stuLastName.value =
          studentProfile!.studentPersonalDetails.lastName.toString();
      stuGender.value =
          studentProfile!.studentPersonalDetails.gender.toString();
      stuBirthDay.value =
          studentProfile!.studentPersonalDetails.birthDay.toString();
      stuRace.value = studentProfile!.studentPersonalDetails.race.toString();
      stuEthnicity.value =
          studentProfile!.studentPersonalDetails.ethnicity.toString();
      stuDoctorName.value =
          studentProfile!.studentPersonalDetails.doctorName.toString();
      stuDoctorPhoneNum.value =
          studentProfile!.studentPersonalDetails.doctorPhone.toString();
      stuAllergies.value =
          studentProfile!.studentPersonalDetails.allergies.toString();
      stuMedications.value = studentProfile!.studentPersonalDetails.medications;
      print(stufirstName.value);
      firstName.value =
          studentProfile!.studentPersonalDetails.firstName.toString();
    }

    hideLoading();
    update();
  }
}

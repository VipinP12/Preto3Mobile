import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_keys.dart';
import '../../../model/parent/parent_students_model.dart';
import '../parent_dashboard_controller.dart';

class AuthorizePikupCreateController extends GetxController
    with BaseController {
  final storageBox = GetStorage();
  dynamic argumentData = Get.arguments;

  var currentDate = DateTime.now();

  final firstNamePickupPersionKey = GlobalKey<FormState>();
  final lastNamePickupPersionKey = GlobalKey<FormState>();
  final pickupPersionEmailKey = GlobalKey<FormState>();
  final pickupPersionPhoneKey = GlobalKey<FormState>();
  final pickupAddressKey = GlobalKey<FormState>();

  var isFirstName = false;
  var isLastName = false;
  var isPickupPersionEmail = false;
  var isPickupPersionPhone = false;
  var pickupAddress = false;
  var startDateValidation = false.obs;
  var endDateValidation = false.obs;
  final parentDashBoardController = Get.find<ParentDashboardController>();

  var firstNamePickupPersionController = TextEditingController();
  var lastNamePickupPersionController = TextEditingController();
  var pickupPersionEmailController = TextEditingController();
  var pickupPersionPhoneController = TextEditingController();
  var pickupAddressController = TextEditingController();

  var firstName = "".obs;
  var lastName = "".obs;
  var pickupPersionEmail = "".obs;
  var pickupPersionPhone = "".obs;
  var pickupPersionAddress = "".obs;

  var authorizePeriod = true.obs;
  var startDate = "".obs;
  var endDate = "".obs;
  var selectDate = "".obs;
  var pickupTime = "".obs;
  var allChildern = <ParentStudents>[].obs;
  var dropDownInitialValue = "Select child".obs;
  ParentStudents? allChildValue;
  var selectPickDate = [].obs;

  var authorizeLisst = <ParentStudents>[].obs;
  var schoolId = 0.obs;
  var userId = 0.obs;
  var roleId = 0.obs;
  File? imageFile;
  var pickupFlag = false.obs;
  var pickupError = "".obs;

  @override
  void onInit() {
    super.onInit();
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    userId.value = storageBox.read(AppKeys.keyId);
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    pickupAddressController.text =
        parentDashBoardController.schoolAddress.value;
  }

  @override
  void onReady() {
    String url = '?schoolId=${schoolId.value}';
    getParentChildern(url);
  }

  void getParentChildern(String url) async {
    showLoading();
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl, '${ApiEndPoints.getParentMyChildern}$url')
        .catchError(handleError);
    allChildern.value = parentStudentsFromJson(response);
    hideLoading();
    update();
  }

  String? firstNamePickupPersionValidator(String value) {
    if (value.trim().isNotEmpty) {
      return null;
    } else if (value.trim().isEmpty) {
      'Pickup person first name can not be empty.';
    }
    return 'Please enter a valid pickup person first name.';
  }

  String? lastNamePickupPersionValidator(String value) {
    if (value.trim().isNotEmpty) {
      return null;
    } else if (value.trim().isEmpty) {
      return 'Pickup person last name can not be empty.';
    }
    return 'Please enter a valid pickup person last name.';
  }

  String? pickupPersionEmailValidator(String value) {
    if (value.trim().isNotEmpty &&
        RegExp(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
      return null;
    }
    return 'Please enter a valid email address.';
  }

  String? pickupPersionPhoneValidator(String value) {
    RegExp regExp = RegExp(r'^[2-9]\d{9}$');
    if (value.trim().isEmpty) {
      return 'Phone number can not be empty.';
    } else if (!regExp.hasMatch(value)) {
      return 'phone number must be valid.';
    }
    return null;
  }

  String? pickupAddressValidator(String value) {
    if (value.trim().isNotEmpty) {
      return null;
    }
    return 'Address can not be empty.';
  }

  void setAuthorizePeriod() {
    authorizePeriod.value = !authorizePeriod.value;
    update();
  }

  pickDate(BuildContext context) async {
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      return DateFormat("MM/dd/yyyy").format(pickedDate);
    } else {
      return "";
    }
  }

  dateDifference() {
    if (startDate.isEmpty) {
      startDateValidation.value = true;
      return false;
    }
    if (endDate.isEmpty) {
      endDateValidation.value = true;
      return false;
    }
    DateTime startDateCheck = DateFormat("MM/dd/yyyy").parse(startDate.value);
    DateTime endDateCheck = DateFormat("MM/dd/yyyy").parse(endDate.value);
    int diffInDays = endDateCheck.difference(startDateCheck).inDays;
    if (diffInDays == 0) {
      return true;
    } else if (diffInDays > 0) {
      return true;
    } else {
      return false;
    }
  }

  pickTime(BuildContext context) async {
    final TimeOfDay currentTime = TimeOfDay.now();
    var pickedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
      builder: (BuildContext context, Widget? child) {
        final now = DateTime.now();
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: IgnorePointer(
            ignoring: currentTime.hour > now.hour ||
                (currentTime.hour == now.hour &&
                    currentTime.minute > now.minute),
            child: child,
          ),
        );
      },
    );

    if (pickedTime != null) {
      String time = "";
      if (pickedTime.hour.toString().length < 2) {
        time += "0${pickedTime.hour}:";
      } else {
        time += "${pickedTime.hour}:";
      }
      if (pickedTime.minute.toString().length < 2) {
        time += "0${pickedTime.minute}";
      } else {
        time += "${pickedTime.minute}";
      }
      return time;
    } else {
      return "";
    }
  }

  void setPickStartDate(var start) {
    startDate.value = start.toString();
    if (startDate.value.isNotEmpty) {
      startDateValidation.value = false;
    } else {
      startDateValidation.value = true;
    }
    if (pickupTime.value.isNotEmpty) {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('MM/dd/yyyy').format(now);

      if (formattedDate == startDate.value) {
        DateTime nowUtc = DateTime.now();
        DateTime twoMinutesAgoUtc = nowUtc.subtract(const Duration(minutes: 2));
        String formattedTime = DateFormat('HH:mm').format(twoMinutesAgoUtc);
        if (int.parse(pickupTime.value.replaceAll(":", "")) <
            int.parse(formattedTime.replaceAll(":", ""))) {
          pickupFlag.value = false;
          pickupError.value = "This time is not valid for today.";
          update();
        }
      } else {
        if (int.parse(pickupTime.value.substring(0, 2)) < 06) {
          pickupFlag.value = false;
          pickupError.value = "Time can't be less then 06:00 AM";
        } else if (int.parse(pickupTime.value.replaceAll(":", "")) > 2100) {
          pickupFlag.value = false;
          pickupError.value = "Time can't be gretter then 09:00 PM";
        } else {
          pickupFlag.value = true;
        }
      }
    }
  }

  void setPickEndDate(var end) {
    endDate.value = end.toString();
    if (endDate.value.isNotEmpty) {
      endDateValidation.value = false;
    } else {
      endDateValidation.value = true;
    }
  }

  void setPickTimeSet(var time) {
    pickupTime.value = time.toString();
    if (pickupTime.value.trim().isNotEmpty && authorizePeriod.value) {
      if (int.parse(pickupTime.value.substring(0, 2)) < 06) {
        pickupFlag.value = false;
        pickupError.value = "Time can't be less then 06:00 AM";
      } else if (int.parse(pickupTime.value.replaceAll(":", "")) > 2100) {
        pickupFlag.value = false;
        pickupError.value = "Time can't be gretter then 09:00 PM";
      } else {
        pickupFlag.value = true;
      }

      if (startDate.value.isNotEmpty) {
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('MM/dd/yyyy').format(now);
        if (formattedDate == startDate.value) {
          DateTime nowUtc = DateTime.now();
          DateTime twoMinutesAgoUtc =
              nowUtc.subtract(const Duration(minutes: 2));
          String formattedTime = DateFormat('HH:mm').format(twoMinutesAgoUtc);
          if (int.parse(time.replaceAll(":", "")) <
              int.parse(formattedTime.replaceAll(":", ""))) {
            pickupFlag.value = false;
            pickupError.value = "This time is not valid for today.";
          }
        }
      }
    } else if (pickupTime.value.trim().isNotEmpty && !authorizePeriod.value) {
      if (int.parse(pickupTime.value.substring(0, 2)) < 06) {
        pickupFlag.value = false;
        pickupError.value = "Time can't be less then 06:00 AM";
      } else if (int.parse(pickupTime.value.replaceAll(":", "")) > 2100) {
        pickupFlag.value = false;
        pickupError.value = "Time can't be gretter then 09:00 PM";
      } else {
        pickupError.value = "";
        pickupFlag.value = true;
      }
    } else {
      pickupFlag.value = false;
      pickupError.value = "Pickup time can't be empty.";
    }

    update();
  }

  void setSelectDate(var dateSelect) {
    selectDate.value = dateSelect;
  }

  Future<bool> saveAuthorizePickup(var studentId) async {
    isFirstName = firstNamePickupPersionKey.currentState!.validate();
    isLastName = lastNamePickupPersionKey.currentState!.validate();
    isPickupPersionEmail = pickupPersionEmailKey.currentState!.validate();
    isPickupPersionPhone = pickupPersionPhoneKey.currentState!.validate();
    pickupAddress = pickupAddressKey.currentState!.validate();
    if (isFirstName &&
        isLastName &&
        isPickupPersionEmail &&
        isPickupPersionPhone &&
        pickupAddress) {
      showLoading();
      try {
        List<int> selectpDate = [];
        if (!authorizePeriod.value) {
          for (String val in selectPickDate.value) {
            selectpDate.add(
                DateFormat("MM/dd/yyyy").parseUTC(val).millisecondsSinceEpoch);
          }
        }
        List<Map> stuId = [];
        for (ParentStudents val in studentId) {
          stuId.add({"studentId": val.id});
        }
        var params = {
          "idDocument": "",
          "studentids": stuId,
          "firstName": firstNamePickupPersionController.text,
          "lastName": lastNamePickupPersionController.text,
          "email": pickupPersionEmailController.text,
          "phoneNumber": pickupPersionPhoneController.text,
          "fromDate": authorizePeriod.value
              ? DateFormat("MM/dd/yyyy")
                  .parseUTC(startDate.value)
                  .millisecondsSinceEpoch
              : null,
          "toDate": authorizePeriod.value
              ? DateFormat("MM/dd/yyyy")
                  .parseUTC(endDate.value)
                  .millisecondsSinceEpoch
              : null,
          "pickUpDates": authorizePeriod.value ? null : selectpDate,
          "pickUpDateType": authorizePeriod.value ? 1 : 2,
          "pickUpTime": "${pickupTime.value.substring(0, 5)}:00",
          "pickUpAddress": pickupAddressController.text,
          "dropLocation": "",
          "schoolId": schoolId.value,
          "roleId": roleId.value,
          "userId": userId.value
        };
        print(json.encode(params));
        var response = await BaseClient()
            .post(ApiEndPoints.devBaseUrl, ApiEndPoints.getaddAuthorizedPickUp,
                params)
            .catchError(handleError);
        hideLoading();
        if (response != null) {
          return true;
        }
        hideLoading();
        return false;
      } catch (e) {
        hideLoading();
        print(e);
        return false;
      }
    }
    hideLoading();
    return false;
  }

  getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      print(imageFile!.path);
      update();
    }
  }
}

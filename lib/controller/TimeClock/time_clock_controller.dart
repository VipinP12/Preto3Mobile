import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:preto3/components/success_dialog.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/model/punch_student_model.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/toast.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../components/success_dialog_timclock.dart';

class TimeClockController extends GetxController with BaseController {
  final storageBox = GetStorage();
  RxBool scanning = true.obs;
  QRViewController? qrViewController;
  Barcode? result;
  bool allowPop = true;
  var flagScan = false.obs;

  var code1 = "".obs;
  var code2 = "".obs;
  var code3 = "".obs;
  var code4 = "".obs;
  var invalidCode = false.obs;
  var punchedIn = false.obs;
  var punchedOut = false.obs;
  final numberList = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 0, 12].obs;
  var list = <String>[].obs;

  var idListStudent = <String>[].obs;
  var idListStaff = <String>[].obs;

  var childrenList = <PunchMasterMultipleRoleList>[].obs;
  var studentList = <StudentInfoList>[].obs;
  var childrenListTemp = <PunchMasterMultipleRoleList>[].obs;
  var studentListTemp = <StudentInfoList>[].obs;
  var clockTime = "".obs;
  var selectedDate = "".obs;
  var selectedIndex = 0.obs;
  var punchMasterId = 0.obs;
  var punchMasterRoleId = 0.obs;
  var punchMasterSchoolId = 0.obs;
  var punchMasterSchoolName = "".obs;
  var roleId = "".obs;
  var parentId = "".obs;
  var studentId = "".obs;
  var checkInOuPin = "".obs;
  var schoolId = "".obs;
  var qrCode = "".obs;
  var currentTime = TimeOfDay.now();
  var currentDate = DateTime.now();
  var byteImage = Uint8List.new;
  @override
  void onInit() {
    punchMasterId.value = storageBox.read(AppKeys.keyPunchMasterId);
    punchMasterRoleId.value = storageBox.read(AppKeys.keyPunchMasterRoleId);
    punchMasterSchoolId.value = storageBox.read(AppKeys.keyPunchMasterSchoolId);
    punchMasterSchoolName.value =
        storageBox.read(AppKeys.keyPunchMasterSchoolName);
    qrCode.value = storageBox.read(AppKeys.keySchoolQRCode);
    storageBox.writeIfNull(AppKeys.keyPunchedIn, false);
    schoolId.value = punchMasterSchoolId.value.toString();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      clockTime.value = DateFormat("hh:mm a")
          .format(DateTime.parse(DateTime.now().toString()));
      selectedDate.value =
          DateFormat('EEE,MM/dd/yyyy').format(currentDate).toString();
      update();
    });
    update();
    super.onInit();
  }

  @override
  void onReady() {
    final byteImage = const Base64Decoder().convert(qrCode.value);
    super.onReady();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    qrViewController?.dispose();
    super.dispose();
  }

  void onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  void verifyCode(String code, BuildContext context) async {
    if (list.length < 5) list.add(code);

    if (list.length == 4) {
      showLoading();
      String code = "${list[0]}${list[1]}${list[2]}${list[3]}";
      log("NUMBER $code");
      try {
        await pinPunchSession(code, punchMasterSchoolId.value, context);
      } catch (e) {
        print(e);
      }
      list.clear();
    }
    update();
  }

  Future<void> scannedQRCodeSession(
      String pin, String schoolId, QRViewController controller) async {
    var param = {
      "pin": pin,
      "schoolId": schoolId,
      "roleId": punchMasterRoleId.value
    };
    childrenList.clear();
    idListStaff.clear();
    idListStudent.clear();
    log("PAYLOAD:$param");
    try {
      var response = await BaseClient()
          .post(ApiEndPoints.devBaseUrl, ApiEndPoints.punchMasterCheckInOut,
              param)
          .catchError(handleError);
      if (response != null && response != "") {
        hideLoading();
        log("SCANNED QR RESPONSE:$response");
        var data = jsonDecode(response);
        if (data["status"] == true) {
          Future.delayed(const Duration(milliseconds: 1500), () {
            Get.back();
            controller.resumeCamera();
          });
          await Get.dialog(
              barrierDismissible: false,
              SuccessDialogTimeClock(
                message: data["message"],
              ));
        } else {
          log("STUDENT CHECKED IN OUT");
          var punchResponse = punchStudentModelFromJson(response);

          if (punchResponse.punchMasterMultipleRoleList.isNotEmpty) {
            childrenList.value = punchResponse.punchMasterMultipleRoleList;
            childrenListTemp.value = [];
            studentListTemp.value = [];
            try {
              for (var element in childrenList) {
                // studentId.value = element.userMetaData.split("_")[0];
                // parentId.value = element.userMetaData.split("_")[1];
                // roleId.value = element.userMetaData.split("_")[2];
                // log("STUDENT ID childrenList:${studentId.value}");
                // log("PARENT ID childrenList:${parentId.value}");
                // log("ROLE ID childrenList:${roleId.value}");
                if ('_'.allMatches(element.userMetaData).length == 2) {
                  Map<String, dynamic> parem = {
                    "profilePic": element.userProfilePic,
                    "id": int.parse(element.userMetaData.split("_")[0]),
                    "firstName": element.firstName,
                    "lastName": element.lastName,
                    "schoolId": element.schoolId,
                    "parentId": element.userMetaData.split("_")[1],
                    "checkedInOutStatus": element.checkedInOutStatus
                  };
                  studentListTemp.value.add(StudentInfoList.fromJson(parem));
                } else if ('_'.allMatches(element.userMetaData).length == 1) {
                  childrenListTemp.value.add(element);
                  //studentListTemp.value.add();
                }
              }
              childrenList.value = childrenListTemp.value;
              studentList.value = studentListTemp.value;
            } catch (e) {
              print(e);
            }
            log("hello");
            update();
            Get.toNamed(AppRoute.checkInChild);
          }
          if (punchResponse.studentInfoList.isNotEmpty &&
              punchResponse.punchMasterMultipleRoleList.isEmpty) {
            studentList.value = punchResponse.studentInfoList;
            log(studentList.first.firstName);
            log(studentList.last.lastName);
            log(studentList.first.id.toString());
            log(studentList.first.parentId.toString());
            for (var element in studentList) {
              studentId.value = element.id.toString();
              parentId.value = element.parentId.toString();
              roleId.value = roleId.value;
              log("STUDENT ID studentInfoList:${studentId.value}");
              log("PARENT ID studentInfoList:${parentId.value}");
              log("ROLE ID studentInfoList:${roleId.value}");
            }
            update();
            Get.toNamed(AppRoute.checkInChild);
          }
          if (punchResponse.punchMasterMultipleRoleList.isEmpty &&
              punchResponse.studentInfoList.isEmpty) {
            Future.delayed(const Duration(milliseconds: 1500), () {
              Get.back();
              controller.resumeCamera();
            });
            await Get.dialog(
                barrierDismissible: false,
                SuccessDialogTimeClock(
                  message: data["message"],
                ));
          }
        }
      } else {
        hideLoading();
        controller.pauseCamera();
        Get.snackbar(
          "",
          "Check in code is not correct",
          colorText: Colors.black,
          backgroundColor: Colors.red.shade200,
          icon: const Icon(Icons.warning),
        );
        print("jnenknfkn");
        Future.delayed(const Duration(milliseconds: 1500), () {
          Get.back();
          controller.resumeCamera();
        });
      }
    } catch (e) {
      hideLoading();
      controller.pauseCamera();
      Get.snackbar(
        "",
        "Check in code is not correct",
        colorText: Colors.black,
        backgroundColor: Colors.red.shade200,
        icon: const Icon(Icons.warning),
      );
      print("jnenknfkn");
      Future.delayed(const Duration(milliseconds: 1500), () {
        Get.back();
        controller.resumeCamera();
      });
    }
  }

  Future<void> pinPunchSession(
      String pin, int schoolId, BuildContext context) async {
    var param = {
      "pin": pin,
      "schoolId": schoolId,
      "roleId": punchMasterRoleId.value
    };
    print("PAYLOAD:$param");
    childrenList.clear();
    idListStaff.clear();
    idListStudent.clear();
    try {
      var response = await BaseClient()
          .post(ApiEndPoints.devBaseUrl, ApiEndPoints.punchMasterCheckInOut,
              param)
          .catchError(handleError);

      if (response != null && response != "") {
        log("SCANNED QR RESPONSE:$response");
        var data = jsonDecode(response);
        hideLoading();
        if (data["status"] == true) {
          Get.dialog(
              barrierDismissible: false,
              SuccessDialogTimeClock(
                message: data["message"],
              ));
          Future.delayed(const Duration(milliseconds: 1500), () {
            Get.back();
          });
        } else {
          log("STUDENT CHECKED IN OUT");
          var punchResponse = punchStudentModelFromJson(response);
          if (punchResponse.punchMasterMultipleRoleList.isNotEmpty) {
            childrenList.value = punchResponse.punchMasterMultipleRoleList;
            childrenListTemp.value = [];
            studentListTemp.value = [];
            try {
              for (var element in childrenList) {
                // studentId.value = element.userMetaData.split("_")[0];
                // parentId.value = element.userMetaData.split("_")[1];
                // roleId.value = element.userMetaData.split("_")[2];
                // log("STUDENT ID childrenList:${studentId.value}");
                // log("PARENT ID childrenList:${parentId.value}");
                // log("ROLE ID childrenList:${roleId.value}");
                if ('_'.allMatches(element.userMetaData).length == 2) {
                  Map<String, dynamic> parem = {
                    "profilePic": element.userProfilePic,
                    "id": int.parse(element.userMetaData.split("_")[0]),
                    "firstName": element.firstName,
                    "lastName": element.lastName,
                    "schoolId": element.schoolId,
                    "parentId": element.userMetaData.split("_")[1],
                    "checkedInOutStatus": element.checkedInOutStatus
                  };
                  studentListTemp.value.add(StudentInfoList.fromJson(parem));
                } else if ('_'.allMatches(element.userMetaData).length == 1) {
                  childrenListTemp.value.add(element);
                  //studentListTemp.value.add();
                }
              }
              childrenList.value = childrenListTemp.value;
              studentList.value = studentListTemp.value;
            } catch (e) {
              print(e);
            }
            log("hello");
            update();
            Get.toNamed(AppRoute.checkInChild);
          }
          if (punchResponse.studentInfoList.isNotEmpty &&
              punchResponse.punchMasterMultipleRoleList.isEmpty) {
            studentList.value = punchResponse.studentInfoList;
            log(studentList.first.firstName);
            log(studentList.last.lastName);
            log(studentList.first.id.toString());
            log(studentList.first.parentId.toString());
            for (var element in studentList) {
              studentId.value = element.id.toString();
              parentId.value = element.parentId.toString();
              roleId.value = roleId.value;
              log("STUDENT ID:${studentId.value}");
              log("PARENT ID:${parentId.value}");
              log("ROLE ID:${roleId.value}");
            }
            update();
            Get.toNamed(AppRoute.checkInChild);
          }
          if (punchResponse.punchMasterMultipleRoleList.isEmpty &&
              punchResponse.studentInfoList.isEmpty) {
            Get.dialog(
                barrierDismissible: false,
                SuccessDialogTimeClock(
                  message: data["message"],
                ));
            Future.delayed(const Duration(milliseconds: 1500), () {
              Get.back();
            });
          }
        }
      } else {
        hideLoading();
        list.clear();
        messageToastWarning(context, "Check in code is not correct");
      }
    } catch (e) {
      print(e);
      hideLoading();
      list.clear();
      messageToastWarning(context, "Check in code is not correct");
    }
  }

  void setstudentListIdList(int index) {
    if (studentList[index].isSelected) {
      studentId.value = studentList[index].id.toString();
      parentId.value = studentList[index].parentId.toString();
      roleId.value = "4";
      var id = "${studentId.value}_${parentId.value}_4";
      log("STUDENT ID oN SINGLE SELECT:${studentId.value}");
      log("PARENT ID oN SINGLE SELECT:${parentId.value}");
      log("ROLE ID oN SINGLE SELECT:${roleId.value}");
      log("COMBINED ID ON SINGLE SELECTED:$id");
      idListStudent.add(id);
      update();
    } else {
      studentId.value = studentList[index].id.toString();
      parentId.value = studentList[index].parentId.toString();
      roleId.value = "4";
      var id = "${studentId.value}_${parentId.value}_4";
      log("STUDENT ID oN SINGLE SELECT:${studentId.value}");
      log("PARENT ID oN SINGLE SELECT:${parentId.value}");
      log("ROLE ID oN SINGLE SELECT:${roleId.value}");
      log("COMBINED ID ON SINGLE SELECTED:$id");
      idListStudent.remove(id);
      print("##LIST## ${idListStudent.length}");
      update();
    }
    update();
  }

  void setchildrenListIdList(int index) {
    if (childrenList[index].isSelected) {
      String id = childrenList[index].userMetaData;
      idListStaff.add(id);
      print("##LIST## ${idListStaff.length}");
      update();
    } else {
      String id = childrenList[index].userMetaData;
      idListStaff.remove(id);
      print("##LIST## ${idListStaff.length}");
      update();
    }
  }

  void checkInMultiStaff(
    BuildContext context,
  ) async {
    showLoading();
    var param = {
      "selectedPersons": idListStaff,
      "roleId": idListStaff[0].split("_")[1],
      "schoolId": schoolId.value
    };

    log("LOG FOR PARAM $param");
    var response = await BaseClient()
        .post(ApiEndPoints.devBaseUrl, ApiEndPoints.multiplePersonCheckInOut,
            param)
        .catchError(handleError);
    if (response != null) {
      hideLoading();
      print("RESPONSE ====>$response");
      var data = jsonDecode(response);
      // var splitString=data["message"];
      var checkInOutMode = data["checkInOutMode"];
      if (checkInOutMode == 2) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const SuccessDialog(
              message: "Checked In Successfully",
            );
          },
        );
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const SuccessDialog(
              message: "Checked Out Successfully",
            );
          },
        );
      }
    }
  }

  void checkInMultiStudent(
    BuildContext context,
  ) async {
    showLoading();
    var param = {
      "selectedPersons": idListStudent,
      "roleId": "4",
      "schoolId": schoolId.value
    };

    log("LOG FOR PARAM $param");
    var response = await BaseClient()
        .post(ApiEndPoints.devBaseUrl, ApiEndPoints.multiplePersonCheckInOut,
            param)
        .catchError(handleError);
    if (response != null) {
      hideLoading();
      print("RESPONSE ====>$response");
      var data = jsonDecode(response);
      // var splitString=data["message"];
      var dataString = data["message"];
      var splitString = dataString.split(" ");
      var message1 = splitString[1];
      var message2 = splitString[2];
      var message3 = splitString[3];
      var message = message1 + " " + message2 + " " + message3;

      if (message == "Checked In Successfully") {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const SuccessDialog(
              message: "Checked In Successfully",
            );
          },
        );
        // Get.dialog(
        //     barrierDismissible: false,
        //     const SuccessDialog(
        //       message: "Checked In Successfully",
        //     ));
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const SuccessDialog(
              message: "Checked Out Successfully",
            );
          },
        );
        // Get.dialog(
        //     barrierDismissible: false,
        //     const SuccessDialog(
        //       message: "Checked Out Successfully",
        //     ));
      }
    }
  }

  void punchInSession() {
    if (storageBox.read(AppKeys.keyPunchedIn)) {
      //CHECK OUT STUDENT
      callPunchOutAPI();
    } else {
      //CHECK IN STUDENT
      callPunchInAPI();
    }
  }

  void callPunchInAPI() async {
    var params = {
      "schoolId": schoolId.value,
      "checkInMode": 2,
      "studentId": studentId.value,
      "userId": parentId.value,
      "roleId": punchMasterRoleId.value,
    };
    print("PARAMS:$params");
    showLoading('Fetching data');
    var response = await BaseClient()
        .post(ApiEndPoints.devBaseUrl, ApiEndPoints.punchStudentCheckInOut,
            params)
        .catchError(handleError);
    if (response != null) {
      print("PUNCH IN RESPONSE:$response");
      storageBox.write(AppKeys.keyPunchedIn, true);
      punchedIn.value = true;
      hideLoading();
      Get.dialog(const SuccessDialog(
        message: "Checked In Successfully",
      ));
      update();
    }
  }

  void callPunchOutAPI() async {
    var params = {
      "schoolId": schoolId.value,
      "checkInMode": 3,
      "studentId": studentId.value,
      "userId": parentId.value,
      "roleId": punchMasterRoleId.value,
    };
    print("PARAMS:$params");
    showLoading('Fetching data');
    var response = await BaseClient()
        .post(ApiEndPoints.devBaseUrl, ApiEndPoints.punchStudentCheckInOut,
            params)
        .catchError(handleError);
    if (response != null) {
      print("PUNCH OUT RESPONSE:$response");
      punchedOut.value = true;
      storageBox.write(AppKeys.keyPunchedIn, false);
      hideLoading();
      Get.dialog(const SuccessDialog(
        message: "Checked Out Successfully",
      ));
      update();
    }
  }
}

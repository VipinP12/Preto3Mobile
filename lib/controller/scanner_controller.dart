import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:preto3/components/custom_dialog.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/model/punch_student_model.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../components/success_dialog.dart';
import '../components/success_dialog_timclock.dart';

class ScannerController extends GetxController with BaseController {
  final storageBox = GetStorage();

  RxBool scanning = true.obs;
  QRViewController? qrViewController;
  Barcode? result;

  var selectedIndex = 0.obs;
  var childrenList = <PunchMasterMultipleRoleList>[].obs;
  var studentList = <StudentInfoList>[].obs;
  var idList = <String>[].obs;
  var parentId = "".obs;
  var studentId = "".obs;

  var punchedIn = false.obs;
  var punchedOut = false.obs;
  var childrenId = 0.obs;
  var roleId = 0.obs;
  var schoolId = 0.obs;
  var checkInOutPin = "".obs;
  var flag = false.obs;

  @override
  void onInit() {
    childrenId.value = storageBox.read(AppKeys.keyId);
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    checkInOutPin.value = storageBox.read(AppKeys.keyCheckInOutPin);
    storageBox.writeIfNull(AppKeys.keyPunchedIn, false);
    super.onInit();
  }

  @override
  void onClose() {
    qrViewController?.resumeCamera();
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
    qrViewController?.dispose();
  }

  Future<void> scannedQRCodeSession(
      String pin, String schoolId, QRViewController controller) async {
    var param = {"pin": pin, "schoolId": schoolId, "roleId": roleId.value};
    // childrenList.clear();
    log("PAYLOAD:$param");
    var response = await BaseClient()
        .post(
            ApiEndPoints.devBaseUrl, ApiEndPoints.punchMasterCheckInOut, param)
        .catchError(handleError);
    if (response != null && response != "") {
      log("SCANNED QR RESPONSE:$response");
      log("STUDENT CHECKED IN OUT");
      var data = jsonDecode(response);
      var punchResponse = punchStudentModelFromJson(response);

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
      } else if (punchResponse.punchMasterMultipleRoleList.isNotEmpty) {
        childrenList.value = punchResponse.punchMasterMultipleRoleList;
        childrenList.removeAt(0);
        log(childrenList.first.firstName);
        log(childrenList.last.lastName);
        for (var element in childrenList) {
          studentId.value = element.userMetaData.split("_")[0];
          parentId.value = element.userMetaData.split("_")[1];
          log("STUDENT ID:${studentId.value}");
          log("PARENT ID:${parentId.value}");
          log("ROLE ID:${roleId.value}");
        }
        update();
        Get.toNamed(AppRoute.childrenCheckInOut);
      } else if (punchResponse.studentInfoList.isNotEmpty &&
          punchResponse.punchMasterMultipleRoleList.isEmpty) {
        studentList.value = punchResponse.studentInfoList;
        log(studentList.first.firstName);
        log(studentList.last.lastName);
        for (var element in studentList) {
          studentId.value = element.id.toString();
          parentId.value = element.parentId.toString();
          roleId.value = roleId.value;
          log("STUDENT ID:${studentId.value}");
          log("PARENT ID:${parentId.value}");
          log("ROLE ID:${roleId.value}");
        }
        update();
        Get.toNamed(AppRoute.childrenCheckInOut);
      } else {
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
    } else {
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

  void setIdList(int index) {
    if (childrenList.isNotEmpty) {
      if (childrenList[index].isSelected) {
        String id = childrenList[index].userMetaData;
        idList.add(id);
        update();
      } else {
        String id = childrenList[index].userMetaData;
        idList.remove(id);
        update();
      }
    } else {
      if (studentList[index].isSelected) {
        studentId.value = studentList[index].id.toString();
        parentId.value = studentList[index].parentId.toString();
        var id = "${studentId.value}_${parentId.value}_4";
        print("STUDENT ID oN SINGLE SELECT:${studentId.value}");
        print("PARENT ID oN SINGLE SELECT:${parentId.value}");
        print("ROLE ID oN SINGLE SELECT:${roleId.value}");
        print("COMBINED ID ON SINGLE SELECTED:$id");
        idList.add(id);
        print("##LIST## ${idList.length}");
        update();
      } else {
        studentId.value = studentList[index].id.toString();
        parentId.value = studentList[index].parentId.toString();

        var id = "${studentId.value}_${parentId.value}_4";
        print("STUDENT ID oN SINGLE SELECT:${studentId.value}");
        print("PARENT ID oN SINGLE SELECT:${parentId.value}");
        print("ROLE ID oN SINGLE SELECT:${roleId.value}");
        print("COMBINED ID ON SINGLE SELECTED:$id");
        idList.remove(id);
        print("##LIST## ${idList.length}");
        update();
      }
    }

    update();
  }

  void checkInMultiPerson(BuildContext context) async {
    showLoading();
    var param = {
      "selectedPersons": idList,
      "roleId": roleId.value,
      "schoolId": schoolId.value
    };
    print(param);

    var response = await BaseClient()
        .post(ApiEndPoints.devBaseUrl, ApiEndPoints.multiplePersonCheckInOut,
            param)
        .catchError(handleError);
    if (response != null) {
      hideLoading();
      var data = jsonDecode(response);
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
            return CustomDialog(
              message: "Checked In Successfully",
              roleId: roleId.value,
            );
          },
        );
        // Get.dialog(
        //     barrierDismissible: false,
        //     CustomDialog(
        //       message: "Checked In Successfully",
        //       roleId: roleId.value,
        //     ));
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return CustomDialog(
              message: "Checked Out Successfully",
              roleId: roleId.value,
            );
          },
        );
        // Get.dialog(
        //     barrierDismissible: false,
        //     CustomDialog(
        //       message: "Checked Out Successfully",
        //       roleId: roleId.value,
        //     ));
      }
    }
  }

  void punchInSession(BuildContext context) {
    if (storageBox.read(AppKeys.keyPunchedIn)) {
      //CHECK OUT STUDENT
      callPunchOutAPI(context);
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
      "roleId": roleId.value,
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
      update();
    }
  }

  void callPunchOutAPI(BuildContext context) async {
    var params = {
      "schoolId": schoolId.value,
      "checkInMode": 3,
      "studentId": studentId.value,
      "userId": parentId.value,
      "roleId": roleId.value,
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
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return const SuccessDialog(
            message: "Checked Out Successfully",
          );
        },
      );
      Get.offAllNamed(AppRoute.dashboardParent);
      update();
    }
  }
}

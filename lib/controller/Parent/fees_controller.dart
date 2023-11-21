import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/model/parent/childern_fees_invoice_model.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/invoice_staus.dart';

class FeesController extends GetxController with BaseController {
  final storageBox = GetStorage();
  dynamic argumentData = Get.arguments;
  var roleId = 0.obs;
  var schoolId = 0.obs;
  var studentId = 0.obs;
  var totalBalanceDues = 0.00.obs;
  var upcomingDues = 0.00.obs;
  var pastDues = 0.00.obs;
  var totalpaid = 0.00.obs;
  var allChildern = <AllChild>[].obs;
  var invoice = <Invoice>[].obs;
  AllChild? allChildValue;
  var selectAll = true.obs;
  var startDate = "".obs;
  var endDate = "".obs;
  var currentDate = DateTime.now();
  var startDateValidation = false.obs;
  var endDateValidation = false.obs;
  var status = 5.obs;
  var statusVal = "All".obs;
  var dropDownInitialValue = "All".obs;
  InvoiceStatus? invoiceStatus;
  InvoiceStatus? invoiceStatusDefault;

  @override
  void onInit() {
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    invoiceStatus = statusList.first;
    invoiceStatusDefault = statusList.first;
    update();
    super.onInit();
  }

  @override
  void onReady() {
    String url =
        "roleId=${roleId.value}&schoolId=${schoolId.value}&status=${status.value}";
    getChildernFeesDetails(url);
  }

  void setChild(AllChild allChild) {
    allChildValue = allChild;
    selectAll.value = false;
    update();
  }

  void setStatus(InvoiceStatus list) {
    invoiceStatus = list;
    status.value = list.id;
    statusVal.value = list.value;
    update();
  }

  void setStatusDefault(InvoiceStatus list) {
    invoiceStatusDefault = list;
    update();
  }

  void setStartDate(var startD) {
    startDate.value = startD.toString();
    if (startDate.value != "" && endDate.value != "") {
      if (dateDifference()) {
        startDateValidation.value = false;
        endDateValidation.value = false;
        applyDateFilterOnApi(true);
      } else {
        startDateValidation.value = true;
      }
    } else if (startDate.value == "") {
      startDateValidation.value = false;
      applyDateFilterOnApi(false);
    }
    update();
  }

  void setEndDate(var endD) {
    endDate.value = endD.toString();
    if (startDate.value != "" && endDate.value != "") {
      if (dateDifference()) {
        startDateValidation.value = false;
        endDateValidation.value = false;
        applyDateFilterOnApi(true);
      } else {
        endDateValidation.value = true;
      }
    } else if (endDate.value == "") {
      endDateValidation.value = false;
      applyDateFilterOnApi(false);
    }
    update();
  }

  dateDifference() {
    DateTime startDateCheck = DateFormat("dd-MM-yyyy").parse(startDate.value);
    DateTime endDateCheck = DateFormat("dd-MM-yyyy").parse(endDate.value);
    int diffInDays = endDateCheck.difference(startDateCheck).inDays;
    if (diffInDays == 0) {
      return true;
    } else if (diffInDays > 0) {
      return true;
    } else {
      return false;
    }
  }

  void getChildernFeesDetails(
    String url,
  ) async {
    showLoading('Fetching data');
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl, '${ApiEndPoints.studentAccounts}?$url')
        .catchError(handleError);
    if (response != null) {
      isOnline.value = true;
      var dashResponse =
          ChildernFeesInvoiceModel.fromJson(jsonDecode(response.toString()));
      totalBalanceDues.value = dashResponse.totalBalanceDues;
      upcomingDues.value = dashResponse.upcomingDues;
      pastDues.value = dashResponse.pastDues;
      totalpaid.value = dashResponse.totalpaid;
      allChildern.value = dashResponse.allChildren;
      invoice.value = dashResponse.invoices;
      if (dashResponse.allChildren.length == 1) {
        setChild(dashResponse.allChildren[0]);
        setStatus(InvoiceStatus(id: 5, value: "All"));
        String url =
            "roleId=${roleId.value}&schoolId=${schoolId.value}&studentId=${dashResponse.allChildren[0].id}&status=${status}";
        getChildernFeesDetailsUsingFilter(url);
      }
    }
    update();
    hideLoading();
  }

  void getChildernFeesDetailsUsingFilter(
    String url,
  ) async {
    showLoading('Fetching data');
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl, '${ApiEndPoints.studentAccounts}?$url')
        .catchError(handleError);
    if (response != null) {
      isOnline.value = true;
      var dashResponse =
          ChildernFeesInvoiceModel.fromJson(jsonDecode(response.toString()));
      totalBalanceDues.value = dashResponse.totalBalanceDues;
      upcomingDues.value = dashResponse.upcomingDues;
      pastDues.value = dashResponse.pastDues;
      totalpaid.value = dashResponse.totalpaid;
      invoice.value = dashResponse.invoices;
    }
    update();
    hideLoading();
  }

  pickDate(BuildContext context) async {
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null) {
      return DateFormat("dd-MM-yyyy").format(pickedDate);
    } else {
      return "";
    }
  }

  void applyDateFilterOnApi(bool statusFlag) {
    if (statusFlag) {
      int startEpochTime = DateFormat("dd-MM-yyyy")
          .parse(startDate.value)
          .millisecondsSinceEpoch;
      int endEpochTime =
          DateFormat("dd-MM-yyyy").parse(endDate.value).millisecondsSinceEpoch;
      String url =
          "roleId=${roleId.value}&schoolId=${schoolId.value}&studentId=${allChildValue!.id}&startDate=$startEpochTime&endDate=$endEpochTime&status=${status.value}";

      getChildernFeesDetailsUsingFilter(url);
    } else {
      String url =
          "roleId=${roleId.value}&schoolId=${schoolId.value}&studentId=${allChildValue!.id}&status=${status.value}";
      getChildernFeesDetailsUsingFilter(url);
    }
  }

  List<InvoiceStatus> statusList = [
    InvoiceStatus(
      id: 5,
      value: "All",
    ),
    InvoiceStatus(
      id: 0,
      value: "Unpaid invoice",
    ),
    InvoiceStatus(
      id: 1,
      value: "Paid invoice",
    ),
    InvoiceStatus(
      id: 2,
      value: "Processing",
    ),
    InvoiceStatus(
      id: 4,
      value: "Partially paid invoice",
    ),
    InvoiceStatus(
      id: 3,
      value: "Declined invoice",
    ),
    InvoiceStatus(
      id: 6,
      value: "Refunded invoice",
    ),
  ];
}

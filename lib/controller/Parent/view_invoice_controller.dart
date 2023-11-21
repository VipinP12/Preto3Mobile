import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../model/parent/childern_fees_invoice_model.dart';
import '../../model/parent/invoice_details_model.dart';
import '../../model/parent/invoice_download_model.dart';
import '../../network/api_end_points.dart';
import '../../network/base_client.dart';
import '../../utils/app_keys.dart';
import '../../utils/argument_keys.dart';
import '../base_controller.dart';

import 'package:http/http.dart' as http;

class ViewInvoiceController extends GetxController with BaseController {
  final storageBox = GetStorage();
  dynamic argumentData = Get.arguments;

  Invoice? invoice;
  InvoiceDetailsModel? invoiceResponse;
  var lineItem = <LineItem>[].obs;
  var parentFirstName = "".obs;
  var parentLastName = "".obs;
  var parentEmail = "".obs;
  var schoolName = "".obs;
  var schoolAddress = "".obs;
  var einNumber = "".obs;
  var serviceStartDate = "".obs;
  var serviceEndDate = "".obs;
  var issueDate = "".obs;
  var dueDate = "".obs;
  var dueBalance = 0.0.obs;
  var childFirstName = "".obs;
  var childLastName = "".obs;
  var totalAmount = 0.0.obs;
  var invoiceId = "".obs;
  var parentProfileUrl = "".obs;
  var loginParentFirstName = "".obs;
  var loginParentLastName = "".obs;
  var isRecurring = false.obs;
  var invoiceURl = "".obs;
  var schoolId = 0.obs;
  String text = '';
  String subject = '';

  List<String> imageNames = [];
  List<String> imagePaths = [];
  @override
  void onInit() {
    invoice = argumentData[ArgumentKeys.invoiceDetails];
    isRecurring.value = invoice!.isRecurring;
    loginParentFirstName.value = storageBox.read(AppKeys.keyFirstName);
    loginParentLastName.value = storageBox.read(AppKeys.keyLastName);
    parentProfileUrl.value = storageBox.read(AppKeys.keyParentProfileURL);
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    downloadInvoiceUrl();
    update();
    super.onInit();
  }

  @override
  void onReady() {
    getChildrenFeesDetailsUsingFilter();
  }

  void getChildrenFeesDetailsUsingFilter() async {
    showLoading('Fetching data');

    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.getInvoiceDetail}?invoiceId=${invoice!.invoiceId}')
        .catchError(handleError);
    if (response != null) {
      isOnline.value = true;
      invoiceResponse =
          InvoiceDetailsModel.fromJson(jsonDecode(response.toString()));
      if (invoiceResponse!.parents.isNotEmpty) {
        parentFirstName.value = invoiceResponse!.parents[0].firstname;
        parentLastName.value = invoiceResponse!.parents[0].lastname;
        parentEmail.value = invoiceResponse!.parents[0].emailid;
        schoolName.value = invoiceResponse!.schoolName;
        schoolAddress.value = invoiceResponse!.schoolAddress;
        serviceStartDate.value = invoiceResponse!.serviceStartDate;
        serviceEndDate.value = invoiceResponse!.serviceEndDate;
        issueDate.value = invoiceResponse!.issueDate;
        dueDate.value = invoiceResponse!.dueDate;
        dueBalance.value = invoiceResponse!.balanceAmount;
        childFirstName.value = invoiceResponse!.studentFirstName;
        childLastName.value = invoiceResponse!.studentLastName;
        totalAmount.value = invoiceResponse!.totalAmount;
        invoiceId.value =
            invoiceResponse!.invoiceNumber.toString().substring(3);
        lineItem.value = invoiceResponse!.lineItems;
        einNumber.value = invoiceResponse!.einNumber.toString();
      }
    }
    update();
    hideLoading();
  }

  void onShare(
    BuildContext context,
    String invoiceNo,
  ) async {
    final box = context.findRenderObject() as RenderBox?;

    String message = "Hello, Im trying to share something";
    List<int> list=[0];
    list[3];
    text = "Invoice #$invoiceNo";
    subject = "Check this out";
    // SHARE JUST A TEXT
    // Share.share(message);
    imagePaths.clear();
    // SHARE IMAGE
    if (Platform.isAndroid && Platform.isIOS) {
      // const url = 'https://www.youtube.com/watch?v=PAOAjOR6K_Q';
      const url =
          'https://i.postimg.cc/054f5CSP/pexels-todd-trapani-1535162.jpg';
      final response = await http.get(Uri.parse(url));
      final bytes = response.bodyBytes;
      final tempDir = await getExternalStorageDirectory();

      final pathImage = '${tempDir!.path}/image.jpg';
      const nameImage = "image";
      imagePaths.add(pathImage);
      imageNames.add(nameImage);
      File(pathImage).writeAsBytesSync(bytes);
      if (imagePaths.isNotEmpty) {
        final files = <XFile>[];
        for (var i = 0; i < imagePaths.length; i++) {
          log(imagePaths[i]);
          files.add(XFile(imagePaths[i], name: imageNames[i]));
        }
        await Share.shareXFiles(files,
            text: text,
            subject: subject,
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
      } else {
        await Share.share(text,
            subject: subject,
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
      }
    }
  }

  void downloadInvoiceUrl() async {
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.downloadInvoice}?invoiceId=${invoice!.invoiceId}&schoolId=${schoolId.value}')
        .catchError(handleError);
    if (response != null) {
      var invoice = invoiceDownloadModelFromJson(response);
      if (invoice.fileDownloadUri != "") {
        invoiceURl.value = invoice.fileDownloadUri;
        update();
      }
    }
  }
}

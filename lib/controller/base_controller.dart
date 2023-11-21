import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/network/app_exceptions.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_dialog.dart';
import 'package:preto3/utils/app_routes.dart';

class BaseController {
  var isError = false.obs;
  var isOnline = true.obs;
  var errorMessage = "".obs;
  BuildContext? context;
  void handleError(error) {
    hideLoading();
    if (error is BadRequestException) {
      isError.value = true;
      errorMessage.value = error.message.toString();
      log("BAD REQ:${errorMessage.value}");
      AppDialog.snackBarDialog(title: "Error", message: errorMessage.value);
    } else if (error is UnAuthorizedException) {
      isError.value = true;
      errorMessage.value = error.message.toString();
      log("UNAUTHORIZED  EXCEPTION:${errorMessage.value}");
      AppDialog.snackBarDialog(
          title: "UnAuthorized", message: errorMessage.value);
    } else if (error is ForbiddenException) {
      isError.value = true;
      errorMessage.value = error.message.toString();
      log("FORBIDDEN  EXCEPTION:${errorMessage.value}");
      AppDialog.snackBarDialog(title: "Forbidden", message: errorMessage.value);
    } else if (error is FetchDataException) {
      isError.value = true;
      errorMessage.value = error.message.toString();
      log("FETCH DATA EXCEPTION:${errorMessage.value}");
      AppDialog.snackBarDialog(message: errorMessage.value);
    } else if (error is SocketException) {
      isOnline.value = false;
      errorMessage.value = error.message.toString();
      log("NO INTERNET AVAILABLE:${errorMessage.value}");
      AppDialog.snackBarDialog(
          title: "Network Error", message: errorMessage.value);
    } else if (error is ApiNotRespondingException) {
      isError.value = true;
      AppDialog.snackBarDialog(
          title: "Server Not Responding",
          message: 'Oops! It took longer to respond.');
    } else if (error is ExpectationFailed) {
      isError.value = true;
      errorMessage.value = error.message.toString();
      AppDialog.snackBarDialog(
          title: "Expectation Failed", message: errorMessage.value);
    } else {
      isError.value = true;
      errorMessage.value = error.message;
      AppDialog.snackBarDialog(message: errorMessage.value);
      log("EXCEPTION:${errorMessage.value}");
    }
  }

  showLoading([String? message]) {
    AppDialog.showLoading(message);
  }

  hideLoading() {
    AppDialog.hideLoading();
  }

  showLoadingHideBackground([String? message]) {
    AppDialog.showLoadingHideBackgroud(message);
  }

  hideLoadingHideBackground() {
    AppDialog.hideLoadingBackground();
  }

  successPunchIn(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                height: 150,
                width: 300,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: SvgPicture.asset(AppAssets.successIcon)),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Successfully Checked In!',
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      InkWell(
                        onTap: () => Get.offAllNamed(AppRoute.timeClock),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'OK',
                            style: GoogleFonts.poppins(
                                color: AppColor.appPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  successPunchOut(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                height: 150,
                width: 300,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: SvgPicture.asset(AppAssets.successIcon)),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Successfully Checked Out!',
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      InkWell(
                        onTap: () => Get.offAllNamed(AppRoute.timeClock),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'OK',
                            style: GoogleFonts.poppins(
                                color: AppColor.appPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}

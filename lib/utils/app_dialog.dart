import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:preto3/utils/app_color.dart';

class AppDialog {
  //show error dialog
  static void showErroDialog(
      {String title = 'Error', String? description = 'Something went wrong'}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.headline4,
              ),
              Text(
                description ?? '',
                style: Get.textTheme.headline6,
              ),
              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: const Text('Okay'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //show toast
  //show snack bar

  static void snackBarDialog(
      {String title = "Error", String? message = "Something went wrong"}) {
    Get.snackbar(title, message.toString(),
        colorText: Colors.white,
        backgroundColor: AppColor.appPrimary,
        snackPosition: SnackPosition.BOTTOM);
  }

  //show warning snack bar
  static void snackBarWarningDialog(
      {String title = "Warning", String? message = "Something went wrong"}) {
    Get.snackbar(title, message.toString(),
        colorText: Colors.white,
        backgroundColor: AppColor.appPrimary,
        snackPosition: SnackPosition.BOTTOM);
  }

  //show loading
  static void showLoading([String? message]) {
    Get.dialog(
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Lottie.asset('assets/lottie/loader.json'),
        ),
        barrierColor: Color.fromARGB(65, 0, 0, 0));
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }

  static void showLoadingHideBackgroud([String? message]) {
    Get.dialog(
        Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.appPrimary,
            title: const Text("Loading...."),
            centerTitle: false,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Lottie.asset('assets/lottie/loader.json'),
            ),
          ),
        ),
        barrierColor: Colors.white);
  }

  //hide loading
  static void hideLoadingBackground() {
    if (Get.isDialogOpen!) Get.back();
  }
}

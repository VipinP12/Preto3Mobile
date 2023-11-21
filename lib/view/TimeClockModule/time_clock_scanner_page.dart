import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/components/rounded_button.dart';
import 'package:preto3/components/success_dialog.dart';
import 'package:preto3/controller/TimeClock/time_clock_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class TimeClockScanner extends StatelessWidget {
  TimeClockScanner({Key? key}) : super(key: key);

  final timeClockController = Get.find<TimeClockController>();

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var scanArea = (width < 400 || height < 400) ? width * 0.8 : height * 0.8;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColor.scaffoldBackground,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColor.appPrimary,
            title: Container(
              // padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
              margin: const EdgeInsets.only(
                  top: 10, left: 40, right: 40, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: const Image(
                                  image: AssetImage(AppAssets.appLogo)))),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              timeClockController.clockTime.value,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                          Obx(() => Text(
                                timeClockController.selectedDate.value,
                                style: const TextStyle(fontSize: 10),
                              ))
                        ],
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      timeClockController.storageBox.erase();
                      Get.offAndToNamed(AppRoute.login);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.timeClockLogout,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Log out",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: AppColor.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to",
                    style: GoogleFonts.poppins(
                        color: AppColor.heavyTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    timeClockController.punchMasterSchoolName.value,
                    style: GoogleFonts.poppins(
                        color: AppColor.heavyTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Scan your QR code",
                    style: GoogleFonts.poppins(
                        color: AppColor.heavyTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.6,
                    color: Colors.transparent,
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: onQrCodeReading,
                      onPermissionSet: (ctrl, p) =>
                          onPermissionSet(context, ctrl, p),
                      cameraFacing: CameraFacing.front,
                      overlay: QrScannerOverlayShape(
                          borderColor: AppColor.appPrimary,
                          borderRadius: 10,
                          borderLength: 30,
                          borderWidth: 10,
                          cutOutSize: scanArea),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: RoundedButton(
                      height: 42,
                      width: 180,
                      color: AppColor.appPrimary,
                      text: 'Switch to QR code',
                      style: GoogleFonts.poppins(
                          color: AppColor.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      onClick: () {
                        Get.offAllNamed(AppRoute.scanQRPage);
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Enter you 4-digit check in code"),
                    ),
                    Obx(
                      () => Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        //                    <--- top side
                                        color: AppColor.borderColor,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    timeClockController.list.isNotEmpty
                                        ? timeClockController.list[0]
                                        : "*",
                                    style: GoogleFonts.poppins(
                                        color: AppColor.heavyTextColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                              Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        //                    <--- top side
                                        color: AppColor.borderColor,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    timeClockController.list.length >= 2
                                        ? timeClockController.list[1]
                                        : "*",
                                    style: GoogleFonts.poppins(
                                        color: AppColor.heavyTextColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                              Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        //                    <--- top side
                                        color: AppColor.borderColor,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    timeClockController.list.length >= 3
                                        ? timeClockController.list[2]
                                        : "*",
                                    style: GoogleFonts.poppins(
                                        color: AppColor.heavyTextColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                              Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        //                    <--- top side
                                        color: AppColor.borderColor,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    timeClockController.list.length >= 4
                                        ? timeClockController.list[3]
                                        : "*",
                                    style: GoogleFonts.poppins(
                                        color: AppColor.heavyTextColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      height: 240,
                      width: 180,
                      color: Colors.white,
                      child: GetBuilder<TimeClockController>(
                        builder: (controller) => GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 2 / 2,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 2),
                            itemCount: controller.numberList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  if (index == 10) {
                                    controller.numberList[10] == 0;
                                    String number = (0).toString();
                                    controller.verifyCode(number, context);
                                  } else {
                                    String number = (index + 1).toString();
                                    controller.verifyCode(number, context);
                                  }
                                },
                                child: controller.numberList[index] == 11
                                    ? InkWell(
                                        onTap: () {
                                          controller.list.clear();
                                          controller.update();
                                        },
                                        child: Center(
                                            child: Text(
                                          "Clear",
                                          style: GoogleFonts.poppins(
                                              color: AppColor.heavyTextColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        )),
                                      )
                                    : controller.numberList[index] == 12
                                        ? InkWell(
                                            onTap: () {
                                              controller.list.removeLast();
                                              controller.update();
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: SvgPicture.asset(
                                                AppAssets.deleteNumber,
                                                height: 24,
                                                width: 24,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: AppColor.borderColor,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Center(
                                              child: Text(
                                                controller.numberList[index]
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    color:
                                                        AppColor.heavyTextColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            )),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 16,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onQrCodeReading(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) async {
      if (Platform.isAndroid) {
        controller.pauseCamera();
      } else {
        controller.resumeCamera();
      }
      controller.resumeCamera();
      try {
        timeClockController.schoolId.value = scanData.code!.split("_")[2];
        timeClockController.checkInOuPin.value = scanData.code!.split("_")[3];
        print("SCHOOL ID:${timeClockController.schoolId.value}");
        print("CHECK IN OUT:${timeClockController.checkInOuPin.value}");
        if (scanData.code!.isNotEmpty &&
            timeClockController.schoolId.value.isNotEmpty &&
            timeClockController.checkInOuPin.value.isNotEmpty &&
            !timeClockController.flagScan.value) {
          timeClockController.showLoading();
          timeClockController.flagScan.value = true;
          try {
            controller.pauseCamera();
            await timeClockController.scannedQRCodeSession(
                timeClockController.checkInOuPin.value,
                timeClockController.schoolId.value,
                controller);
            controller.resumeCamera();
            timeClockController.flagScan.value = false;
          } catch (e) {
            timeClockController.flagScan.value = false;
          }
        } else {
          if (!timeClockController.flagScan.value) {
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
      } catch (e) {
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
    });
  }

  void doNothing(QRViewController controller) {
    log('stopped');
  }

  onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}

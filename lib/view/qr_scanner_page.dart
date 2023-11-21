import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/components/success_dialog.dart';
import 'package:preto3/controller/scanner_controller.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerPage extends StatelessWidget {
  QrScannerPage({Key? key}) : super(key: key);

  final scannerController = Get.find<ScannerController>();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var scanArea = (width < 400 || height < 400) ? width * 0.8 : height * 0.5;
    return Scaffold(
      backgroundColor: AppColor.heavyTextColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Scan QR code",
                      style: GoogleFonts.poppins(
                          color: AppColor.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                    Center(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.width * 0.8,
                          color: AppColor.heavyTextColor,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: QRView(
                              key: qrKey,
                              onQRViewCreated: onQrCodeReading,
                              onPermissionSet: (ctrl, p) =>
                                  onPermissionSet(context, ctrl, p),
                              cameraFacing: CameraFacing.back,
                              overlay: QrScannerOverlayShape(
                                  borderColor: AppColor.appPrimary,
                                  borderRadius: 10,
                                  borderLength: 30,
                                  borderWidth: 10,
                                  cutOutSize: scanArea),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
              ],
            ),
            Obx(
              () => scannerController.flag.value
                  ? Positioned(
                      child: Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: const CircularProgressIndicator(
                          color: AppColor.appPrimary,
                        ),
                      ),
                    ))
                  : Container(),
            )
          ],
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
        log("SCAN DATA:${scanData.code}");
        var data = scanData.code;
        var schoolId = data!.split("_")[0];
        controller.resumeCamera();
        log("SCHOOL ID:$schoolId");
        log("CHECK IN OUT:${scannerController.checkInOutPin.value}");
        if (scanData.code!.isNotEmpty &&
            scannerController.checkInOutPin.value.isNotEmpty &&
            !scannerController.flag.value) {
          scannerController.flag.value = true;
          try {
            controller.pauseCamera();
            await scannerController.scannedQRCodeSession(
                scannerController.checkInOutPin.value, schoolId, controller);
            controller.resumeCamera();
            scannerController.flag.value = false;
          } catch (e) {
            scannerController.flag.value = false;
          }
        } else {
          if (!scannerController.flag.value) {
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
    Get.back();
  }

  onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}

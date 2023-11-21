import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/components/rounded_button.dart';
import 'package:preto3/controller/TimeClock/time_clock_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';

class QrcodePage extends StatelessWidget {
  QrcodePage({Key? key}) : super(key: key);
  final timeClockController = Get.find<TimeClockController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.appPrimary,
          title: Container(
            // padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
            margin:
                const EdgeInsets.only(top: 10, left: 40, right: 40, bottom: 10),
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
                  onTap: (){
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Scan QR code",
            style: GoogleFonts.poppins(
                color: AppColor.heavyTextColor,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 200,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              color: AppColor.black,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              "Log in to ‘PREto3’ app.",
                              style: GoogleFonts.poppins(
                                  color: AppColor.heavyTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: AppColor.black,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              "On the right hand corner, choose ‘Scan Icon’",
                              style: GoogleFonts.poppins(
                                  color: AppColor.heavyTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: AppColor.black,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              "Finally, scan the code through the option to complete the check in/out",
                              style: GoogleFonts.poppins(
                                  color: AppColor.heavyTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              SizedBox(
                height: 150,
                width: 150,
                child: Image.memory(
                  const Base64Decoder().convert(timeClockController.qrCode.value),
                  fit: BoxFit.cover,
                ),
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: RoundedButton(
              height: 42,
              width: 180,
              color: AppColor.appPrimary,
              text: 'Switch to Pin pad',
              style: GoogleFonts.poppins(
                  color: AppColor.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              onClick: () {
                Get.toNamed(AppRoute.timeClock);
              },
            ),
          )
        ],
      ),
    );
  }
}

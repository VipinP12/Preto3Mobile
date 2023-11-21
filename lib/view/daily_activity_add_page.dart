import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/components/rounded_button.dart';
import 'package:preto3/controller/daily_activity_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/app_string.dart';

class DailyActivityAddPage extends StatelessWidget {
  DailyActivityAddPage({Key? key}) : super(key: key);

  final dailyController = Get.find<DailyActivityController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColor.appPrimary,
        leading: InkWell(
          onTap: () => Get.back(result: "add"),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
        ),
        centerTitle: false,
        title: Text(
          AppString.addActivity,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: GetBuilder<DailyActivityController>(
                builder: (controller) => Wrap(
                    runSpacing: 16.0,
                    spacing: 20,
                    children: controller.activityTypeList
                        .asMap()
                        .entries
                        .map((item) => InkWell(
                              onTap: () {
                                log("TAPPED:${item.value.title}");
                                item.value.isSelected = !item.value.isSelected;
                                log("TAPPED:${item.value.isSelected}");
                                controller.addActivityIndex(item.key);
                              },
                              child: SizedBox(
                                width: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    item.value.isSelected == true
                                        ? Stack(
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                height: 65,
                                                width: 65,
                                                decoration: BoxDecoration(
                                                    color: AppColor.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            65),
                                                    border: Border.all(
                                                        color: AppColor
                                                            .borderColor)),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      item.value.imageType,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Positioned(
                                                left: 5,
                                                child: SvgPicture.asset(
                                                    AppAssets
                                                        .checkInSelectedIcon),
                                              )
                                            ],
                                          )
                                        : Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            height: 65,
                                            width: 65,
                                            decoration: BoxDecoration(
                                                color: AppColor.white,
                                                borderRadius:
                                                    BorderRadius.circular(65),
                                                border: Border.all(
                                                    color:
                                                        AppColor.borderColor)),
                                            child: CachedNetworkImage(
                                              imageUrl: item.value.imageType,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                    Text(
                                      item.value.title,
                                      style: GoogleFonts.poppins(
                                          color: AppColor.heavyTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ))
                        .toList()),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: RoundedButton(
                  height: 42,
                  width: double.maxFinite,
                  color: AppColor.appPrimary,
                  onClick: () {
                    Get.toNamed(AppRoute.selectStudentForActivity);
                  },
                  text: 'Next',
                  style: GoogleFonts.poppins(
                      color: AppColor.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}

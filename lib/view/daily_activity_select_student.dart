import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/components/rounded_button.dart';
import 'package:preto3/controller/daily_activity_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_dimens.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/app_string.dart';
import 'package:preto3/utils/toast.dart';

import '../model/room_list_model.dart';

class DailyActivitySelectStudent extends StatelessWidget {
  DailyActivitySelectStudent({Key? key}) : super(key: key);

  final dailyController = Get.find<DailyActivityController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColor.appPrimary,
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
        ),
        title: Text(
          AppString.addActivity,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
                height: 45,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: AppColor.disableColor,
                    borderRadius: BorderRadius.circular(10)),
                child: GetBuilder<DailyActivityController>(
                  builder: (controller) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: DropdownButton<RoomListModel?>(
                      //elevation: 5,
                      hint: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppString.selectRoom,
                          style: GoogleFonts.poppins(
                              color: AppColor.lightTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      isExpanded: true,
                      icon: Visibility(
                          visible: true,
                          child: SvgPicture.asset(AppAssets.dropdownIcon)),
                      dropdownColor: AppColor.white,
                      borderRadius: BorderRadius.circular(10),
                      iconEnabledColor: AppColor.appPrimary,
                      underline: Container(),
                      alignment: Alignment.topCenter,
                      items: controller.allRoomList
                          .map((RoomListModel? room) =>
                              DropdownMenuItem<RoomListModel?>(
                                  value: room,
                                  child: Text(
                                    room!.className.toString(),
                                    style: GoogleFonts.poppins(
                                        color: AppColor.heavyTextColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  )))
                          .toList(),
                      onChanged: (changed) {
                        controller.setClassRoom(changed!);
                        log("MY CLASS ROOM:${controller.room}");
                      },
                      value: controller.room,
                    ),
                  ),
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => dailyController.checkList.isNotEmpty
                ? Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          value: dailyController.isSelected.value,
                          checkColor: AppColor.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (changed) {
                            dailyController.isSelected.value = changed!;
                            dailyController.idList.clear();
                            dailyController.profilePicImageList.clear();
                            if (changed) {
                              for (var element in dailyController.checkList) {
                                element.isSelected = changed;
                                dailyController.idList
                                    .add(element.id.toString());
                                dailyController.profilePicImageList
                                    .add(element.profilePic);
                                dailyController.update();
                              }
                            } else {
                              for (var element in dailyController.checkList) {
                                element.isSelected = changed;
                                dailyController.update();
                              }
                            }
                            dailyController.update();
                          },
                        ),
                      ),
                      const Text("Select All"),
                    ],
                  )
                : Container(),
          ),
          const SizedBox(
            height: AppDimens.paddingVertical16,
          ),
          Expanded(
              child: Stack(
            children: [
              GetBuilder<DailyActivityController>(
                builder: (controller) => GridView.builder(
                    padding: const EdgeInsets.only(bottom: 60),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2 / 2,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 20),
                    itemCount: controller.checkList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 8),
                        child: InkWell(
                          onTap: () {
                            controller.checkList[index].isSelected =
                                !controller.checkList[index].isSelected;
                            controller.addStudentIndex(index);
                          },
                          child: Container(
                            height: 120,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 65,
                                  width: 65,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(65),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 6.0,
                                            spreadRadius: 2.0,
                                            offset: Offset(0.0, 0.0))
                                      ]),
                                  child: controller.checkList[index].isSelected
                                      ? Stack(
                                          children: [
                                            ClipOval(
                                              child: CachedNetworkImage(
                                                placeholder: (context, url) =>
                                                    const Image(
                                                  height: 75,
                                                  width: 75,
                                                  image: AssetImage(
                                                    AppAssets.placeHolder,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                                imageUrl:
                                                    '${controller.checkList[index].profilePic}',
                                                fit: BoxFit.cover,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Image(
                                                  height: 75,
                                                  width: 75,
                                                  image: AssetImage(
                                                    AppAssets.placeHolder,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SvgPicture.asset(
                                                AppAssets.checkInSelectedIcon)
                                          ],
                                        )
                                      : ClipOval(
                                          child: CachedNetworkImage(
                                            placeholder: (context, url) =>
                                                const Image(
                                              height: 75,
                                              width: 75,
                                              image: AssetImage(
                                                AppAssets.placeHolder,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            imageUrl:
                                                '${controller.checkList[index].profilePic}',
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Image(
                                              height: 75,
                                              width: 75,
                                              image: AssetImage(
                                                AppAssets.placeHolder,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 4),
                                  child: Center(
                                    child: Text(
                                      controller
                                          .checkList[index].studentFullName
                                          .toString(),
                                      style: GoogleFonts.poppins(
                                          color: AppColor.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Positioned(
                bottom: 8,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20),
                  child: RoundedButton(
                    height: 42,
                    width: double.maxFinite,
                    color: AppColor.appPrimary,
                    text: 'Next',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    onClick: () {
                      if (dailyController.idList.isEmpty) {
                        messageToastWarning(
                            context, "Please select a student.");
                        return;
                      }
                      Get.toNamed(AppRoute.setTimeActivity);
                    },
                  ),
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}

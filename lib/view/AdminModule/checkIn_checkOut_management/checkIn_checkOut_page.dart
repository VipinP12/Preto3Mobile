import 'dart:developer';
import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/checkin_controller.dart';
import 'package:preto3/model/room_list_model.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_dimens.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/app_string.dart';

import '../../../components/rounded_button.dart';
import '../../../controller/Admin/checkin_checkout_management/admin_checkin_checkout_controller.dart';

class CheckInCheckOutPage extends StatelessWidget {
  CheckInCheckOutPage({Key? key}) : super(key: key);

  final checkInCheckOutController = Get.find<CheckInCheckOutController>();
  // final checkInController = Get.find<CheckInController>();

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
        centerTitle: false,
        title: Text(
          AppString.studentCheckIn,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 4.0),
          //   child: Icon(
          //     Icons.search,
          //     color: Colors.white,
          //     size: 24,
          //   ),
          // ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRoute.checkedInList);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SvgPicture.asset(
                AppAssets.checkInListIcon,
                height: 30,
                width: 30,
              ),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            tabs: checkInCheckOutController.myTabs,
            controller: checkInCheckOutController.tabController,
            labelColor: AppColor.appPrimary,
            indicatorColor: AppColor.appPrimary,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Expanded(
              child: TabBarView(
                  controller: checkInCheckOutController.tabController,
                  children: checkInCheckOutController.myTabs
                      .map((Tab tab) => tab.text == AppString.tabCheckInOutStudent
                      ? Obx(() =>
                  checkInCheckOutController.allRoomList.isNotEmpty ?
                  Column(
                    children: [
                        SizedBox(
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
                            child:
                            GetBuilder<CheckInCheckOutController>(
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
                                      child:
                                      SvgPicture.asset(AppAssets.dropdownIcon)),
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
                            )
                        ),
                      ),
                        const SizedBox(
                        height: 10,
                      ),
                        checkInCheckOutController.checkList.isNotEmpty
                          ? Row(
                        children: [
                          Obx(
                                () => Checkbox(
                              value: checkInCheckOutController.isSelected.value,
                              checkColor: AppColor.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              onChanged: (changed) {
                                for (var element
                                in checkInCheckOutController.checkList) {
                                  element.isSelected = false;
                                  checkInCheckOutController.idList.remove(element.id);
                                  if (element.status == "Absent") {
                                    if (checkInCheckOutController.idList.isEmpty) {
                                      checkInCheckOutController
                                          .isEnableCheckInButton.value = false;
                                      checkInCheckOutController
                                          .isEnableCheckOutButton.value = false;
                                    }
                                  } else if (element.status == "Checked in") {
                                    if (checkInCheckOutController.idList.isEmpty) {
                                      checkInCheckOutController
                                          .isEnableCheckInButton.value = false;
                                      checkInCheckOutController
                                          .isEnableCheckOutButton.value = false;
                                    }
                                  } else {
                                    null;
                                  }
                                }
                                checkInCheckOutController.isSelected.value = changed!;
                                if (changed) {
                                  print(checkInCheckOutController.isSelected.value);
                                  checkInCheckOutController.idList.value = [];
                                  for (var element
                                  in checkInCheckOutController.checkList) {
                                    if (element.status == "Absent") {
                                      element.isSelected = changed;
                                      checkInCheckOutController.idList.add(element.id);
                                      if (element.status == "Absent") {
                                        if (checkInCheckOutController
                                            .idList.isNotEmpty) {
                                          checkInCheckOutController
                                              .isEnableCheckInButton
                                              .value = true;
                                          checkInCheckOutController
                                              .isEnableCheckOutButton
                                              .value = false;
                                        }
                                      } else if (element.status ==
                                          "Checked in") {
                                        if (checkInCheckOutController
                                            .idList.isNotEmpty) {
                                          checkInCheckOutController
                                              .isEnableCheckInButton
                                              .value = false;
                                          checkInCheckOutController
                                              .isEnableCheckOutButton
                                              .value = true;
                                        }
                                      } else {
                                        null;
                                      }
                                    }
                                    checkInCheckOutController.update();
                                  }
                                } else {
                                  for (var element
                                  in checkInCheckOutController.checkList) {
                                    if (element.status == "Absent") {
                                      element.isSelected = changed;

                                      checkInCheckOutController.idList
                                          .remove(element.id);
                                      if (element.status == "Absent") {
                                        if (checkInCheckOutController.idList.isEmpty) {
                                          checkInCheckOutController
                                              .isEnableCheckInButton
                                              .value = false;
                                          checkInCheckOutController
                                              .isEnableCheckOutButton
                                              .value = false;
                                        }
                                      } else if (element.status ==
                                          "Checked in") {
                                        if (checkInCheckOutController.idList.isEmpty) {
                                          checkInCheckOutController
                                              .isEnableCheckInButton
                                              .value = false;
                                          checkInCheckOutController
                                              .isEnableCheckOutButton
                                              .value = false;
                                        }
                                      } else {
                                        null;
                                      }
                                    }
                                  }
                                }
                                if (checkInCheckOutController.idList.isEmpty) {
                                  checkInCheckOutController
                                      .isEnableCheckInButton.value = false;
                                  checkInCheckOutController
                                      .isEnableCheckOutButton.value = false;
                                  checkInCheckOutController.update();
                                }
                                checkInCheckOutController.update();
                              },
                            ),
                          ),
                          const Text("Select All"),
                        ],
                      )
                          : Container(),
                      const SizedBox(
                        height: AppDimens.paddingVertical16,
                      ),
                      checkInCheckOutController.noContentFound.value == true
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: SvgPicture.asset(AppAssets.notFoundIcon),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(
                              child: Text(
                                "No Content",
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      )
                          : Expanded(
                          child: Stack(
                            children: [
                              GetBuilder<CheckInCheckOutController>(
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
                                            if (controller.idList.isNotEmpty) {
                                              print(controller.idList.length);
                                              final arrayIndex = controller
                                                  .checkList.value
                                                  .indexWhere((element) =>
                                              element.id ==
                                                  controller.idList[0]);
                                              if (controller
                                                  .checkList[index].status !=
                                                  controller.checkList[arrayIndex]
                                                      .status) {
                                                return;
                                              }
                                            }
                                            controller.checkList[index].status ==
                                                "Checked in"
                                                ? {
                                              controller.checkList[index]
                                                  .isSelected =
                                              !controller.checkList[index]
                                                  .isSelected,
                                              if (controller.checkList[index]
                                                  .isSelected ==
                                                  true &&
                                                  controller.checkList[index]
                                                      .status ==
                                                      "Checked in")
                                                {
                                                  controller
                                                      .isEnableCheckInButton
                                                      .value = false,
                                                  controller.idList.add(
                                                      controller
                                                          .checkList[index]
                                                          .id),
                                                  controller
                                                      .isEnableCheckOutButton
                                                      .value = true,
                                                  controller.update(),
                                                }
                                              else
                                                {
                                                  controller.checkList[index]
                                                      .isSelected = false,
                                                  controller.idList.remove(
                                                      controller
                                                          .checkList[index]
                                                          .id),
                                                  controller
                                                      .isEnableCheckInButton
                                                      .value = false,
                                                  controller
                                                      .isEnableCheckOutButton
                                                      .value = true,
                                                  controller.update(),
                                                },
                                            }
                                                : controller.checkList[index]
                                                .status ==
                                                "Absent"
                                                ? {
                                              controller.checkList[index]
                                                  .isSelected =
                                              !controller
                                                  .checkList[index]
                                                  .isSelected,
                                              if (controller
                                                  .checkList[
                                              index]
                                                  .isSelected ==
                                                  true &&
                                                  controller
                                                      .checkList[
                                                  index]
                                                      .status ==
                                                      "Absent")
                                                {
                                                  controller.idList.add(
                                                      controller
                                                          .checkList[
                                                      index]
                                                          .id),
                                                  controller
                                                      .isEnableCheckInButton
                                                      .value = true,
                                                  controller
                                                      .isEnableCheckOutButton
                                                      .value = false,
                                                  controller.update(),
                                                }
                                              else
                                                {
                                                  controller
                                                      .checkList[index]
                                                      .isSelected = false,
                                                  controller.idList
                                                      .remove(controller
                                                      .checkList[
                                                  index]
                                                      .id),
                                                  controller
                                                      .isEnableCheckInButton
                                                      .value = true,
                                                  controller
                                                      .isEnableCheckOutButton
                                                      .value = false,
                                                  controller.update(),
                                                },
                                            }
                                                : {
                                              null,
                                            };
                                            if (controller.idList.isEmpty) {
                                              controller.isEnableCheckInButton
                                                  .value = false;
                                              controller.isEnableCheckOutButton
                                                  .value = false;
                                              controller.update();
                                            }
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: 120,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 60,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              60),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                                color:
                                                                Colors.black26,
                                                                blurRadius: 6.0,
                                                                spreadRadius: 2.0,
                                                                offset: Offset(
                                                                    0.0, 0.0))
                                                          ]),
                                                      child: controller
                                                          .checkList[index]
                                                          .isSelected
                                                          ? Stack(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                60),
                                                            child:
                                                            CachedNetworkImage(
                                                              placeholder: (context,
                                                                  url) =>
                                                              const Image(
                                                                height: 60,
                                                                width: 60,
                                                                image:
                                                                AssetImage(
                                                                  AppAssets
                                                                      .placeHolder,
                                                                ),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                              imageUrl:
                                                              '${controller.checkList[index].profilePic}',
                                                              fit:
                                                              BoxFit.fill,
                                                              errorWidget: (context,
                                                                  url,
                                                                  error) =>
                                                              const Image(
                                                                height: 75,
                                                                width: 75,
                                                                image:
                                                                AssetImage(
                                                                  AppAssets
                                                                      .placeHolder,
                                                                ),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          SvgPicture.asset(
                                                              AppAssets
                                                                  .checkInSelectedIcon)
                                                        ],
                                                      )
                                                          : const Image(
                                                        image: AssetImage(
                                                            AppAssets
                                                                .placeHolder),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 0.0,
                                                          horizontal: 4),
                                                      child: Center(
                                                        child: Text(
                                                          '${controller.checkList[index].firstName.toString()} ${controller.checkList[index].lastName.toString()} ',
                                                          style:
                                                          GoogleFonts.poppins(
                                                              color: AppColor
                                                                  .black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500),
                                                          textAlign:
                                                          TextAlign.center,
                                                          overflow:
                                                          TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                  bottom: 45,
                                                  right: 35,
                                                  child: Container(
                                                    height: 15,
                                                    width: 15,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                        color: controller
                                                            .checkList[
                                                        index]
                                                            .status ==
                                                            "Checked in"
                                                            ? Colors.green
                                                            : controller
                                                            .checkList[
                                                        index]
                                                            .status ==
                                                            "Checked out"
                                                            ? Colors.grey
                                                            : Colors.red,
                                                        border: Border.all(
                                                            color: AppColor.white,
                                                            width: 1.5)),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 0,
                                right: 0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 20),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Obx(
                                            () => Flexible(
                                          flex: 1,
                                          child: RoundedButton(
                                            height: 42,
                                            width: double.maxFinite,
                                            color: checkInCheckOutController
                                                .isEnableCheckInButton.value
                                                ? AppColor.appPrimary
                                                : AppColor.disableColor,
                                            text: 'Check In',
                                            style: GoogleFonts.poppins(
                                                color: checkInCheckOutController
                                                    .isEnableCheckInButton.value
                                                    ? Colors.white
                                                    : AppColor.disableTextColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                            onClick: () {
                                              checkInCheckOutController
                                                  .isEnableCheckInButton.value
                                                  ? checkInCheckOutController
                                                  .checkInSession()
                                                  : null;
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Obx(
                                            () => Flexible(
                                          flex: 1,
                                          child: RoundedButton(
                                            height: 42,
                                            width: double.maxFinite,
                                            color: checkInCheckOutController
                                                .isEnableCheckOutButton.value
                                                ? AppColor.appPrimary
                                                : AppColor.disableColor,
                                            text: 'Check out',
                                            style: GoogleFonts.poppins(
                                                color: checkInCheckOutController
                                                    .isEnableCheckOutButton
                                                    .value
                                                    ? AppColor.white
                                                    : AppColor.disableTextColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                            onClick: () {
                                              checkInCheckOutController
                                                  .isEnableCheckOutButton.value
                                                  ? checkInCheckOutController
                                                  .checkOutSession()
                                                  : null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                    ],
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: SvgPicture.asset(AppAssets.notFoundIcon),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(
                          child: Text(
                            "There are no rooms found in the institute",
                            style: GoogleFonts.poppins(
                                color: AppColor.heavyTextColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ))
                      :  Obx(() =>
                  checkInCheckOutController.allStaffRoomList.isNotEmpty ?
                  Column(
                    children: [
                      SizedBox(
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
                            child:
                            GetBuilder<CheckInCheckOutController>(
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
                                      child:
                                      SvgPicture.asset(AppAssets.dropdownIcon)),
                                  dropdownColor: AppColor.white,
                                  borderRadius: BorderRadius.circular(10),
                                  iconEnabledColor: AppColor.appPrimary,
                                  underline: Container(),
                                  alignment: Alignment.topCenter,
                                  items: controller.allStaffRoomList
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
                                    controller.setClassStaffRoom(changed!);
                                    log("MY CLASS ROOM Staff:${controller.staffRoom}");
                                  },
                                  value: controller.staffRoom,
                                ),
                              ),
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      checkInCheckOutController.checkStaffList.isNotEmpty
                          ? Row(
                        children: [
                          Obx(
                                () => Checkbox(
                              value: checkInCheckOutController.isSelectedStaff.value,
                              checkColor: AppColor.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              onChanged: (changed) {
                                for (var element
                                in checkInCheckOutController.checkStaffList) {
                                  element.isSelectedStaff = false;
                                  checkInCheckOutController.idList.remove(element.id);
                                  if (element.status == "Absent") {
                                    if (checkInCheckOutController.idList.isEmpty) {
                                      checkInCheckOutController
                                          .isEnableCheckInButton.value = false;
                                      checkInCheckOutController
                                          .isEnableCheckOutButton.value = false;
                                    }
                                  } else if (element.status == "Checked in") {
                                    if (checkInCheckOutController.idList.isEmpty) {
                                      checkInCheckOutController
                                          .isEnableCheckInButton.value = false;
                                      checkInCheckOutController
                                          .isEnableCheckOutButton.value = false;
                                    }
                                  } else {
                                    null;
                                  }
                                }
                                checkInCheckOutController.isSelectedStaff.value = changed!;
                                if (changed) {
                                  print(checkInCheckOutController.isSelectedStaff.value);
                                  checkInCheckOutController.idList.value = [];
                                  for (var element
                                  in checkInCheckOutController.checkStaffList) {
                                    if (element.status == "Absent") {
                                      element.isSelectedStaff = changed;
                                      checkInCheckOutController.idList.add(element.id);
                                      if (element.status == "Absent") {
                                        if (checkInCheckOutController
                                            .idList.isNotEmpty) {
                                          checkInCheckOutController
                                              .isEnableCheckInButton
                                              .value = true;
                                          checkInCheckOutController
                                              .isEnableCheckOutButton
                                              .value = false;
                                        }
                                      } else if (element.status ==
                                          "Checked in") {
                                        if (checkInCheckOutController
                                            .idList.isNotEmpty) {
                                          checkInCheckOutController
                                              .isEnableCheckInButton
                                              .value = false;
                                          checkInCheckOutController
                                              .isEnableCheckOutButton
                                              .value = true;
                                        }
                                      } else {
                                        null;
                                      }
                                    }
                                    checkInCheckOutController.update();
                                  }
                                } else {
                                  for (var element
                                  in checkInCheckOutController.checkStaffList) {
                                    if (element.status == "Absent") {
                                      element.isSelectedStaff = changed;

                                      checkInCheckOutController.idList
                                          .remove(element.id);
                                      if (element.status == "Absent") {
                                        if (checkInCheckOutController.idList.isEmpty) {
                                          checkInCheckOutController
                                              .isEnableCheckInButton
                                              .value = false;
                                          checkInCheckOutController
                                              .isEnableCheckOutButton
                                              .value = false;
                                        }
                                      } else if (element.status ==
                                          "Checked in") {
                                        if (checkInCheckOutController.idList.isEmpty) {
                                          checkInCheckOutController
                                              .isEnableCheckInButton
                                              .value = false;
                                          checkInCheckOutController
                                              .isEnableCheckOutButton
                                              .value = false;
                                        }
                                      } else {
                                        null;
                                      }
                                    }
                                  }
                                }
                                if (checkInCheckOutController.idList.isEmpty) {
                                  checkInCheckOutController
                                      .isEnableCheckInButton.value = false;
                                  checkInCheckOutController
                                      .isEnableCheckOutButton.value = false;
                                  checkInCheckOutController.update();
                                }
                                checkInCheckOutController.update();
                              },
                            ),
                          ),
                          const Text("Select All"),
                        ],
                      )
                          : Container(),
                      const SizedBox(
                        height: AppDimens.paddingVertical16,
                      ),
                      checkInCheckOutController.noContentFound.value == true
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: SvgPicture.asset(AppAssets.notFoundIcon),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(
                              child: Text(
                                "No Content",
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      )
                          : Expanded(
                          child: Stack(
                            children: [
                              GetBuilder<CheckInCheckOutController>(
                                builder: (controller) => GridView.builder(
                                    padding: const EdgeInsets.only(bottom: 60),
                                    shrinkWrap: true,
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 2 / 2,
                                        crossAxisSpacing: 4,
                                        mainAxisSpacing: 20),
                                    itemCount: controller.checkStaffList.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0.0, horizontal: 8),
                                        child: InkWell(
                                          onTap: () {
                                            if (controller.idList.isNotEmpty) {
                                              print(controller.idList.length);
                                              final arrayIndex = controller
                                                  .checkStaffList.value
                                                  .indexWhere((element) =>
                                              element.id ==
                                                  controller.idList[0]);
                                              if (controller
                                                  .checkStaffList[index].status !=
                                                  controller.checkStaffList[arrayIndex]
                                                      .status) {
                                                return;
                                              }
                                            }
                                            controller.checkStaffList[index].status ==
                                                "Checked in"
                                                ? {
                                              controller.checkStaffList[index]
                                                  .isSelectedStaff =
                                              !controller.checkStaffList[index]
                                                  .isSelectedStaff,
                                              if (controller.checkStaffList[index]
                                                  .isSelectedStaff ==
                                                  true &&
                                                  controller.checkStaffList[index]
                                                      .status ==
                                                      "Checked in")
                                                {
                                                  controller
                                                      .isEnableCheckInButton
                                                      .value = false,
                                                  controller.idList.add(
                                                      controller
                                                          .checkStaffList[index]
                                                          .id),
                                                  controller
                                                      .isEnableCheckOutButton
                                                      .value = true,
                                                  controller.update(),
                                                }
                                              else
                                                {
                                                  controller.checkStaffList[index]
                                                      .isSelectedStaff = false,
                                                  controller.idList.remove(
                                                      controller
                                                          .checkStaffList[index]
                                                          .id),
                                                  controller
                                                      .isEnableCheckInButton
                                                      .value = false,
                                                  controller
                                                      .isEnableCheckOutButton
                                                      .value = true,
                                                  controller.update(),
                                                },
                                            }
                                                : controller.checkStaffList[index]
                                                .status ==
                                                "Absent"
                                                ? {
                                              controller.checkStaffList[index]
                                                  .isSelectedStaff =
                                              !controller
                                                  .checkStaffList[index]
                                                  .isSelectedStaff,
                                              if (controller
                                                  .checkStaffList[
                                              index]
                                                  .isSelectedStaff ==
                                                  true &&
                                                  controller
                                                      .checkStaffList[
                                                  index]
                                                      .status ==
                                                      "Absent")
                                                {
                                                  controller.idList.add(
                                                      controller
                                                          .checkStaffList[
                                                      index]
                                                          .id),
                                                  controller
                                                      .isEnableCheckInButton
                                                      .value = true,
                                                  controller
                                                      .isEnableCheckOutButton
                                                      .value = false,
                                                  controller.update(),
                                                }
                                              else
                                                {
                                                  controller
                                                      .checkStaffList[index]
                                                      .isSelectedStaff = false,
                                                  controller.idList
                                                      .remove(controller
                                                      .checkStaffList[
                                                  index]
                                                      .id),
                                                  controller
                                                      .isEnableCheckInButton
                                                      .value = true,
                                                  controller
                                                      .isEnableCheckOutButton
                                                      .value = false,
                                                  controller.update(),
                                                },
                                            }
                                                : {
                                              null,
                                            };
                                            if (controller.idList.isEmpty) {
                                              controller.isEnableCheckInButton
                                                  .value = false;
                                              controller.isEnableCheckOutButton
                                                  .value = false;
                                              controller.update();
                                            }
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: 120,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 60,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              60),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                                color:
                                                                Colors.black26,
                                                                blurRadius: 6.0,
                                                                spreadRadius: 2.0,
                                                                offset: Offset(
                                                                    0.0, 0.0))
                                                          ]),
                                                      child: controller
                                                          .checkStaffList[index]
                                                          .isSelectedStaff
                                                          ? Stack(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                60),
                                                            child:
                                                            CachedNetworkImage(
                                                              placeholder: (context,
                                                                  url) =>
                                                              const Image(
                                                                height: 60,
                                                                width: 60,
                                                                image:
                                                                AssetImage(
                                                                  AppAssets
                                                                      .placeHolder,
                                                                ),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                              imageUrl:
                                                              '${controller.checkStaffList[index].profilePic}',
                                                              fit:
                                                              BoxFit.fill,
                                                              errorWidget: (context,
                                                                  url,
                                                                  error) =>
                                                              const Image(
                                                                height: 75,
                                                                width: 75,
                                                                image:
                                                                AssetImage(
                                                                  AppAssets
                                                                      .placeHolder,
                                                                ),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          SvgPicture.asset(
                                                              AppAssets
                                                                  .checkInSelectedIcon)
                                                        ],
                                                      )
                                                          : const Image(
                                                        image: AssetImage(
                                                            AppAssets
                                                                .placeHolder),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 0.0,
                                                          horizontal: 4),
                                                      child: Center(
                                                        child: Text(
                                                          '${controller.checkStaffList[index].firstName.toString()} ${controller.checkStaffList[index].lastName.toString()} ',
                                                          style:
                                                          GoogleFonts.poppins(
                                                              color: AppColor
                                                                  .black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500),
                                                          textAlign:
                                                          TextAlign.center,
                                                          overflow:
                                                          TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                  bottom: 45,
                                                  right: 35,
                                                  child: Container(
                                                    height: 15,
                                                    width: 15,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                        color: controller
                                                            .checkStaffList[
                                                        index]
                                                            .status ==
                                                            "Checked in"
                                                            ? Colors.green
                                                            : controller
                                                            .checkStaffList[
                                                        index]
                                                            .status ==
                                                            "Checked out"
                                                            ? Colors.grey
                                                            : Colors.red,
                                                        border: Border.all(
                                                            color: AppColor.white,
                                                            width: 1.5)),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 0,
                                right: 0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 20),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Obx(
                                            () => Flexible(
                                          flex: 1,
                                          child: RoundedButton(
                                            height: 42,
                                            width: double.maxFinite,
                                            color: checkInCheckOutController
                                                .isEnableCheckInButton.value
                                                ? AppColor.appPrimary
                                                : AppColor.disableColor,
                                            text: 'Check In',
                                            style: GoogleFonts.poppins(
                                                color: checkInCheckOutController
                                                    .isEnableCheckInButton.value
                                                    ? Colors.white
                                                    : AppColor.disableTextColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                            onClick: () {
                                              checkInCheckOutController
                                                  .isEnableCheckInButton.value
                                                  ? checkInCheckOutController
                                                  .checkInSession()
                                                  : null;
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Obx(
                                            () => Flexible(
                                          flex: 1,
                                          child: RoundedButton(
                                            height: 42,
                                            width: double.maxFinite,
                                            color: checkInCheckOutController
                                                .isEnableCheckOutButton.value
                                                ? AppColor.appPrimary
                                                : AppColor.disableColor,
                                            text: 'Check out',
                                            style: GoogleFonts.poppins(
                                                color: checkInCheckOutController
                                                    .isEnableCheckOutButton
                                                    .value
                                                    ? AppColor.white
                                                    : AppColor.disableTextColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                            onClick: () {
                                              checkInCheckOutController
                                                  .isEnableCheckOutButton.value
                                                  ? checkInCheckOutController
                                                  .checkOutSession()
                                                  : null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                    ],
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: SvgPicture.asset(AppAssets.notFoundIcon),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(
                          child: Text(
                            "There are no rooms found in the institute",
                            style: GoogleFonts.poppins(
                                color: AppColor.heavyTextColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ))
                  )
                      .toList()))
        ],
      )
      // Obx(() =>
      // checkInCheckOutController.allRoomList.isNotEmpty ?
      // Column(
      //   children: [
      //       SizedBox(
      //       height: 20,
      //     ),
      //       Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //       child: Container(
      //           height: 45,
      //           width: double.maxFinite,
      //           decoration: BoxDecoration(
      //               color: AppColor.disableColor,
      //               borderRadius: BorderRadius.circular(10)),
      //           child:
      //           GetBuilder<CheckInCheckOutController>(
      //             builder: (controller) => Padding(
      //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //               child: DropdownButton<RoomListModel?>(
      //                 //elevation: 5,
      //                 hint: Align(
      //                   alignment: Alignment.centerLeft,
      //                   child: Text(
      //                     AppString.selectRoom,
      //                     style: GoogleFonts.poppins(
      //                         color: AppColor.lightTextColor,
      //                         fontSize: 14,
      //                         fontWeight: FontWeight.w400),
      //                   ),
      //                 ),
      //                 isExpanded: true,
      //                 icon: Visibility(
      //                     visible: true,
      //                     child:
      //                     SvgPicture.asset(AppAssets.dropdownIcon)),
      //                 dropdownColor: AppColor.white,
      //                 borderRadius: BorderRadius.circular(10),
      //                 iconEnabledColor: AppColor.appPrimary,
      //                 underline: Container(),
      //                 alignment: Alignment.topCenter,
      //                 items: controller.allRoomList
      //                     .map((RoomListModel? room) =>
      //                     DropdownMenuItem<RoomListModel?>(
      //                         value: room,
      //                         child: Text(
      //                           room!.className.toString(),
      //                           style: GoogleFonts.poppins(
      //                               color: AppColor.heavyTextColor,
      //                               fontSize: 14,
      //                               fontWeight: FontWeight.w400),
      //                         )))
      //                     .toList(),
      //                 onChanged: (changed) {
      //                   controller.setClassRoom(changed!);
      //                   log("MY CLASS ROOM:${controller.room}");
      //                 },
      //                 value: controller.room,
      //               ),
      //             ),
      //           )
      //       ),
      //     ),
      //       const SizedBox(
      //       height: 10,
      //     ),
      //       checkInCheckOutController.checkList.isNotEmpty
      //         ? Row(
      //       children: [
      //         Obx(
      //               () => Checkbox(
      //             value: checkInCheckOutController.isSelected.value,
      //             checkColor: AppColor.white,
      //             shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(4)),
      //             onChanged: (changed) {
      //               for (var element
      //               in checkInCheckOutController.checkList) {
      //                 element.isSelected = false;
      //                 checkInCheckOutController.idList.remove(element.id);
      //                 if (element.status == "Absent") {
      //                   if (checkInCheckOutController.idList.isEmpty) {
      //                     checkInCheckOutController
      //                         .isEnableCheckInButton.value = false;
      //                     checkInCheckOutController
      //                         .isEnableCheckOutButton.value = false;
      //                   }
      //                 } else if (element.status == "Checked in") {
      //                   if (checkInCheckOutController.idList.isEmpty) {
      //                     checkInCheckOutController
      //                         .isEnableCheckInButton.value = false;
      //                     checkInCheckOutController
      //                         .isEnableCheckOutButton.value = false;
      //                   }
      //                 } else {
      //                   null;
      //                 }
      //               }
      //               checkInCheckOutController.isSelected.value = changed!;
      //               if (changed) {
      //                 print(checkInCheckOutController.isSelected.value);
      //                 checkInCheckOutController.idList.value = [];
      //                 for (var element
      //                 in checkInCheckOutController.checkList) {
      //                   if (element.status == "Absent") {
      //                     element.isSelected = changed;
      //                     checkInCheckOutController.idList.add(element.id);
      //                     if (element.status == "Absent") {
      //                       if (checkInCheckOutController
      //                           .idList.isNotEmpty) {
      //                         checkInCheckOutController
      //                             .isEnableCheckInButton
      //                             .value = true;
      //                         checkInCheckOutController
      //                             .isEnableCheckOutButton
      //                             .value = false;
      //                       }
      //                     } else if (element.status ==
      //                         "Checked in") {
      //                       if (checkInCheckOutController
      //                           .idList.isNotEmpty) {
      //                         checkInCheckOutController
      //                             .isEnableCheckInButton
      //                             .value = false;
      //                         checkInCheckOutController
      //                             .isEnableCheckOutButton
      //                             .value = true;
      //                       }
      //                     } else {
      //                       null;
      //                     }
      //                   }
      //                   checkInCheckOutController.update();
      //                 }
      //               } else {
      //                 for (var element
      //                 in checkInCheckOutController.checkList) {
      //                   if (element.status == "Absent") {
      //                     element.isSelected = changed;
      //
      //                     checkInCheckOutController.idList
      //                         .remove(element.id);
      //                     if (element.status == "Absent") {
      //                       if (checkInCheckOutController.idList.isEmpty) {
      //                         checkInCheckOutController
      //                             .isEnableCheckInButton
      //                             .value = false;
      //                         checkInCheckOutController
      //                             .isEnableCheckOutButton
      //                             .value = false;
      //                       }
      //                     } else if (element.status ==
      //                         "Checked in") {
      //                       if (checkInCheckOutController.idList.isEmpty) {
      //                         checkInCheckOutController
      //                             .isEnableCheckInButton
      //                             .value = false;
      //                         checkInCheckOutController
      //                             .isEnableCheckOutButton
      //                             .value = false;
      //                       }
      //                     } else {
      //                       null;
      //                     }
      //                   }
      //                 }
      //               }
      //               if (checkInCheckOutController.idList.isEmpty) {
      //                 checkInCheckOutController
      //                     .isEnableCheckInButton.value = false;
      //                 checkInCheckOutController
      //                     .isEnableCheckOutButton.value = false;
      //                 checkInCheckOutController.update();
      //               }
      //               checkInCheckOutController.update();
      //             },
      //           ),
      //         ),
      //         const Text("Select All"),
      //       ],
      //     )
      //         : Container(),
      //     const SizedBox(
      //       height: AppDimens.paddingVertical16,
      //     ),
      //     checkInCheckOutController.noContentFound.value == true
      //         ? Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Center(
      //           child: SvgPicture.asset(AppAssets.notFoundIcon),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.symmetric(vertical: 16.0),
      //           child: Center(
      //             child: Text(
      //               "No Content",
      //               style: GoogleFonts.poppins(
      //                   color: AppColor.heavyTextColor,
      //                   fontWeight: FontWeight.w600,
      //                   fontSize: 16),
      //             ),
      //           ),
      //         ),
      //       ],
      //     )
      //         : Expanded(
      //         child: Stack(
      //           children: [
      //             GetBuilder<CheckInCheckOutController>(
      //               builder: (controller) => GridView.builder(
      //                   padding: const EdgeInsets.only(bottom: 60),
      //                   shrinkWrap: true,
      //                   gridDelegate:
      //                   const SliverGridDelegateWithFixedCrossAxisCount(
      //                       crossAxisCount: 3,
      //                       childAspectRatio: 2 / 2,
      //                       crossAxisSpacing: 4,
      //                       mainAxisSpacing: 20),
      //                   itemCount: controller.checkList.length,
      //                   itemBuilder: (context, index) {
      //                     return Padding(
      //                       padding: const EdgeInsets.symmetric(
      //                           vertical: 0.0, horizontal: 8),
      //                       child: InkWell(
      //                         onTap: () {
      //                           if (controller.idList.isNotEmpty) {
      //                             print(controller.idList.length);
      //                             final arrayIndex = controller
      //                                 .checkList.value
      //                                 .indexWhere((element) =>
      //                             element.id ==
      //                                 controller.idList[0]);
      //                             if (controller
      //                                 .checkList[index].status !=
      //                                 controller.checkList[arrayIndex]
      //                                     .status) {
      //                               return;
      //                             }
      //                           }
      //                           controller.checkList[index].status ==
      //                               "Checked in"
      //                               ? {
      //                             controller.checkList[index]
      //                                 .isSelected =
      //                             !controller.checkList[index]
      //                                 .isSelected,
      //                             if (controller.checkList[index]
      //                                 .isSelected ==
      //                                 true &&
      //                                 controller.checkList[index]
      //                                     .status ==
      //                                     "Checked in")
      //                               {
      //                                 controller
      //                                     .isEnableCheckInButton
      //                                     .value = false,
      //                                 controller.idList.add(
      //                                     controller
      //                                         .checkList[index]
      //                                         .id),
      //                                 controller
      //                                     .isEnableCheckOutButton
      //                                     .value = true,
      //                                 controller.update(),
      //                               }
      //                             else
      //                               {
      //                                 controller.checkList[index]
      //                                     .isSelected = false,
      //                                 controller.idList.remove(
      //                                     controller
      //                                         .checkList[index]
      //                                         .id),
      //                                 controller
      //                                     .isEnableCheckInButton
      //                                     .value = false,
      //                                 controller
      //                                     .isEnableCheckOutButton
      //                                     .value = true,
      //                                 controller.update(),
      //                               },
      //                           }
      //                               : controller.checkList[index]
      //                               .status ==
      //                               "Absent"
      //                               ? {
      //                             controller.checkList[index]
      //                                 .isSelected =
      //                             !controller
      //                                 .checkList[index]
      //                                 .isSelected,
      //                             if (controller
      //                                 .checkList[
      //                             index]
      //                                 .isSelected ==
      //                                 true &&
      //                                 controller
      //                                     .checkList[
      //                                 index]
      //                                     .status ==
      //                                     "Absent")
      //                               {
      //                                 controller.idList.add(
      //                                     controller
      //                                         .checkList[
      //                                     index]
      //                                         .id),
      //                                 controller
      //                                     .isEnableCheckInButton
      //                                     .value = true,
      //                                 controller
      //                                     .isEnableCheckOutButton
      //                                     .value = false,
      //                                 controller.update(),
      //                               }
      //                             else
      //                               {
      //                                 controller
      //                                     .checkList[index]
      //                                     .isSelected = false,
      //                                 controller.idList
      //                                     .remove(controller
      //                                     .checkList[
      //                                 index]
      //                                     .id),
      //                                 controller
      //                                     .isEnableCheckInButton
      //                                     .value = true,
      //                                 controller
      //                                     .isEnableCheckOutButton
      //                                     .value = false,
      //                                 controller.update(),
      //                               },
      //                           }
      //                               : {
      //                             null,
      //                           };
      //                           if (controller.idList.isEmpty) {
      //                             controller.isEnableCheckInButton
      //                                 .value = false;
      //                             controller.isEnableCheckOutButton
      //                                 .value = false;
      //                             controller.update();
      //                           }
      //                         },
      //                         child: Stack(
      //                           children: [
      //                             Container(
      //                               height: 120,
      //                               width: 80,
      //                               decoration: BoxDecoration(
      //                                 color: Colors.white,
      //                                 borderRadius:
      //                                 BorderRadius.circular(10),
      //                               ),
      //                               child: Column(
      //                                 mainAxisAlignment:
      //                                 MainAxisAlignment.center,
      //                                 crossAxisAlignment:
      //                                 CrossAxisAlignment.center,
      //                                 children: [
      //                                   Container(
      //                                     height: 60,
      //                                     width: 60,
      //                                     decoration: BoxDecoration(
      //                                         color: Colors.white,
      //                                         borderRadius:
      //                                         BorderRadius.circular(
      //                                             60),
      //                                         boxShadow: const [
      //                                           BoxShadow(
      //                                               color:
      //                                               Colors.black26,
      //                                               blurRadius: 6.0,
      //                                               spreadRadius: 2.0,
      //                                               offset: Offset(
      //                                                   0.0, 0.0))
      //                                         ]),
      //                                     child: controller
      //                                         .checkList[index]
      //                                         .isSelected
      //                                         ? Stack(
      //                                       children: [
      //                                         ClipRRect(
      //                                           borderRadius:
      //                                           BorderRadius
      //                                               .circular(
      //                                               60),
      //                                           child:
      //                                           CachedNetworkImage(
      //                                             placeholder: (context,
      //                                                 url) =>
      //                                             const Image(
      //                                               height: 60,
      //                                               width: 60,
      //                                               image:
      //                                               AssetImage(
      //                                                 AppAssets
      //                                                     .placeHolder,
      //                                               ),
      //                                               fit: BoxFit
      //                                                   .cover,
      //                                             ),
      //                                             imageUrl:
      //                                             '${controller.checkList[index].profilePic}',
      //                                             fit:
      //                                             BoxFit.fill,
      //                                             errorWidget: (context,
      //                                                 url,
      //                                                 error) =>
      //                                             const Image(
      //                                               height: 75,
      //                                               width: 75,
      //                                               image:
      //                                               AssetImage(
      //                                                 AppAssets
      //                                                     .placeHolder,
      //                                               ),
      //                                               fit: BoxFit
      //                                                   .cover,
      //                                             ),
      //                                           ),
      //                                         ),
      //                                         SvgPicture.asset(
      //                                             AppAssets
      //                                                 .checkInSelectedIcon)
      //                                       ],
      //                                     )
      //                                         : const Image(
      //                                       image: AssetImage(
      //                                           AppAssets
      //                                               .placeHolder),
      //                                       fit: BoxFit.cover,
      //                                     ),
      //                                   ),
      //                                   Padding(
      //                                     padding: const EdgeInsets
      //                                         .symmetric(
      //                                         vertical: 0.0,
      //                                         horizontal: 4),
      //                                     child: Center(
      //                                       child: Text(
      //                                         '${controller.checkList[index].firstName.toString()} ${controller.checkList[index].lastName.toString()} ',
      //                                         style:
      //                                         GoogleFonts.poppins(
      //                                             color: AppColor
      //                                                 .black,
      //                                             fontSize: 14,
      //                                             fontWeight:
      //                                             FontWeight
      //                                                 .w500),
      //                                         textAlign:
      //                                         TextAlign.center,
      //                                         overflow:
      //                                         TextOverflow.ellipsis,
      //                                         maxLines: 2,
      //                                       ),
      //                                     ),
      //                                   ),
      //                                 ],
      //                               ),
      //                             ),
      //                             Positioned(
      //                                 bottom: 45,
      //                                 right: 35,
      //                                 child: Container(
      //                                   height: 15,
      //                                   width: 15,
      //                                   decoration: BoxDecoration(
      //                                       borderRadius:
      //                                       BorderRadius.circular(
      //                                           15),
      //                                       color: controller
      //                                           .checkList[
      //                                       index]
      //                                           .status ==
      //                                           "Checked in"
      //                                           ? Colors.green
      //                                           : controller
      //                                           .checkList[
      //                                       index]
      //                                           .status ==
      //                                           "Checked out"
      //                                           ? Colors.grey
      //                                           : Colors.red,
      //                                       border: Border.all(
      //                                           color: AppColor.white,
      //                                           width: 1.5)),
      //                                 ))
      //                           ],
      //                         ),
      //                       ),
      //                     );
      //                   }),
      //             ),
      //             Positioned(
      //               bottom: 20,
      //               left: 0,
      //               right: 0,
      //               child: Padding(
      //                 padding: const EdgeInsets.symmetric(
      //                     horizontal: 16.0, vertical: 20),
      //                 child: Row(
      //                   crossAxisAlignment: CrossAxisAlignment.center,
      //                   mainAxisAlignment:
      //                   MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     Obx(
      //                           () => Flexible(
      //                         flex: 1,
      //                         child: RoundedButton(
      //                           height: 42,
      //                           width: double.maxFinite,
      //                           color: checkInCheckOutController
      //                               .isEnableCheckInButton.value
      //                               ? AppColor.appPrimary
      //                               : AppColor.disableColor,
      //                           text: 'Check In',
      //                           style: GoogleFonts.poppins(
      //                               color: checkInCheckOutController
      //                                   .isEnableCheckInButton.value
      //                                   ? Colors.white
      //                                   : AppColor.disableTextColor,
      //                               fontSize: 14,
      //                               fontWeight: FontWeight.w600),
      //                           onClick: () {
      //                             checkInCheckOutController
      //                                 .isEnableCheckInButton.value
      //                                 ? checkInCheckOutController
      //                                 .checkInSession()
      //                                 : null;
      //                           },
      //                         ),
      //                       ),
      //                     ),
      //                     const SizedBox(
      //                       width: 10,
      //                     ),
      //                     Obx(
      //                           () => Flexible(
      //                         flex: 1,
      //                         child: RoundedButton(
      //                           height: 42,
      //                           width: double.maxFinite,
      //                           color: checkInCheckOutController
      //                               .isEnableCheckOutButton.value
      //                               ? AppColor.appPrimary
      //                               : AppColor.disableColor,
      //                           text: 'Check out',
      //                           style: GoogleFonts.poppins(
      //                               color: checkInCheckOutController
      //                                   .isEnableCheckOutButton
      //                                   .value
      //                                   ? AppColor.white
      //                                   : AppColor.disableTextColor,
      //                               fontSize: 14,
      //                               fontWeight: FontWeight.w600),
      //                           onClick: () {
      //                             checkInCheckOutController
      //                                 .isEnableCheckOutButton.value
      //                                 ? checkInCheckOutController
      //                                 .checkOutSession()
      //                                 : null;
      //                           },
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             )
      //           ],
      //         )),
      //   ],
      // )
      //     : Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Center(
      //       child: SvgPicture.asset(AppAssets.notFoundIcon),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.symmetric(vertical: 16.0),
      //       child: Center(
      //         child: Text(
      //           "There are no rooms found in the institute",
      //           style: GoogleFonts.poppins(
      //               color: AppColor.heavyTextColor,
      //               fontWeight: FontWeight.w600,
      //               fontSize: 16),
      //         ),
      //       ),
      //     ),
      //   ],
      // )),
    );
  }
}

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/components/rounded_button.dart';
import 'package:preto3/components/staff_nav_drawer.dart';
import 'package:preto3/controller/Staff/staff_dashboard_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/app_string.dart';
import 'package:preto3/utils/argument_keys.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StaffDashboardPage extends StatelessWidget {
  StaffDashboardPage({Key? key}) : super(key: key);

  final staffController = Get.find<StaffDashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: staffController.staffScaffoldKey,
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColor.appPrimary,
        elevation: 0,
        centerTitle: false,
        leading: InkWell(
            onTap: () {
              staffController.openDrawer();
            },
            child: SvgPicture.asset(
              AppAssets.navMenuIcon,
              height: 30,
              width: 30,
              fit: BoxFit.scaleDown,
            )),
        title: Obx(() => Text(
              "Hi ${staffController.firstName.value}",
              style: GoogleFonts.poppins(
                  color: AppColor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            )),
        actions: [
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => showQRDialog());
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
              child: SvgPicture.asset(AppAssets.qrCode),
            ),
          ),
        ],
      ),
      drawer: StaffNavDrawer(),
      body: SmartRefresher(
        controller: staffController.refreshController,
        onRefresh: () {
          staffController.onRefresh();
        },
        enablePullDown: true,
        enablePullUp: false,
        header: const WaterDropHeader(),
        child: Obx(() => staffController.isOnline.value
            ? staffController.isError.isTrue
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppAssets.errorIcon),
                      Text(
                        AppString.errorTitle,
                        style: GoogleFonts.poppins(
                            color: AppColor.heavyTextColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        staffController.errorMessage.value,
                        style: GoogleFonts.poppins(
                          color: AppColor.mediumTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ))
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Obx(
                          () => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  staffController.inTime.value != null
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {
                                              staffController.getStaffDetails(
                                                  staffController.userId.value,
                                                  staffController
                                                      .schoolId.value);
                                              Get.toNamed(
                                                  AppRoute.staffDetails);
                                            },
                                            child: Container(
                                              height: 110,
                                              width: double.maxFinite,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color:
                                                          AppColor.borderColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 16.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              height: 50,
                                                              width: 50,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              90)),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            90),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      const Image(
                                                                    height: 50,
                                                                    width: 50,
                                                                    image:
                                                                        AssetImage(
                                                                      AppAssets
                                                                          .placeHolder,
                                                                    ),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                  imageUrl:
                                                                      staffController
                                                                          .profilePic
                                                                          .value,
                                                                  fit: BoxFit
                                                                      .cover,
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
                                                            ),
                                                            const SizedBox(
                                                              width: 16,
                                                            ),
                                                            Obx(
                                                              () => Text(
                                                                '${staffController.firstName} ${staffController.lastName}',
                                                                style: GoogleFonts.poppins(
                                                                    color: AppColor
                                                                        .heavyTextColor,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 20.0),
                                                        child: Icon(Icons
                                                            .arrow_forward_ios),
                                                      )
                                                    ],
                                                  ),
                                                  IntrinsicHeight(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "In Time",
                                                              style: GoogleFonts.poppins(
                                                                  color: AppColor
                                                                      .heavyTextColor,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                            Text(
                                                              staffController
                                                                  .formattedInTime
                                                                  .value
                                                                  .toString(),
                                                              style: GoogleFonts.poppins(
                                                                  color: AppColor
                                                                      .heavyTextColor,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        const VerticalDivider(
                                                          width: 1,
                                                          thickness: 1,
                                                          color: AppColor
                                                              .lightTextColor,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Out Time",
                                                              style: GoogleFonts.poppins(
                                                                  color: AppColor
                                                                      .heavyTextColor,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                            Text(
                                                              staffController
                                                                  .formattedOutTime
                                                                  .value
                                                                  .toString(),
                                                              style: GoogleFonts.poppins(
                                                                  color: AppColor
                                                                      .heavyTextColor,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        const VerticalDivider(
                                                          width: 1,
                                                          thickness: 1,
                                                          color: AppColor
                                                              .lightTextColor,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Total Hours",
                                                              style: GoogleFonts.poppins(
                                                                  color: AppColor
                                                                      .heavyTextColor,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                            Text(
                                                              staffController
                                                                  .totalHour
                                                                  .value
                                                                  .toString(),
                                                              style: GoogleFonts.poppins(
                                                                  color: AppColor
                                                                      .heavyTextColor,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  staffController.staffRoomList.isNotEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 4),
                                          child: Text(
                                            AppString.myRooms,
                                            style: GoogleFonts.poppins(
                                                color: AppColor.heavyTextColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      : Container(),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          GetBuilder<StaffDashboardController>(
                                        builder: (controller) =>
                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                itemCount: controller
                                                    .staffRoomList.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      // Get.toNamed(AppRoute.comingSoon);
                                                      controller.isAllAbsent
                                                          .value = controller
                                                              .staffRoomList[
                                                                  index]
                                                              .studentCheckInOutData
                                                              .totalStudents ==
                                                          controller
                                                              .staffRoomList[
                                                                  index]
                                                              .studentCheckInOutData
                                                              .studentAbsent;
                                                      Get.toNamed(
                                                          AppRoute.classRoom,
                                                          arguments: {
                                                            ArgumentKeys
                                                                    .argumentClassId:
                                                                controller
                                                                    .staffRoomList[
                                                                        index]
                                                                    .roomId,
                                                            ArgumentKeys
                                                                    .argumentAllAbsent:
                                                                controller
                                                                    .isAllAbsent
                                                                    .value,
                                                          });
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0),
                                                      child: Container(
                                                        height: 110,
                                                        width: double.maxFinite,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: AppColor
                                                                    .borderColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          16.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      const Image(
                                                                        image: AssetImage(
                                                                            AppAssets.placeHolder),
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            16,
                                                                      ),
                                                                      Text(
                                                                        controller
                                                                            .staffRoomList[index]
                                                                            .roomName,
                                                                        style: GoogleFonts.poppins(
                                                                            color: AppColor
                                                                                .heavyTextColor,
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              20.0),
                                                                  child: Icon(Icons
                                                                      .arrow_forward_ios),
                                                                )
                                                              ],
                                                            ),
                                                            IntrinsicHeight(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        staffController
                                                                            .staffRoomList[index]
                                                                            .studentCheckInOutData
                                                                            .totalStudents
                                                                            .toString(),
                                                                        style: GoogleFonts.poppins(
                                                                            color: AppColor
                                                                                .heavyTextColor,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                        AppString
                                                                            .students,
                                                                        style: GoogleFonts.poppins(
                                                                            color: AppColor
                                                                                .heavyTextColor,
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const VerticalDivider(
                                                                    width: 1,
                                                                    thickness:
                                                                        1,
                                                                    color: AppColor
                                                                        .lightTextColor,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        staffController
                                                                            .staffRoomList[index]
                                                                            .studentCheckInOutData
                                                                            .studentIn
                                                                            .toString(),
                                                                        style: GoogleFonts.poppins(
                                                                            color: AppColor
                                                                                .heavyTextColor,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                        "In",
                                                                        style: GoogleFonts.poppins(
                                                                            color: AppColor
                                                                                .heavyTextColor,
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const VerticalDivider(
                                                                    width: 1,
                                                                    thickness:
                                                                        1,
                                                                    color: AppColor
                                                                        .lightTextColor,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        staffController
                                                                            .staffRoomList[index]
                                                                            .studentCheckInOutData
                                                                            .studentAbsent
                                                                            .toString(),
                                                                        style: GoogleFonts.poppins(
                                                                            color: AppColor
                                                                                .heavyTextColor,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                        "Absent",
                                                                        style: GoogleFonts.poppins(
                                                                            color: AppColor
                                                                                .heavyTextColor,
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                      )),
                                ],
                              )),
                        ),
                        GetBuilder<StaffDashboardController>(
                          builder: (controller) => ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.dashboardCategory.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      switch (index) {
                                        case 0:
                                          Get.toNamed(AppRoute.checkIn,
                                              arguments: {
                                                ArgumentKeys.argumentAllAbsent:
                                                    controller
                                                        .isAllAbsent.value,
                                              });
                                          // Get.toNamed(AppRoute.comingSoon);
                                          break;
                                        case 1:
                                          // Get.toNamed(AppRoute.comingSoon);
                                          Get.toNamed(AppRoute.communication);
                                          break;
                                        case 2:
                                          Get.toNamed(AppRoute.event);
                                          // Get.toNamed(AppRoute.comingSoon);
                                          break;
                                        case 3:
                                          Get.toNamed(AppRoute.dailyActivity);
                                          // Get.toNamed(AppRoute.comingSoon);
                                          break;
                                        case 4:
                                          // Get.toNamed(AppRoute.schedule);
                                          Get.toNamed(AppRoute.comingSoon);
                                          break;
                                        default:
                                          Get.toNamed(AppRoute.checkIn);
                                      }
                                    },
                                    child: Container(
                                      height: 80,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                          color: controller
                                              .dashboardCategory[index]
                                              .bgColors,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                          color: controller
                                                              .dashboardCategory[
                                                                  index]
                                                              .colors,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: SvgPicture.asset(
                                                        controller
                                                            .dashboardCategory[
                                                                index]
                                                            .assetImage,
                                                        height: 24,
                                                        width: 24,
                                                        fit: BoxFit.scaleDown,
                                                      )),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      controller
                                                          .dashboardCategory[
                                                              index]
                                                          .name,
                                                      style: GoogleFonts.poppins(
                                                          color: controller
                                                              .dashboardCategory[
                                                                  index]
                                                              .colors,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    staffController
                                                                .dashboardCategory[
                                                                    index]
                                                                .name ==
                                                            "Events"
                                                        ? Text(
                                                            "${staffController.eventCount.value.toString()} Events",
                                                            style: GoogleFonts.poppins(
                                                                color: controller
                                                                    .dashboardCategory[
                                                                        index]
                                                                    .colors,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          )
                                                        : Container()
                                                  ],
                                                )
                                              ],
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: controller
                                                  .dashboardCategory[index]
                                                  .colors,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ]),
                    ),
                  )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 85.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.noInternetIcon),
                    Text(
                      AppString.noInternetTitle,
                      style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      AppString.noInternetDesc,
                      style: GoogleFonts.poppins(
                        color: AppColor.mediumTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: RoundedButton(
                          height: 50,
                          width: 200,
                          color: AppColor.appPrimary,
                          onClick: () {
                            staffController.getStaffDashboard(
                                staffController.schoolId.value);
                          },
                          text: "Retry",
                          style: GoogleFonts.poppins(
                              color: AppColor.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                    )
                  ],
                ),
              )),
      ),
    );
  }

  showQRDialog() {
    final byteImage =
        const Base64Decoder().convert(staffController.qrCode.value);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
              color: AppColor.white, borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.memory(
              byteImage,
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}

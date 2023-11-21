import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:preto3/components/parent_drawer.dart';
import 'package:preto3/components/rounded_button.dart';
import 'package:preto3/controller/Communication/communication_controller.dart';
import 'package:preto3/controller/Parent/parent_dashboard_controller.dart';
import 'package:preto3/controller/daily_activity_controller.dart';
import 'package:preto3/controller/google_places_controller.dart';

import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/app_string.dart';
import 'package:preto3/utils/argument_keys.dart';
import 'dart:convert';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class ParentDashboardPage extends StatelessWidget {
  ParentDashboardPage({Key? key}) : super(key: key);

  final parentDashboardController = Get.find<ParentDashboardController>();
  final communicationController = Get.find<CommunicationController>();
  final dailyActivity = Get.find<DailyActivityController>();
  final placeController = Get.put(GooglePlacesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.scaffoldBackground,
        key: parentDashboardController.scaffoldKey,
        appBar: AppBar(
          backgroundColor: AppColor.appPrimary,
          elevation: 0,
          leading: InkWell(
              onTap: () {
                parentDashboardController.openDrawer();
              },
              child: SvgPicture.asset(
                AppAssets.navMenuIcon,
                height: 30,
                width: 30,
                fit: BoxFit.scaleDown,
              )),
          centerTitle: false,
          title: Text(
            "Hi ${parentDashboardController.firstName.value}",
            style: GoogleFonts.poppins(
                color: AppColor.white,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          actions: [
            // InkWell(
            //   onTap: () {},
            //   child: const Padding(
            //     padding: EdgeInsets.all(4.0),
            //     child: Icon(Icons.notifications_none),
            //   ),
            // ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => showQRDialog());
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(AppAssets.qrCode),
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(AppRoute.scannerPage);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SvgPicture.asset(AppAssets.qrScanner),
              ),
            )
          ],
        ),
        drawer: ParentDrawer(),
        body: SmartRefresher(
          controller: parentDashboardController.refreshController,
          onRefresh: () {
            parentDashboardController.onRefresh();
          },
          enablePullDown: true,
          enablePullUp: false,
          header: const WaterDropHeader(
            complete: Icon(
              Icons.done,
              color: AppColor.appPrimary,
            ),
            waterDropColor: AppColor.appPrimary,
          ),
          child: Obx(() => parentDashboardController.isOnline.value
              ? parentDashboardController.isError.isTrue
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
                          parentDashboardController.errorMessage.value,
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
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'My Children',
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GetBuilder<ParentDashboardController>(
                                  builder: ((controller) => ListView.builder(
                                      itemCount:
                                          controller.childDetailsList.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: ((context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Get.find<DailyActivityController>()
                                                .getActivityDetailByStudentId(
                                                    controller.schoolId.value,
                                                    controller
                                                        .childDetailsList[index]
                                                        .id,
                                                    controller.roleId.value);
                                            Get.toNamed(AppRoute.studentDetails,
                                                arguments: {
                                                  ArgumentKeys
                                                          .argumentStudentId:
                                                      controller
                                                          .childDetailsList[
                                                              index]
                                                          .id,
                                                  ArgumentKeys.argumentCheckIn:
                                                      controller.pin.value,
                                                  ArgumentKeys
                                                          .argumentChildFirstName:
                                                      controller
                                                          .childDetailsList[
                                                              index]
                                                          .firstName,
                                                  ArgumentKeys
                                                          .argumentChildLastName:
                                                      controller
                                                          .childDetailsList[
                                                              index]
                                                          .lastName,
                                                  ArgumentKeys
                                                          .argumentChildProfilePic:
                                                      controller
                                                          .childDetailsList[
                                                              index]
                                                          .profilePic,
                                                  ArgumentKeys.argumentInTime:
                                                      controller
                                                          .childDetailsList[
                                                              index]
                                                          .inTime,
                                                  ArgumentKeys.argumentOutTime:
                                                      controller
                                                          .childDetailsList[
                                                              index]
                                                          .outTime,
                                                  ArgumentKeys
                                                          .argumentTotalTime:
                                                      controller
                                                          .childDetailsList[
                                                              index]
                                                          .totalHours,
                                                });
                                          },
                                          child: Container(
                                            height: 110,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            width: double.maxFinite,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        AppColor.borderColor),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              Container(
                                                                width: 50,
                                                                height: 50,
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  right: 10,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      width: 1,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .scaffoldBackgroundColor),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    imageUrl: controller
                                                                        .childDetailsList[
                                                                            index]
                                                                        .profilePic
                                                                        .toString(),
                                                                    errorWidget:
                                                                        (context,
                                                                            url,
                                                                            error) {
                                                                      return Image.asset(
                                                                          AppAssets
                                                                              .placeHolder);
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                  bottom: 5,
                                                                  right: 15,
                                                                  child:
                                                                      Container(
                                                                    height: 10,
                                                                    width: 10,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        width:
                                                                            0,
                                                                        color: Theme.of(context)
                                                                            .scaffoldBackgroundColor,
                                                                      ),
                                                                      color: controller.childDetailsList[index].inTime == "-" &&
                                                                              controller.childDetailsList[index].outTime ==
                                                                                  "-"
                                                                          ? Colors
                                                                              .red
                                                                          : controller.childDetailsList[index].inTime != "-" && controller.childDetailsList[index].outTime != "-"
                                                                              ? Colors.grey
                                                                              : Colors.green,
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            width: 16,
                                                          ),
                                                          Obx(
                                                            () => Text(
                                                              '${controller.childDetailsList[index].firstName} ${controller.childDetailsList[index].lastName}',
                                                              style: GoogleFonts.poppins(
                                                                  color: AppColor
                                                                      .heavyTextColor,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 20.0),
                                                      child: Icon(
                                                        Icons.arrow_forward_ios,
                                                        size: 15,
                                                      ),
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
                                                            controller
                                                                        .childDetailsList[
                                                                            index]
                                                                        .inTime !=
                                                                    "-"
                                                                ? DateFormat(
                                                                        'hh:mm a')
                                                                    .format(DateTime.fromMillisecondsSinceEpoch(controller
                                                                        .childDetailsList[
                                                                            index]
                                                                        .inTime))
                                                                : "-",
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
                                                            controller
                                                                        .childDetailsList[
                                                                            index]
                                                                        .outTime !=
                                                                    "-"
                                                                ? DateFormat(
                                                                        'hh:mm a')
                                                                    .format(DateTime.fromMillisecondsSinceEpoch(controller
                                                                        .childDetailsList[
                                                                            index]
                                                                        .outTime))
                                                                : "-",
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
                                                            controller
                                                                .childDetailsList[
                                                                    index]
                                                                .totalHours,
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
                                        );
                                      }))))
                            ],
                          ),
                        ),
                        GetBuilder<ParentDashboardController>(
                          builder: (controller) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.dashboardCategory.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: InkWell(
                                      onTap: () {
                                        switch (index) {
                                          case 0:
                                            Get.toNamed(AppRoute
                                                .parentCommunicationPage);
                                            // Get.toNamed(AppRoute.comingSoon);
                                            break;
                                          case 1:
                                            Get.toNamed(AppRoute.fees,
                                                arguments: {
                                                  ArgumentKeys.argumentSchoolId:
                                                      controller.schoolId,
                                                  ArgumentKeys.argumentRoleId:
                                                      controller.roleId
                                                });
                                            break;
                                          case 2:
                                            // Get.toNamed(AppRoute.communication);
                                            Get.toNamed(
                                                AppRoute.authorizePikupList);
                                            break;
                                          case 3:
                                            Get.toNamed(AppRoute.event);
                                            break;
                                          case 4:
                                            // Get.toNamed(AppRoute.schoolSetting);
                                            Get.toNamed(AppRoute.comingSoon);

                                            break;
                                          default:
                                            Get.toNamed(AppRoute.room);
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
                                                    padding:
                                                        const EdgeInsets.all(
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
                                                                    .circular(
                                                                        5)),
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      parentDashboardController
                                                                  .dashboardCategory[
                                                                      index]
                                                                  .name ==
                                                              "Events"
                                                          ? Text(
                                                              "${parentDashboardController.eventCount.value.toString()} Events",
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
                          ),
                        )
                      ]),
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
                              parentDashboardController.getParentDashboard(
                                  parentDashboardController.schoolId.value);
                              parentDashboardController.getParentProfileDetails(
                                  parentDashboardController.schoolId.value);
                              // parentDashboardController.getGroupFromBackend(parentDashboardController.schoolId.value, parentDashboardController.roleId.value);
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
        ));
  }

  showQRDialog() {
    final byteImage =
        const Base64Decoder().convert(parentDashboardController.qrCode.value);
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

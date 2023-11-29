import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:preto3/components/rounded_button.dart';
import 'package:preto3/controller/Admin/dashboard_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/components/nav_drawer.dart';
import 'package:preto3/utils/app_string.dart';
import 'package:preto3/utils/argument_keys.dart';

import '../../components/admin/admin_drawer.dart';
import '../../controller/Admin/room_management/room_controller.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);

  final dashboardController = Get.find<DashboardController>();
  final roomController = Get.find<RoomController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      key: dashboardController.scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColor.appPrimary,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              dashboardController.openDrawer();
            },
            child: SvgPicture.asset(
              AppAssets.navMenuIcon,
              height: 30,
              width: 30,
              fit: BoxFit.scaleDown,
            )),
        title: Text(
          "Hi ${dashboardController.firstName.value}",
          style: GoogleFonts.poppins(
              color: AppColor.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.qr_code),
          )
        ],
      ),
      drawer: NavDrawer(),
      body:
      Obx(() =>
      dashboardController.isOnline.value
          ? dashboardController.isError.isTrue
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
                dashboardController.errorMessage.value,
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
          :
      NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool isInnerScroll) {
            return [
              SliverToBoxAdapter(
                  child: Obx(
                        () =>
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              dashboardController.allBirthdayList.isNotEmpty
                                  ? GetBuilder<DashboardController>(
                                      builder: (controller) =>
                                          CarouselSlider(
                                              items: controller.allBirthdayList
                                                  .map((element) => Builder(builder: (context){
                                                    return Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 4.0),
                                                      child: Container(
                                                        // height: 150,
                                                        width: double.maxFinite,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            boxShadow: const [
                                                              BoxShadow(
                                                                color: Colors.black12,
                                                                offset: Offset(0.0,0.8),
                                                                blurRadius: 5.0,
                                                                spreadRadius: 2.0
                                                              )
                                                            ],
                                                            border: Border.all(
                                                                color: AppColor.borderColor),
                                                            borderRadius:
                                                            BorderRadius.circular(10)),
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(
                                                              horizontal: 16.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.spaceEvenly,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.center,
                                                            children: [
                                                              const Image(
                                                                  image: AssetImage(
                                                                    AppAssets.birthdayBanner,
                                                                  )),
                                                              Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment.center,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment.start,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment.center,
                                                                    children: [
                                                                      const Image(
                                                                        image: AssetImage(
                                                                            AppAssets.dummyDp),
                                                                        height: 50,
                                                                        width: 50,
                                                                      ),
                                                                      const SizedBox(
                                                                        width: 16,
                                                                      ),
                                                                      Text(
                                                                        element!
                                                                            .name
                                                                            .toString(),
                                                                        style: GoogleFonts.poppins(
                                                                            color: AppColor
                                                                                .heavyTextColor,
                                                                            fontSize: 14,
                                                                            fontWeight:
                                                                            FontWeight.w400),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    DateFormat.Md().format(DateTime.parse(element.dob.toString())),
                                                                    style: GoogleFonts.poppins(
                                                                        color: AppColor
                                                                            .heavyTextColor,
                                                                        fontSize: 14,
                                                                        fontWeight:
                                                                        FontWeight.w400),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                              })).toList(),
                                              options: CarouselOptions(
                                                height: 180,
                                                autoPlayInterval: const Duration(seconds: 3),
                                                autoPlay: true,
                                                autoPlayCurve: Curves.easeIn,
                                                aspectRatio: 16/9,
                                                viewportFraction: 0.8,
                                                enlargeCenterPage: true,
                                                enlargeFactor: 0.3,
                                              )))
                                  : Container(),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(AppRoute.students, arguments: {
                                    ArgumentKeys
                                        .argumentStudentTotal: dashboardController
                                        .studentTotalCount.value,
                                    ArgumentKeys
                                        .argumentStudentCheckIn: dashboardController
                                        .studentCheckedIn.value,
                                    ArgumentKeys
                                        .argumentStudentCheckOut: dashboardController
                                        .studentCheckedOut.value,
                                    ArgumentKeys
                                        .argumentStudentAbsent: dashboardController
                                        .studentAbsent.value
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 15),
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: AppColor.borderColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    // mainAxisAlignment:
                                    // MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                    SvgPicture.asset(AppAssets.totalStudent),
                                                  const SizedBox(
                                                    width: 16,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Total Student",
                                                        style: GoogleFonts
                                                            .poppins(
                                                            color: AppColor
                                                                .heavyTextColor,
                                                            fontSize: 16,
                                                            fontWeight:
                                                            FontWeight.w500),
                                                      ),
                                                      Text(
                                                        dashboardController
                                                            .studentTotalCount
                                                            .value
                                                            .toString(),
                                                        style: GoogleFonts
                                                            .poppins(
                                                            color: AppColor
                                                                .heavyTextColor,
                                                            fontSize: 18,
                                                            fontWeight:
                                                            FontWeight.w500),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Padding(
                                              padding:
                                              EdgeInsets.only(right: 20.0),
                                              child:
                                              Icon(Icons.arrow_forward_ios),
                                            )
                                          ],
                                        ),
                                      ),
                                      IntrinsicHeight(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "In",
                                                  style: GoogleFonts.poppins(
                                                      color: AppColor
                                                          .heavyTextColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w400),
                                                ),
                                                Text(
                                                  dashboardController
                                                      .studentCheckedIn.value
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      color: AppColor
                                                          .heavyTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            const VerticalDivider(
                                              width: 1,
                                              thickness: 1,
                                              color: AppColor.lightTextColor,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Out",
                                                  style: GoogleFonts.poppins(
                                                      color: AppColor
                                                          .heavyTextColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w400),
                                                ),
                                                Text(
                                                  dashboardController
                                                      .studentCheckedOut.value
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      color: AppColor
                                                          .heavyTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            const VerticalDivider(
                                              width: 1,
                                              thickness: 1,
                                              color: AppColor.lightTextColor,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Absent",
                                                  style: GoogleFonts.poppins(
                                                      color: AppColor
                                                          .heavyTextColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w400),
                                                ),
                                                Text(
                                                  dashboardController
                                                      .studentAbsent.value
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      color: AppColor
                                                          .heavyTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w500),
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
                              InkWell(
                                onTap: (){
                                  Get.toNamed(AppRoute.adminDashboardStaff, arguments: {
                                    ArgumentKeys.argumentStaffTotal:dashboardController.staffTotalCount.value,
                                    ArgumentKeys.argumentCheckIn:dashboardController.staffCheckedIn.value,
                                    ArgumentKeys.argumentStaffCheckOut:dashboardController.staffCheckedOut.value,
                                    ArgumentKeys.argumentStaffAbsent:dashboardController.staffAbsent.value,
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: AppColor.borderColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(left: 16.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(AppAssets.totalStudent),
                                                  const SizedBox(
                                                    width: 16,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Total Staff",
                                                        style: GoogleFonts.poppins(
                                                            color: AppColor
                                                                .heavyTextColor,
                                                            fontSize: 16,
                                                            fontWeight:
                                                            FontWeight.w500),
                                                      ),
                                                      Text(
                                                        dashboardController
                                                            .staffTotalCount.value
                                                            .toString(),
                                                        style: GoogleFonts.poppins(
                                                            color: AppColor
                                                                .heavyTextColor,
                                                            fontSize: 18,
                                                            fontWeight:
                                                            FontWeight.w500),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(right: 20.0),
                                              child: Icon(Icons.arrow_forward_ios),
                                            )
                                          ],
                                        ),
                                      ),
                                      IntrinsicHeight(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "In",
                                                  style: GoogleFonts.poppins(
                                                      color:
                                                      AppColor.heavyTextColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w400),
                                                ),
                                                Text(
                                                  dashboardController
                                                      .staffCheckedIn.value
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      color:
                                                      AppColor.heavyTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            const VerticalDivider(
                                              width: 1,
                                              thickness: 1,
                                              color: AppColor.lightTextColor,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Out",
                                                  style: GoogleFonts.poppins(
                                                      color:
                                                      AppColor.heavyTextColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w400),
                                                ),
                                                Text(
                                                  dashboardController
                                                      .staffCheckedOut.value
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      color:
                                                      AppColor.heavyTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            const VerticalDivider(
                                              width: 1,
                                              thickness: 1,
                                              color: AppColor.lightTextColor,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Absent",
                                                  style: GoogleFonts.poppins(
                                                      color:
                                                      AppColor.heavyTextColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w400),
                                                ),
                                                Text(
                                                  dashboardController
                                                      .staffAbsent.value
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      color:
                                                      AppColor.heavyTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w500),
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
                            ],
                          ),
                        ),
                  ))
            ];
          },
          body: GetBuilder<DashboardController>(
            builder: (controller) =>
                ListView.builder(
                    itemCount: controller.dashboardCategory.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets. symmetric(vertical: 10,horizontal: 20),
                        child: InkWell(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.toNamed(AppRoute.room);
                                break;
                              case 1:
                                Get.toNamed(AppRoute.checkIn);
                                break;
                              case 2:
                                Get.toNamed(AppRoute.communication);
                                break;
                              case 3:
                                Get.toNamed(AppRoute.fees);
                                break;
                              case 4:
                                Get.toNamed(AppRoute.schoolSetting);
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
                                    .dashboardCategory[index].bgColors,
                                borderRadius: BorderRadius.circular(10)),
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
                                        padding: const EdgeInsets.all(16.0),
                                        child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: controller
                                                    .dashboardCategory[
                                                index]
                                                    .colors,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    5)),
                                            child: SvgPicture.asset(
                                              controller
                                                  .dashboardCategory[index]
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
                                                .dashboardCategory[index]
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
                                          dashboardController
                                              .dashboardCategory[
                                          index]
                                              .name ==
                                              "Room"
                                              ? Text(
                                            "${roomController.allRoomList.length
                                                 } Rooms",
                                            style: GoogleFonts.poppins(
                                                color: controller
                                                    .dashboardCategory[
                                                index]
                                                    .colors,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.w400),
                                          )
                                              : Container()
                                        ],
                                      )
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: controller
                                        .dashboardCategory[index].colors,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
          ))
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
                    dashboardController.getAdminDashboard(
                        dashboardController.roleId.value,
                        dashboardController.schoolId.value,
                        dashboardController.isWebRequest);
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
    );
  }
}

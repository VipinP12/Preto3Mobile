import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/Admin/dashboard_controller.dart';
import 'package:preto3/controller/Admin/drawer_controller/admin_profile_controller.dart';
import 'package:preto3/network/socket_server.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/toast.dart';

import '../network/is_internet_connected.dart';
import '../utils/app_keys.dart';
import '../view/AdminModule/drawer/schedule_view/schedule_bottomsheet.dart';
import '../view/AdminModule/drawer/switch_school_role/switch_school_bottomSheet.dart';

class NavDrawer extends StatelessWidget {
  NavDrawer({Key? key}) : super(key: key);

  final dashboardController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
     return SafeArea(
      child: InkWell(
        onTap: () {
          dashboardController.closeDrawer();
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width - 80,
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 75,
                              width: 75,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(35),
                                child: const Image(
                                  height: 75,
                                  width: 75,
                                  image: AssetImage(
                                    AppAssets.profile,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: (){
                                Get.put(AdminProfileController());
                                Get.back();
                                Get.toNamed(AppRoute.editAdminProfile);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${dashboardController.firstName.value} ${dashboardController.lastName.value}",
                                    style: GoogleFonts.poppins(
                                        color: AppColor.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                      "Admin : ${dashboardController.storageBox.read(AppKeys.keyCheckInOutPin) ?? "null"}",
                                      style: GoogleFonts.poppins(
                                          color: AppColor.heavyTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: (){
                            // Get.toNamed(AppRoute.editAdminProfile);
                          },
                          child: Text("Profile",
                              style: GoogleFonts.poppins(
                                  color: AppColor.heavyTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: AppColor.borderColor,
                  // height: 0,
                  thickness: 1,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoute.event);
                          log("You clicked on event");
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppAssets.navEventIcon),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text("Event",
                                        style: GoogleFonts.poppins(
                                            color: AppColor.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                  )
                                ],
                              ),
                              SvgPicture.asset(AppAssets.forwardIcon),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoute.dailyActivity);
                          log("You clicked on Daily Activities");
                          // dashboardController.closeDrawer();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppAssets.navActivityIcon),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text("Daily Activity",
                                        style: GoogleFonts.poppins(
                                            color: AppColor.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                  )
                                ],
                              ),
                              SvgPicture.asset(AppAssets.forwardIcon),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Get.toNamed(AppRoute.adminAuthorizePickup);
                          print("authorize pickup()()()");
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppAssets.navPickUpIcon),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text("Authorize Pickup",
                                        style: GoogleFonts.poppins(
                                            color: AppColor.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                  )
                                ],
                              ),
                              SvgPicture.asset(AppAssets.forwardIcon),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Get.toNamed(AppRoute.adminSchedule);
                          print("schedule");
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppAssets.navScheduleIcon),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text("Schedule",
                                        style: GoogleFonts.poppins(
                                            color: AppColor.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                  )
                                ],
                              ),
                              SvgPicture.asset(AppAssets.forwardIcon),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          print("customer");
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppAssets.navSupportIcon),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text("Customer Support",
                                        style: GoogleFonts.poppins(
                                            color: AppColor.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                  )
                                ],
                              ),
                              SvgPicture.asset(AppAssets.forwardIcon),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: AppColor.borderColor,
                  thickness: 1,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          print("vandana");
                          showModalBottomSheet(
                            // isScrollControlled:true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            isDismissible: true,
                            enableDrag: false,
                            builder: (context) {
                              return   const SingleChildScrollView(
                                child: SwitchSchoolRoleBottomSheet(),
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppAssets.navSwitchRoleIcon),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text("Switch School & Role",
                                    style: GoogleFonts.poppins(
                                        color: AppColor.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8),
                        child: InkWell(
                          onTap: () async {
                            if (await InternetConnection
                                .checkIsInternetConnected()) {
                              await dashboardController
                                  .removePushNotification();
                              dashboardController.storageBox.erase();
                              SocketServer.instance!.socket.close();
                              Get.offAndToNamed(AppRoute.login);
                            } else {
                              messageToastWarning(context,
                                  "You are not connected to the internet.");
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppAssets.logoutIcon),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text("Log out",
                                        style: GoogleFonts.poppins(
                                            color: AppColor.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text("Version 0.00",
                                    style: GoogleFonts.poppins(
                                        color: AppColor.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

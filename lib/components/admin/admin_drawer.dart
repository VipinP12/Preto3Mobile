import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/Parent/parent_dashboard_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/app_routes.dart';

import '../../controller/Admin/admin_deshboard_controller.dart';

// import '../network/is_internet_connected.dart';
// import '../network/socket_server.dart';
// import '../utils/toast.dart';

class AdminDrawer extends StatelessWidget {
  AdminDrawer({super.key});
  final dashboardController = Get.find<AdminDashboardController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        dashboardController.closeDrawer();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width - 80,
          padding: const EdgeInsets.only(bottom: 10, top: 40),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: InkWell(
                    onTap: () {
                      print("object");
                      // dashboardController.closeDrawer();
                      Get.toNamed(AppRoute.editAdminProfile);
                    },
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
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(75),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: dashboardController.storageBox
                                      .read(AppKeys.keyParentProfileURL)
                                      .toString(),
                                  errorWidget: (context, url, error) {
                                    return Image.asset(AppAssets.placeHolder);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${dashboardController.storageBox.read(AppKeys.keyFirstName)} ${dashboardController.storageBox.read(AppKeys.keyLastName)}",
                                    style: GoogleFonts.poppins(
                                      color: AppColor.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Text("Admin 4500",
                                      style: GoogleFonts.poppins(
                                          color: AppColor.heavyTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  // Text(
                                  //   "Check in/out Pin:${dashboardController.storageBox.read(AppKeys.keyCheckInOutPin) ?? ""}",
                                  //   style: GoogleFonts.poppins(
                                  //       color: AppColor.heavyTextColor,
                                  //       fontSize: 14,
                                  //       fontWeight: FontWeight.w400),
                                  // ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        InkWell(
                          onTap: ()
                          // {
                          //   print("edit profile");
                          // },
                          => Get.toNamed(AppRoute.editAdminProfile),
                          child: Text("Edit Profile",
                              style: GoogleFonts.poppins(
                                  color: AppColor.editProfile,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(
                color: AppColor.borderColor,
                thickness: 1,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        print("event");
                        // Get.toNamed(AppRoute.checkInOutPage);
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
                                  child: Text("Events",
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
                        //Get.find<DailyActivityController>().getAllActivity(dashboardController.schoolId.value,dashboardController.roleId.value);
                        // Get.toNamed(AppRoute.dailyActivity);
                        log("You clicked on Daily Activities");
                        dashboardController.closeDrawer();
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
                    Padding(
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
                              SvgPicture.asset(AppAssets.authorizePickup),
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
                    Padding(
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
                              SvgPicture.asset(AppAssets.scheduleIcon),
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
                    Padding(
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
                  ],
                ),
              ),
              const Divider(
                color: AppColor.borderColor,
                thickness: 1,
              ),
              Container(
                height: MediaQuery.of(context).size.height/7,
                width: double.maxFinite,
                // color: Colors.amberAccent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppAssets.switchIcon),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0),
                            child: Text("Swith School & Role",
                                style: GoogleFonts.poppins(
                                    color: AppColor.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () async {
                          // if (dashboardController.logedOut.value) return;
                          // if (await InternetConnection.checkIsInternetConnected()) {
                          //   dashboardController.logedOut.value = true;
                          //   await dashboardController.removePushNotification();
                          //   dashboardController.storageBox.erase();
                          //   SocketServer.instance!.socket.close();
                          //   Get.offAllNamed(AppRoute.login);
                          //   dashboardController.logedOut.value = false;
                          // } else {
                          //   // ignore: use_build_context_synchronously
                          //   messageToastWarning(
                          //       context, "You are not connected to the internet.");
                          // }
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
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text("Log out",
                                      style: GoogleFonts.poppins(
                                          color: AppColor.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text("Version 0.00",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

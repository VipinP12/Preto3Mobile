import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/Staff/staff_dashboard_controller.dart';
import 'package:preto3/network/is_internet_connected.dart';
import 'package:preto3/network/socket_server.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/app_routes.dart';

import '../utils/toast.dart';

class StaffNavDrawer extends StatelessWidget {
  StaffNavDrawer({Key? key}) : super(key: key);

  final dashboardController = Get.find<StaffDashboardController>();

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
                  child: Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: InkWell(
                      onTap: () {
                        log("GO TO PROFILE");
                        dashboardController.closeDrawer();
                        Get.toNamed(AppRoute.staffDetails);
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
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(35),
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) => const Image(
                                      height: 75,
                                      width: 75,
                                      image: AssetImage(
                                        AppAssets.placeHolder,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    imageUrl:
                                        '${dashboardController.storageBox.read(AppKeys.keyProfilePic)}',
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
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
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text("Teacher",
                                        style: GoogleFonts.poppins(
                                            color: AppColor.heavyTextColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                    Text(
                                      "Check in/out Pin:${dashboardController.storageBox.read(AppKeys.keyCheckInOutPin) ?? ""}",
                                      style: GoogleFonts.poppins(
                                          color: AppColor.heavyTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          InkWell(
                            onTap: () {
                              dashboardController.closeDrawer();
                              // Get.toNamed(AppRoute.staffDetails);
                              Get.toNamed(AppRoute.editStaffProfile);
                            },
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
              ),
              const Divider(
                color: AppColor.borderColor,
                thickness: 1,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    // InkWell(
                    //   onTap: () {
                    //     Get.toNamed(AppRoute.comingSoon);
                    //     print("You clicked on event");
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 16.0, vertical: 8),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             SvgPicture.asset(AppAssets.navRoomIcon),
                    //             Padding(
                    //               padding: const EdgeInsets.symmetric(
                    //                   horizontal: 16.0),
                    //               child: Text("My Rooms",
                    //                   style: GoogleFonts.poppins(
                    //                       color: AppColor.black,
                    //                       fontSize: 14,
                    //                       fontWeight: FontWeight.w400)),
                    //             )
                    //           ],
                    //         ),

                    //         SvgPicture.asset(AppAssets.forwardIcon),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    InkWell(
                      onTap: () {
                        print("You clicked on Daily Activities");
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
              SizedBox(
                height: 100,
                width: double.maxFinite,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: InkWell(
                    onTap: () async {
                      if (dashboardController.logedOut.value) return;
                      if (await InternetConnection.checkIsInternetConnected()) {
                        dashboardController.logedOut.value = true;
                        await dashboardController.removePushNotification();
                        dashboardController.storageBox.erase();
                        // SocketServer.instance!.socket.close();
                        Get.offAllNamed(AppRoute.login);
                        dashboardController.logedOut.value = false;
                      } else {
                        // ignore: use_build_context_synchronously
                        messageToastWarning(
                            context, "You are not connected to the internet.");
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/Admin/room_management/room_selected_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/app_string.dart';

import '../../../controller/checkin_controller.dart';

class RoomSelectedPage extends StatelessWidget {
  RoomSelectedPage({Key? key}) : super(key: key);

  final roomSelectedController = Get.find<RoomSelectedController>();
  // final checkInController = Get.find<CheckInController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
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
          AppString.room,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 24,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(
              Icons.settings,
              color: Colors.white,
              size: 24,
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TabBar(
            tabs: roomSelectedController.myTabs,
            controller: roomSelectedController.tabController,
            labelColor: AppColor.appPrimary,
            indicatorColor: AppColor.appPrimary,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Expanded(
              child: TabBarView(
                  controller: roomSelectedController.tabController,
                  children: roomSelectedController.myTabs
                      .map((Tab tab) => tab.text == AppString.tabStudent
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 2),
                              child: GetBuilder(
                                init: roomSelectedController,
                                builder: ((controller) => ListView.separated(
                                      itemCount:
                                          controller.allStudentList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            Get.toNamed(AppRoute.studentProfile);
                                          },
                                          child: SizedBox(
                                            height: 80,
                                            width: double.maxFinite,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        height: 42,
                                                        width: 42,
                                                        decoration: BoxDecoration(
                                                            color: AppColor.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          child: const Image(
                                                            image: AssetImage(
                                                                AppAssets
                                                                    .dummyDp),
                                                            height: 50,
                                                            width: 50,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                          top: 26,
                                                          left: 26,
                                                          right: 0,
                                                          bottom: 0,
                                                          child:
                                                              SvgPicture.asset(
                                                            AppAssets
                                                                .activeIcon,
                                                            height: 16,
                                                            width: 16,
                                                          ))
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Flexible(
                                                      child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        controller
                                                            .allStudentList[
                                                                index]!
                                                            .studentFullName
                                                            .toString(),
                                                        style: GoogleFonts.poppins(
                                                            color: AppColor
                                                                .heavyTextColor,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const Icon(Icons
                                                          .arrow_forward_ios,color: AppColor.mediumTextColor,size: 16,)
                                                    ],
                                                  ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const Divider(
                                          color: Colors.grey,
                                          thickness: 0.6,
                                        );
                                      },
                                    )),
                              ))
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 2),
                              child: GetBuilder(
                                init: roomSelectedController,
                                builder: ((controller) => ListView.separated(
                                      itemCount:
                                          controller.allStaffList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            // Get.toNamed(AppRoute.chat);
                                          },
                                          child: SizedBox(
                                            height: 80,
                                            width: double.maxFinite,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        height: 42,
                                                        width: 42,
                                                        decoration: BoxDecoration(
                                                            color:
                                                            AppColor.white,
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                20)),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(20),
                                                          child: const Image(
                                                            image: AssetImage(
                                                                AppAssets
                                                                    .dummyDp),
                                                            height: 50,
                                                            width: 50,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                          top: 26,
                                                          left: 26,
                                                          right: 0,
                                                          bottom: 0,
                                                          child:
                                                          SvgPicture.asset(
                                                            AppAssets
                                                                .activeIcon,
                                                            height: 16,
                                                            width: 16,
                                                          ))
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Flexible(
                                                      child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text("${controller
                                                          .allStaffList[
                                                      index]!
                                                          .firstName
                                                          .toString()} ${controller
                                                          .allStaffList[
                                                      index]!
                                                          .lastName
                                                          .toString()}",
                                                        style: GoogleFonts.poppins(
                                                            color: AppColor
                                                                .heavyTextColor,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const Icon(Icons
                                                          .arrow_forward_ios)
                                                    ],
                                                  ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const Divider(
                                          color: Colors.grey,
                                          thickness: 0.6,
                                        );
                                      },
                                    )),
                              )))
                      .toList()))
        ],
      ),
    );
  }
}

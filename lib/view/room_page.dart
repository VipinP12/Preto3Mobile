import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/room_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/app_string.dart';
import 'package:preto3/utils/argument_keys.dart';

import 'AdminModule/room_ratio.dart';

class RoomPage extends StatelessWidget {
  RoomPage({Key? key}) : super(key: key);

  final roomController = Get.find<RoomController>();

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
              Icons.add,
              color: Colors.white,
              size: 24,
            ),
          )
        ],
      ),
      body: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TabBar(
                tabs: roomController.myTabs,
                controller: roomController.tabController,
                labelColor: AppColor.appPrimary,
                indicatorColor: AppColor.appPrimary,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
              Expanded(
                  child: TabBarView(
                      controller: roomController.tabController,
                      children: roomController.myTabs
                          .map((Tab tab) => tab.text == AppString.roomList
                              ? roomController.isError.isTrue
                                  ? Center(
                                      child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                          roomController.errorMessage.value,
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
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 20),
                                      child: GetBuilder(
                                        init: roomController,
                                        builder: ((controller) =>
                                            ListView.separated(
                                              itemCount:
                                                  controller.allRoomList.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return InkWell(
                                                  onTap: () {
                                                        

                                                    if (controller
                                                            .roleId.value ==
                                                        2) {
                                                      Get.toNamed(
                                                          AppRoute.roomSelect,
                                                          arguments: {
                                                            ArgumentKeys
                                                                    .argumentRoleId:
                                                                controller
                                                                    .roleId
                                                                    .value,
                                                            ArgumentKeys
                                                                    .argumentSchoolId:
                                                                controller
                                                                    .schoolId
                                                                    .value,
                                                            ArgumentKeys
                                                                    .argumentClassId:
                                                                roomController
                                                                    .allRoomList[
                                                                        index]!
                                                                    .classId,
                                                                    ArgumentKeys.argumentClassName:roomController.allRoomList[index]!.className
                                                          });
                                                    } else {
                                                      Get.toNamed(
                                                          AppRoute.roomSelect,
                                                          arguments: {
                                                            ArgumentKeys
                                                                    .argumentRoleId:
                                                                controller
                                                                    .roleId
                                                                    .value,
                                                            ArgumentKeys
                                                                    .argumentSchoolId:
                                                                controller
                                                                    .schoolId
                                                                    .value,
                                                            ArgumentKeys
                                                                    .argumentClassId:
                                                                roomController
                                                                    .allRoomList[
                                                                        index]!
                                                                    .classId,
                                                                    ArgumentKeys.argumentClassName:roomController.allRoomList[index]!.className
                                                          });
                                                    }
                                                  },
                                                  child: SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.10,
                                                    width: double.maxFinite,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 16.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            height: 42,
                                                            width: 42,
                                                            decoration: BoxDecoration(
                                                                color: roomController
                                                                        .colors[
                                                                    roomController
                                                                        .random
                                                                        .nextInt(
                                                                            4)],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child: Center(
                                                                child: Text(
                                                              roomController
                                                                  .allRoomList[
                                                                      index]!
                                                                  .className
                                                                  .toString()[0],
                                                              style: GoogleFonts.poppins(
                                                                  color: AppColor
                                                                      .white,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            )),
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
                                                                roomController
                                                                    .allRoomList[
                                                                        index]!
                                                                    .className
                                                                    .toString(),
                                                                style: GoogleFonts.poppins(
                                                                    color: AppColor
                                                                        .heavyTextColor,
                                                                    fontSize:
                                                                        14,
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
                                                  (BuildContext context,
                                                      int index) {
                                                return const Divider(
                                                  color: Colors.grey,
                                                  thickness: 0.6,
                                                );
                                              },
                                            )),
                                      ))
                              : RoomRatioPage())
                          .toList()))
            ],
          )),
    );
  }
}

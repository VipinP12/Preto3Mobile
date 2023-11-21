import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:preto3/components/rounded_button.dart';
import 'package:preto3/controller/daily_activity_controller.dart';
import 'package:preto3/model/room_list_model.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/app_string.dart';
import 'package:preto3/utils/argument_keys.dart';
import 'package:preto3/utils/toast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DailyActivities extends StatelessWidget {
  DailyActivities({Key? key}) : super(key: key);

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
          AppString.dailyActivity,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: InkWell(
              onTap: () async {
                var flag = await Get.toNamed(AppRoute.addDailActivity);
                if (flag == "add") {
                  print("done");
                } else {
                  dailyController.refreshPage();
                }
              },
              child: dailyController.roleId.value == 4
                  ? const SizedBox.shrink()
                  : const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: InkWell(
              onTap: () {
                _bottomFilterDateSheet(context);
              },
              child: SvgPicture.asset(
                AppAssets.filterIcon,
                height: 24,
                width: 24,
              ),
            ),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: dailyController.refreshController,
        onRefresh: () {
          dailyController.refreshPageBySmartRefresher();
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
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(
                () => dailyController.notFound.value == true
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
                                dailyController.errorMessage.value.toString(),
                                style: GoogleFonts.poppins(
                                  color: AppColor.heavyTextColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          // Container(
                          //     height: 45,
                          //     width: double.maxFinite,
                          //     decoration: BoxDecoration(
                          //         color: AppColor.disableColor,
                          //         borderRadius: BorderRadius.circular(10)),
                          //     child: Form(
                          //       child: TextFormField(
                          //         keyboardType: TextInputType.text,
                          //         textInputAction: TextInputAction.next,
                          //         cursorColor: AppColor.appPrimary,
                          //         style: GoogleFonts.poppins(
                          //             color: AppColor.hintTextColor,
                          //             fontSize: 14,
                          //             fontWeight: FontWeight.w400),
                          //         onEditingComplete: () =>
                          //             FocusScope.of(context).unfocus(),
                          //         decoration: InputDecoration(
                          //             hintText: "Search",
                          //             helperStyle: GoogleFonts.poppins(
                          //                 color: AppColor.heavyTextColor,
                          //                 fontSize: 14,
                          //                 fontWeight: FontWeight.w400),
                          //             enabledBorder: InputBorder.none,
                          //             focusedBorder: const OutlineInputBorder(
                          //               borderSide: BorderSide.none,
                          //             ),
                          //             filled: true,
                          //             fillColor: Colors.transparent,
                          //             prefixIcon: const Icon(Icons.search)),
                          //         // controller: loginController.emailController,
                          //         onSaved: (savedValue) {
                          //           // loginController.emailController.text = savedValue!;
                          //           // loginController.email.value = savedValue!;
                          //         },
                          //       ),
                          //     )),
                          // const SizedBox(
                          //   height: 16,
                          // ),

                          GetBuilder<DailyActivityController>(
                            builder: (controller) => ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.dailyActivity.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 40,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                          color: AppColor.profileHeaderBG,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Obx(() => Text(
                                                  DateFormat('MM/dd/yyyy')
                                                      .format(DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                              controller
                                                                  .dailyActivity
                                                                  .value[index]
                                                                  .date))
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      color: AppColor
                                                          .heavyTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children:
                                            controller
                                                .dailyActivity[index].student
                                                .map((element) => InkWell(
                                                      onTap: () {
                                                        print(controller
                                                            .dailyActivity[
                                                                index]
                                                            .student);
                                                        Get.toNamed(
                                                            AppRoute
                                                                .dailActivityDetails,
                                                            arguments: {
                                                              ArgumentKeys
                                                                      .argumentDailyMap:
                                                                  element
                                                                      .activities,
                                                              ArgumentKeys
                                                                  .argumentDailyActivityDate: controller
                                                                          .dailyActivity[
                                                                              index]
                                                                          .date ==
                                                                      0
                                                                  ? DateFormat(
                                                                          'MM/dd/yyyy')
                                                                      .format(DateTime
                                                                          .now())
                                                                      .toString()
                                                                  : DateFormat(
                                                                          'MM/dd/yyyy')
                                                                      .format(DateTime.fromMillisecondsSinceEpoch(controller
                                                                          .dailyActivity[
                                                                              index]
                                                                          .date))
                                                                      .toString(),
                                                              ArgumentKeys
                                                                      .argumentDailyActivityName:
                                                                  '${element.firstName} ${element.lastName}',
                                                              ArgumentKeys
                                                                      .argumentDailyActivityPic:
                                                                  element
                                                                      .profilePic,
                                                              ArgumentKeys
                                                                      .argumentActivityImgUrls:
                                                                  element
                                                                      .activityImgUrls
                                                            });
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        0.0),
                                                                child: Row(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            42,
                                                                        width:
                                                                            42,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius: BorderRadius.circular(42)),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(42),
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            placeholder: (context, url) =>
                                                                                const Image(
                                                                              height: 42,
                                                                              width: 42,
                                                                              image: AssetImage(
                                                                                AppAssets.placeHolder,
                                                                              ),
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                            imageUrl:
                                                                                element.profilePic,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            errorWidget: (context, url, error) =>
                                                                                const Image(
                                                                              height: 42,
                                                                              width: 42,
                                                                              image: AssetImage(
                                                                                AppAssets.placeHolder,
                                                                              ),
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 8.0),
                                                                        child:
                                                                            Text(
                                                                          '${element.firstName} ${element.lastName}',
                                                                          style: GoogleFonts.poppins(
                                                                              color: AppColor.heavyTextColor,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                      )
                                                                    ]),
                                                              ),
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            5),
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .arrow_forward_ios_rounded,
                                                                  color: Colors
                                                                      .grey,
                                                                  size: 20,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        0.0,
                                                                    vertical:
                                                                        8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: element
                                                                  .activities
                                                                  .map((e) =>
                                                                      Container(
                                                                        margin: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                2),
                                                                        height:
                                                                            42,
                                                                        width:
                                                                            42,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                const Color(0xFF81AC4E),
                                                                            borderRadius: BorderRadius.circular(42)),
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          placeholder: (context, url) =>
                                                                              const Image(
                                                                            height:
                                                                                42,
                                                                            width:
                                                                                42,
                                                                            image:
                                                                                AssetImage(
                                                                              AppAssets.placeHolder,
                                                                            ),
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                          imageUrl:
                                                                              e.imageUrl,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          errorWidget: (context, url, error) =>
                                                                              const Image(
                                                                            height:
                                                                                42,
                                                                            width:
                                                                                42,
                                                                            image:
                                                                                AssetImage(
                                                                              AppAssets.placeHolder,
                                                                            ),
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ))
                                                                  .toSet()
                                                                  .toList(),
                                                            ),
                                                          ),
                                                          const Divider(
                                                            height: 20,
                                                            color: Colors.grey,
                                                            thickness: 0.2,
                                                          ),
                                                        ],
                                                      ),
                                                    ))
                                                .toList(),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => Container(
                                height: 0.1,
                              ),
                            ),
                          )
                        ],
                      ),
              )),
        ),
      ),
    );
  }

  void _bottomFilterDateSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        isDismissible: false,
        builder: (ctx) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setter) {
            return Container(
                height: dailyController.roleId.value == 4
                    ? MediaQuery.of(context).size.height * 0.6
                    : MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      topLeft: Radius.circular(5)),
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            topLeft: Radius.circular(5)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 54,
                            width: double.maxFinite,
                            decoration: const BoxDecoration(
                                color: AppColor.appPrimary,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  topLeft: Radius.circular(5),
                                )),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Apply filter",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Obx(() => Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: InkWell(
                                        onTap: () {
                                          dailyController
                                              .pickStartDate(context);
                                        },
                                        child: Container(
                                          height: 45,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              color: AppColor.disableColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0),
                                                child: SvgPicture.asset(
                                                    AppAssets.calenderIcon),
                                              ),
                                              Obx(() => dailyController
                                                      .selectedStartDate
                                                      .isNotEmpty
                                                  ? Text(
                                                      dailyController
                                                          .selectedStartDate
                                                          .toString(),
                                                      style: GoogleFonts.poppins(
                                                          color: AppColor
                                                              .heavyTextColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  : Text(
                                                      "Start Date",
                                                      style: GoogleFonts.poppins(
                                                          color: AppColor
                                                              .lightTextColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: InkWell(
                                        onTap: () {
                                          dailyController.pickEndDate(context);
                                        },
                                        child: Container(
                                          height: 45,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              color: AppColor.disableColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0),
                                                child: SvgPicture.asset(
                                                    AppAssets.calenderIcon),
                                              ),
                                              Obx(() => dailyController
                                                      .selectedEndDate
                                                      .isNotEmpty
                                                  ? Text(
                                                      dailyController
                                                          .selectedEndDate
                                                          .toString(),
                                                      style: GoogleFonts.poppins(
                                                          color: AppColor
                                                              .heavyTextColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  : Text(
                                                      "End Date",
                                                      style: GoogleFonts.poppins(
                                                          color: AppColor
                                                              .lightTextColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    dailyController.roleId.value == 4
                                        ? const SizedBox.shrink()
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Container(
                                                height: 45,
                                                width: double.maxFinite,
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppColor.disableColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: GetBuilder<
                                                    DailyActivityController>(
                                                  builder: (controller) =>
                                                      Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 16.0),
                                                    child: DropdownButton<
                                                        RoomListModel?>(
                                                      //elevation: 5,
                                                      hint: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          AppString.selectRoom,
                                                          style: GoogleFonts.poppins(
                                                              color: AppColor
                                                                  .lightTextColor,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                      isExpanded: true,
                                                      icon: Visibility(
                                                          visible: true,
                                                          child: SvgPicture
                                                              .asset(AppAssets
                                                                  .dropdownIcon)),
                                                      dropdownColor:
                                                          AppColor.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      iconEnabledColor:
                                                          AppColor.appPrimary,
                                                      underline: Container(),
                                                      alignment:
                                                          Alignment.topCenter,
                                                      items: controller
                                                          .allRoomList
                                                          .map((RoomListModel?
                                                                  room) =>
                                                              DropdownMenuItem<
                                                                      RoomListModel?>(
                                                                  value: room,
                                                                  child: Text(
                                                                    room!
                                                                        .className
                                                                        .toString(),
                                                                    style: GoogleFonts.poppins(
                                                                        color: AppColor
                                                                            .heavyTextColor,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  )))
                                                          .toList(),
                                                      onChanged: (changed) {
                                                        controller.setClassRoom(
                                                            changed!);
                                                        log("MY CLASS ROOM:${controller.room}");
                                                      },
                                                      value: controller.room,
                                                    ),
                                                  ),
                                                )),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: RoundedButton(
                                          height: 50,
                                          width: 320,
                                          color: AppColor.appPrimary,
                                          onClick: () {
                                            if (dailyController
                                                    .selectedStartDate.value
                                                    .trim()
                                                    .isEmpty &&
                                                dailyController.selectedEndDate
                                                    .trim()
                                                    .isEmpty) {
                                              Get.back();
                                              dailyController.getAllActivity(
                                                  dailyController
                                                      .schoolId.value,
                                                  dailyController.roleId.value);

                                              return;
                                            } else if (dailyController
                                                .selectedStartDate.value
                                                .trim()
                                                .isEmpty) {
                                              messageToastWarning(context,
                                                  "Start date can't be empty.");
                                              return;
                                            } else if (dailyController
                                                .selectedEndDate
                                                .trim()
                                                .isEmpty) {
                                              dailyController
                                                  .setFilterEndDate();
                                            }
                                            if (dailyController.dateDifference(
                                                dailyController
                                                    .selectedStartDate.value,
                                                dailyController
                                                    .selectedEndDate.value)) {
                                              Get.back();
                                              dailyController
                                                  .filterActivitySession();
                                            } else {
                                              dailyController
                                                  .selectedStartDate.value = "";
                                              dailyController
                                                  .selectedEndDate.value = "";
                                              dailyController.update();
                                              messageToastWarning(context,
                                                  "Date filter is not correct");
                                            }
                                          },
                                          text: 'Apply',
                                          style: GoogleFonts.poppins(
                                              color: AppColor.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400)),
                                    )
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 10,
                      child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset(AppAssets.closeFilterIcon)),
                    )
                  ],
                ));
          });
        });
  }
}

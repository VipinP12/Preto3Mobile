import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/components/rounded_button.dart';
import 'package:preto3/controller/TimeClock/time_clock_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/toast.dart';

class CheckInChildPage extends StatelessWidget {
  CheckInChildPage({Key? key}) : super(key: key);

  final timeController = Get.find<TimeClockController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (timeController.allowPop) {
          Get.offAndToNamed(AppRoute.timeClock);
          return true;
        }
        return false;
        // return Future.value(timeController.allowPop);
      },
      child: Scaffold(
        backgroundColor: AppColor.scaffoldBackground,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColor.appPrimary,
            leading: InkWell(
              onTap: () => {Get.offAndToNamed(AppRoute.timeClock)},
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
            title: Container(
              // padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
              margin: const EdgeInsets.only(
                  top: 10, left: 40, right: 40, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: const Image(
                                  image: AssetImage(AppAssets.appLogo)))),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              timeController.clockTime.value,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                          Obx(() => Text(
                                timeController.selectedDate.value,
                                style: const TextStyle(fontSize: 10),
                              ))
                        ],
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      timeController.storageBox.erase();
                      Get.offAndToNamed(AppRoute.login);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.timeClockLogout,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Log out",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: AppColor.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                  () => timeController.childrenList.isNotEmpty
                      ? Column(
                          children: [
                            Container(
                              height: 42,
                              width: double.maxFinite,
                              margin: const EdgeInsets.only(
                                  top: 16, right: 16, left: 16),
                              decoration: BoxDecoration(
                                  color: AppColor.dashRoomBg,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Select Staff:",
                                    style: GoogleFonts.poppins(
                                        color: AppColor.heavyTextColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                            GetBuilder<TimeClockController>(
                                builder: (controller) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 8.0),
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        children: controller.childrenList
                                            .asMap()
                                            .entries
                                            .map(
                                              (element) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    element.value.isSelected =
                                                        !element
                                                            .value.isSelected;
                                                    controller
                                                        .setchildrenListIdList(
                                                            element.key);
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        height: 65,
                                                        width: 65,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        65)),
                                                        child:
                                                            element.value
                                                                    .isSelected
                                                                ? Stack(
                                                                    children: [
                                                                      CachedNetworkImage(
                                                                        placeholder:
                                                                            (context, url) =>
                                                                                const Image(
                                                                          height:
                                                                              65,
                                                                          width:
                                                                              65,
                                                                          image:
                                                                              AssetImage(
                                                                            AppAssets.placeHolder,
                                                                          ),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                        imageUrl: element
                                                                            .value
                                                                            .userProfilePic,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        errorWidget: (context,
                                                                                url,
                                                                                error) =>
                                                                            const Image(
                                                                          height:
                                                                              65,
                                                                          width:
                                                                              65,
                                                                          image:
                                                                              AssetImage(
                                                                            AppAssets.placeHolder,
                                                                          ),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                      SvgPicture.asset(
                                                                          AppAssets
                                                                              .checkInSelectedIcon),
                                                                      // Positioned(
                                                                      //     bottom: 0,
                                                                      //     right: 0,
                                                                      //     child: Container(
                                                                      //       height: 15,
                                                                      //       width: 15,
                                                                      //       decoration:
                                                                      //           BoxDecoration(
                                                                      //               borderRadius:
                                                                      //                   BorderRadius.circular(
                                                                      //                       15),
                                                                      //               color: Colors
                                                                      //                   .grey,
                                                                      //               //color: Colors.green,
                                                                      //               border: Border.all(
                                                                      //                   color: AppColor
                                                                      //                       .white,
                                                                      //                   width:
                                                                      //                       1.5)),
                                                                      //     )),
                                                                    ],
                                                                  )
                                                                : Stack(
                                                                    children: [
                                                                      CachedNetworkImage(
                                                                        placeholder:
                                                                            (context, url) =>
                                                                                const Image(
                                                                          height:
                                                                              65,
                                                                          width:
                                                                              65,
                                                                          image:
                                                                              AssetImage(
                                                                            AppAssets.placeHolder,
                                                                          ),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                        imageUrl: element
                                                                            .value
                                                                            .userProfilePic,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        errorWidget: (context,
                                                                                url,
                                                                                error) =>
                                                                            const Image(
                                                                          height:
                                                                              65,
                                                                          width:
                                                                              65,
                                                                          image:
                                                                              AssetImage(
                                                                            AppAssets.placeHolder,
                                                                          ),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                      // Positioned(
                                                                      //     bottom: 0,
                                                                      //     right: 0,
                                                                      //     child: Container(
                                                                      //       height: 15,
                                                                      //       width: 15,
                                                                      //       decoration:
                                                                      //           BoxDecoration(
                                                                      //               borderRadius:
                                                                      //                   BorderRadius.circular(
                                                                      //                       15),
                                                                      //               color: Colors
                                                                      //                   .grey,
                                                                      //               //color: Colors.green,
                                                                      //               border: Border.all(
                                                                      //                   color: AppColor
                                                                      //                       .white,
                                                                      //                   width:
                                                                      //                       1.5)),
                                                                      //     )),
                                                                    ],
                                                                  ),
                                                      ),
                                                      Text(
                                                        "${element.value.firstName} ${element.value.lastName}",
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
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    )),
                            const SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: RoundedButton(
                                  height: 42,
                                  width: 180,
                                  color: AppColor.appPrimary,
                                  onClick: () {
                                    if (timeController.idListStaff.isNotEmpty) {
                                      timeController.checkInMultiStaff(context);
                                    } else {
                                      messageToastWarning(context,
                                          "Please select a staff. If you have already checked out all staff, you can go back to the previous screen.");
                                    }
                                  },
                                  text: 'Submit',
                                  style: GoogleFonts.poppins(
                                      color: AppColor.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      : Container(),
                ),
                Obx(
                  () => timeController.studentList.isNotEmpty
                      ? Column(
                          children: [
                            Container(
                              height: 42,
                              width: double.maxFinite,
                              margin: const EdgeInsets.only(
                                  top: 16, right: 16, left: 16),
                              decoration: BoxDecoration(
                                  color: AppColor.dashRoomBg,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Select Child:",
                                    style: GoogleFonts.poppins(
                                        color: AppColor.heavyTextColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                            GetBuilder<TimeClockController>(
                                builder: (controller) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 8.0),
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        children: controller.studentList
                                            .asMap()
                                            .entries
                                            .map(
                                              (element) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    if (controller
                                                            .studentList[
                                                                element.key]
                                                            .checkedInOutStatus ==
                                                        "Checked-Out") {
                                                      return;
                                                    }
                                                    if (controller.idListStudent
                                                        .isNotEmpty) {
                                                      var myListFiltered = controller
                                                          .studentList
                                                          .where((e) =>
                                                              e.id.toString() ==
                                                              controller
                                                                  .idListStudent[
                                                                      0]
                                                                  .split("_")[0]
                                                                  .toString());
                                                      if (myListFiltered
                                                          .isNotEmpty) {
                                                        if (myListFiltered.first
                                                                .checkedInOutStatus !=
                                                            controller
                                                                .studentList[
                                                                    element.key]
                                                                .checkedInOutStatus) {
                                                          return;
                                                        }
                                                      }
                                                      controller
                                                              .studentList[
                                                                  element.key]
                                                              .isSelected =
                                                          !controller
                                                              .studentList[
                                                                  element.key]
                                                              .isSelected;
                                                      controller
                                                          .setstudentListIdList(
                                                              element.key);
                                                    } else {
                                                      controller
                                                              .studentList[
                                                                  element.key]
                                                              .isSelected =
                                                          !controller
                                                              .studentList[
                                                                  element.key]
                                                              .isSelected;
                                                      controller
                                                          .setstudentListIdList(
                                                              element.key);
                                                    }
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        height: 65,
                                                        width: 65,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        65)),
                                                        child: controller
                                                                .studentList[
                                                                    element.key]
                                                                .isSelected
                                                            ? Stack(
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            65),
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      placeholder:
                                                                          (context, url) =>
                                                                              const Image(
                                                                        height:
                                                                            65,
                                                                        width:
                                                                            65,
                                                                        image:
                                                                            AssetImage(
                                                                          AppAssets
                                                                              .placeHolder,
                                                                        ),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      imageUrl: element
                                                                          .value
                                                                          .profilePic,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          const Image(
                                                                        height:
                                                                            65,
                                                                        width:
                                                                            65,
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
                                                                          .checkInSelectedIcon),
                                                                  Positioned(
                                                                      bottom: 0,
                                                                      right: 0,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            15,
                                                                        width:
                                                                            15,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(15),
                                                                            color: controller.studentList[element.key].checkedInOutStatus == "Checked-In"
                                                                                ? Colors.green
                                                                                : controller.studentList[element.key].checkedInOutStatus == "Absent"
                                                                                    ? Colors.red
                                                                                    : Colors.grey,
                                                                            //color: Colors.green,
                                                                            border: Border.all(color: AppColor.white, width: 1.5)),
                                                                      )),
                                                                ],
                                                              )
                                                            : Stack(
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            65),
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      placeholder:
                                                                          (context, url) =>
                                                                              const Image(
                                                                        height:
                                                                            65,
                                                                        width:
                                                                            65,
                                                                        image:
                                                                            AssetImage(
                                                                          AppAssets
                                                                              .placeHolder,
                                                                        ),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      height:
                                                                          65,
                                                                      width: 65,
                                                                      imageUrl: controller
                                                                          .studentList[
                                                                              element.key]
                                                                          .profilePic,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          const Image(
                                                                        height:
                                                                            65,
                                                                        width:
                                                                            65,
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
                                                                  Positioned(
                                                                      bottom: 0,
                                                                      right: 0,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            15,
                                                                        width:
                                                                            15,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(15),
                                                                            color: controller.studentList[element.key].checkedInOutStatus == "Checked-In"
                                                                                ? Colors.green
                                                                                : controller.studentList[element.key].checkedInOutStatus == "Absent"
                                                                                    ? Colors.red
                                                                                    : Colors.grey,
                                                                            //color: Colors.green,
                                                                            border: Border.all(color: AppColor.white, width: 1.5)),
                                                                      )),
                                                                ],
                                                              ),
                                                      ),
                                                      Text(
                                                        "${element.value.firstName} ${element.value.lastName}",
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
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    )),
                            const SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: RoundedButton(
                                  height: 42,
                                  width: 180,
                                  color: AppColor.appPrimary,
                                  onClick: () {
                                    if (timeController
                                        .idListStudent.isNotEmpty) {
                                      timeController
                                          .checkInMultiStudent(context);
                                    } else {
                                      messageToastWarning(context,
                                          "Please select a student or child. If you have already checked out all students or children, you can go back to the previous screen.");
                                    }
                                  },
                                  text: 'Submit',
                                  style: GoogleFonts.poppins(
                                      color: AppColor.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  successInDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                height: 150,
                width: 300,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: SvgPicture.asset(AppAssets.successIcon)),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Successfully Checked In!',
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      InkWell(
                        onTap: () => Get.offAllNamed(AppRoute.timeClock),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'OK',
                            style: GoogleFonts.poppins(
                                color: AppColor.appPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  successOutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                height: 150,
                width: 300,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: SvgPicture.asset(AppAssets.successIcon)),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Successfully Checked Out!',
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      InkWell(
                        onTap: () => Get.offAllNamed(AppRoute.timeClock),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'OK',
                            style: GoogleFonts.poppins(
                                color: AppColor.appPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}

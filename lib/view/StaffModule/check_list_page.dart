import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/checkin_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/app_string.dart';
import 'package:preto3/utils/argument_keys.dart';

class CheckListPage extends StatelessWidget {
  CheckListPage({Key? key}) : super(key: key);

  final checkInController = Get.find<CheckInController>();

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
          AppString.studentCheckIn,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  checkInController.pickDate(context);
                },
                child: Container(
                  height: 40,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: AppColor.dashRoomBg,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppAssets.calenderIcon),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Obx(() => Text(
                                checkInController.selectedDate.value,
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            GetBuilder<CheckInController>(
              builder: (controller) => ListView.separated(
                itemCount: controller.checkList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 16),
                    child: Container(
                      height: 140,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: 65,
                                          width: 65,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(65),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(65),
                                            child: CachedNetworkImage(
                                              placeholder: (context, url) =>
                                                  const Image(
                                                height: 65,
                                                width: 65,
                                                image: AssetImage(
                                                  AppAssets.placeHolder,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              imageUrl:
                                                  '${controller.checkList[index].profilePic}',
                                              fit: BoxFit.cover,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Image(
                                                height: 65,
                                                width: 65,
                                                image: AssetImage(
                                                  AppAssets.placeHolder,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            bottom: 2,
                                            right: 2,
                                            child: Container(
                                              height: 15,
                                              width: 15,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: controller
                                                              .checkList[index]
                                                              .status ==
                                                          "Checked in"
                                                      ? Colors.green
                                                      : controller
                                                                  .checkList[
                                                                      index]
                                                                  .status ==
                                                              "Checked out"
                                                          ? Colors.grey
                                                          : Colors.red,
                                                  border: Border.all(
                                                      color: AppColor.white,
                                                      width: 1.5)),
                                            ))
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${controller.checkList[index].firstName} ${controller.checkList[index].lastName}",
                                            style: GoogleFonts.poppins(
                                                color: AppColor.heavyTextColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            controller
                                                .checkList[index].className,
                                            style: GoogleFonts.poppins(
                                                color: AppColor.heavyTextColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "In time",
                                      style: GoogleFonts.poppins(
                                          color: AppColor.heavyTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text("   -"),
                                    ),
                                    Text(
                                      checkInController
                                          .checkList[index].checkInTime,
                                      style: GoogleFonts.poppins(
                                          color: AppColor.heavyTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Out time",
                                      style: GoogleFonts.poppins(
                                          color: AppColor.heavyTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text("-"),
                                    ),
                                    Text(
                                      checkInController
                                          .checkList[index].checkOutTime,
                                      style: GoogleFonts.poppins(
                                          color: AppColor.heavyTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: InkWell(
                                onTap: () {
                                  checkInController.storageBox
                                      .write(AppKeys.keyEditCheckIn, true);
                                  Get.toNamed(AppRoute.editCheckIn, arguments: {
                                    ArgumentKeys.argumentChildDate:
                                        checkInController.selectedDate.value,
                                    ArgumentKeys.argumentCheckInId:
                                        checkInController.checkList[index].id,
                                    ArgumentKeys.argumentChildFirstName:
                                        checkInController
                                            .checkList[index].firstName,
                                    ArgumentKeys.argumentChildLastName:
                                        checkInController
                                            .checkList[index].lastName,
                                    ArgumentKeys.argumentChildProfilePic:
                                        checkInController
                                            .checkList[index].profilePic,
                                    ArgumentKeys.argumentClassRoom:
                                        checkInController
                                            .checkList[index].className,
                                    ArgumentKeys.argumentInTime:
                                        checkInController
                                            .checkList[index].checkInTime,
                                    ArgumentKeys.argumentOutTime:
                                        checkInController
                                            .checkList[index].checkOutTime,
                                    ArgumentKeys.argumentRemark:
                                        checkInController
                                            .checkList[index].checkInRemarks,
                                    ArgumentKeys.argumentStatus:
                                        checkInController
                                            .checkList[index].status,
                                  });
                                },
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child:
                                        SvgPicture.asset(AppAssets.editIcon)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  color: AppColor.borderColor,
                  height: 1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

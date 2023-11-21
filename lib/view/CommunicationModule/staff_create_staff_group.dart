import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/components/rounded_button.dart';
import 'package:preto3/controller/Communication/communication_controller.dart';

import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_dimens.dart';
import 'package:preto3/utils/app_string.dart';
import 'package:preto3/utils/toast.dart';

import '../../utils/app_routes.dart';

class StaffCreateStaffGroup extends StatelessWidget {
  StaffCreateStaffGroup({Key? key}) : super(key: key);

  final communicationController = Get.find<CommunicationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColor.appPrimary,
        leading: InkWell(
          onTap: () => Get.back(result: false),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
        ),
        centerTitle: false,
        title: Text(
          "${AppString.selectStaff}s",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: const [
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 4.0),
          //   child: Icon(
          //     Icons.search,
          //     color: Colors.white,
          //     size: 24,
          //   ),
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            // Container(
            //   height: 45,
            //   width: double.maxFinite,
            //   decoration: BoxDecoration(
            //       color: AppColor.disableColor,
            //       borderRadius: BorderRadius.circular(10)),
            //   child: TextFormField(
            //     keyboardType: TextInputType.text,
            //     textInputAction: TextInputAction.next,
            //     cursorColor: AppColor.appPrimary,
            //     style: GoogleFonts.poppins(
            //         color: AppColor.hintTextColor,
            //         fontSize: 14,
            //         fontWeight: FontWeight.w400),
            //     onEditingComplete: () => FocusScope.of(context).unfocus(),
            //     decoration: InputDecoration(
            //       hintText: "search room",
            //       helperStyle: GoogleFonts.poppins(
            //           color: AppColor.lightTextColor,
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400),
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10),
            //         borderSide: const BorderSide(color: AppColor.borderColor),
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10),
            //         borderSide: const BorderSide(color: AppColor.appPrimary),
            //       ),
            //       prefixIcon: SvgPicture.asset(
            //         AppAssets.searchIconGrey,
            //         height: 30,
            //         width: 30,
            //         fit: BoxFit.scaleDown,
            //       ),
            //       contentPadding: EdgeInsets.zero,
            //       filled: true,
            //       fillColor: AppColor.disableColor,
            //     ),
            //     controller: communicationController.searchStaffController,
            //     onChanged: (savedValue) {
            //       communicationController.searchStaff.value = savedValue;
            //     },
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Staffs",
                  style: GoogleFonts.poppins(
                      color: AppColor.appPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.start,
                )),
            const SizedBox(
              height: AppDimens.paddingVertical16,
            ),
            Expanded(
              child: GetBuilder<CommunicationController>(
                builder: (controller) => GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2 / 2,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 20),
                    itemCount: controller.staffCommList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 4),
                        child: InkWell(
                          onTap: () {
                            log("On Tap $index");
                            controller.staffCommList[index].isSelected =
                                !controller.staffCommList[index].isSelected;
                            controller.staffUsernameList
                                .add(controller.staffCommList[index].userName);
                            controller.staffIdList
                                .add(controller.staffCommList[index].staffId);
                            controller.update();
                          },
                          child: Container(
                            height: 120,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(60),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 6.0,
                                            spreadRadius: 2.0,
                                            offset: Offset(0.0, 0.0))
                                      ]),
                                  child: controller
                                          .staffCommList[index].isSelected
                                      ? Stack(
                                          children: [
                                            Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  color: AppColor.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          60)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                                child: CachedNetworkImage(
                                                  placeholder: (context, url) =>
                                                      const Image(
                                                    height: 60,
                                                    width: 60,
                                                    image: AssetImage(
                                                      AppAssets.placeHolder,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  imageUrl:
                                                      '${controller.staffCommList[index].profilePic}',
                                                  fit: BoxFit.cover,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Image(
                                                    height: 60,
                                                    width: 60,
                                                    image: AssetImage(
                                                      AppAssets.placeHolder,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SvgPicture.asset(
                                                AppAssets.checkInSelectedIcon)
                                          ],
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          child: CachedNetworkImage(
                                            placeholder: (context, url) =>
                                                const Image(
                                              height: 60,
                                              width: 60,
                                              image: AssetImage(
                                                AppAssets.placeHolder,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            imageUrl:
                                                '${controller.staffCommList[index].profilePic}',
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Image(
                                              height: 60,
                                              width: 60,
                                              image: AssetImage(
                                                AppAssets.placeHolder,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 4),
                                  child: Center(
                                    child: Text(
                                      "${controller.staffCommList[index].firstName.toString()} ${controller.staffCommList[index].lastName.toString()}",
                                      style: GoogleFonts.poppins(
                                          color: AppColor.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            RoundedButton(
                height: 50,
                width: 320,
                color: AppColor.appPrimary,
                onClick: () async {
                  communicationController.showLoading();
                  communicationController.userCount.value = 0;
                  communicationController.userNameList.value = [];
                  communicationController.messageController.text = "";
                  bool flag = false;
                  try {
                    for (int i = 0;
                        i < communicationController.staffCommList.length;
                        i++) {
                      if (communicationController.staffCommList[i].isSelected) {
                        flag = true;
                        communicationController.userCount.value++;
                        if (communicationController.userNameList.value.length <
                            5) {
                          communicationController.userNameList.value.add(
                              communicationController
                                  .staffCommList.value[i].firstName
                                  .trim()[0]);
                        }
                      }
                    }
                  } catch (e) {
                    print(e);
                    communicationController.hideLoading();
                  }
                  communicationController.hideLoading();
                  if (flag) {
                    communicationController.flagCreateRoom.value = 2;
                    communicationController.update();
                    if (await Get.toNamed(AppRoute.createGroupPreview)) {
                      Get.back(result: true);
                    }
                  } else {
                    messageToastWarning(context, "Please select staff");
                  }
                  communicationController.hideLoading();
                },
                text: 'Next',
                style: GoogleFonts.poppins(
                    color: AppColor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
            const SizedBox(
              height: AppDimens.paddingVertical16,
            ),
          ],
        ),
      ),
    );
  }
}

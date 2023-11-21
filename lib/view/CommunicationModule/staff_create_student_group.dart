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
import '../../utils/app_routes.dart';
import '../../utils/toast.dart';

class CreateStudentGroup extends StatelessWidget {
  CreateStudentGroup({Key? key}) : super(key: key);

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
          AppString.selectStudent,
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: AppDimens.paddingVertical16,
            ),
            Expanded(
              child: GetBuilder<CommunicationController>(
                  builder: (controller) => controller.studentCommList.isNotEmpty
                      ? GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 2 / 2,
                                  crossAxisSpacing: 4,
                                  mainAxisSpacing: 20),
                          itemCount: controller.studentCommList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 4),
                              child: InkWell(
                                onTap: () {
                                  log("On Tap $index");
                                  // controller.studentUsernameList.clear();
                                  // controller.studentIdList.clear();
                                  controller.studentCommList[index].isSelected =
                                      !controller
                                          .studentCommList[index].isSelected;
                                  for (var element in controller
                                      .studentCommList[index].parentDetails) {
                                    controller.studentUsernameList
                                        .add(element.userName);
                                  }
                                  controller.studentIdList.add(
                                      controller.studentCommList[index].id);
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(60),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 6.0,
                                                  spreadRadius: 2.0,
                                                  offset: Offset(0.0, 0.0))
                                            ]),
                                        child: controller.studentCommList[index]
                                                .isSelected
                                            ? Stack(
                                                children: [
                                                  Container(
                                                    height: 60,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                        color: AppColor.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(60)),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              60),
                                                      child: CachedNetworkImage(
                                                        placeholder:
                                                            (context, url) =>
                                                                const Image(
                                                          height: 60,
                                                          width: 60,
                                                          image: AssetImage(
                                                            AppAssets
                                                                .placeHolder,
                                                          ),
                                                          fit: BoxFit.cover,
                                                        ),
                                                        imageUrl:
                                                            '${controller.studentCommList[index].profilePic}',
                                                        fit: BoxFit.cover,
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Image(
                                                          height: 60,
                                                          width: 60,
                                                          image: AssetImage(
                                                            AppAssets
                                                                .placeHolder,
                                                          ),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SvgPicture.asset(AppAssets
                                                      .checkInSelectedIcon)
                                                ],
                                              )
                                            : ClipOval(
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
                                                      '${controller.studentCommList[index].profilePic}',
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
                                            controller.studentCommList[index]
                                                .studentFullName
                                                .toString(),
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
                          })
                      : const Center(
                          child: Text("No student assigned in this room."),
                        )),
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
                  for (int i = 0;
                      i < communicationController.studentCommList.value.length;
                      i++) {
                    if (communicationController
                        .studentCommList.value[i].isSelected) {
                      flag = true;
                      try {
                        communicationController.userCount.value++;
                        if (communicationController.userNameList.value.length <
                            6) {
                          communicationController.userNameList.value.add(
                              communicationController
                                  .studentCommList.value[i].studentFullName
                                  .trim()[0]);
                        }
                      } catch (e) {
                        log(e.toString());
                      }
                    }
                  }
                  communicationController.hideLoading();
                  if (flag) {
                    communicationController.flagCreateRoom.value = 1;
                    communicationController.update();
                    if (await Get.toNamed(AppRoute.createGroupPreview)) {
                      Get.back(result: true);
                    }
                  } else {
                    communicationController.hideLoading();
                    messageToastWarning(context,
                        "Please select children then you can continue");
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

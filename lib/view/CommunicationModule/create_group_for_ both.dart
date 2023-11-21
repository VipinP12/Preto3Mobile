import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/components/rounded_button.dart';
import 'package:preto3/controller/Communication/create_group_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_dimens.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/app_string.dart';
import 'package:preto3/utils/toast.dart';

import '../../controller/Communication/communication_controller.dart';

class CreateGroupForBoth extends StatelessWidget {
  CreateGroupForBoth({Key? key}) : super(key: key);

  final createGroupController = Get.find<CreateGroupController>();
  final commController = Get.find<CommunicationController>();
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
          AppString.selectMembers,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TabBar(
            tabs: createGroupController.myTabs,
            controller: createGroupController.tabController,
            labelColor: AppColor.appPrimary,
            indicatorColor: AppColor.appPrimary,
            unselectedLabelColor: Colors.grey,
            labelStyle:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Expanded(
              child: TabBarView(
                  controller: createGroupController.tabController,
                  children: createGroupController.myTabs
                      .map(
                        (Tab tab) => tab.text == AppString.tabStudent
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 2),
                                child: SizedBox(
                                  height: 240,
                                  width: double.maxFinite,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Obx(
                                            () => Checkbox(
                                              value: createGroupController
                                                  .isSelectedStudent.value,
                                              checkColor: AppColor.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              onChanged: (changed) {
                                                createGroupController
                                                        .isSelectedStudent
                                                        .value =
                                                    !createGroupController
                                                        .isSelectedStudent
                                                        .value;
                                                if (createGroupController
                                                    .isSelectedStudent.value) {
                                                  for (int i = 0;
                                                      i <
                                                          createGroupController
                                                              .studentList
                                                              .value
                                                              .length;
                                                      i++) {
                                                    createGroupController
                                                        .studentList
                                                        .value[i]
                                                        .isSelected = true;
                                                    createGroupController
                                                        .studentSelectList.value
                                                        .add(
                                                            createGroupController
                                                                .studentList
                                                                .value[i]);
                                                  }
                                                } else {
                                                  for (int i = 0;
                                                      i <
                                                          createGroupController
                                                              .studentList
                                                              .value
                                                              .length;
                                                      i++) {
                                                    createGroupController
                                                        .studentList
                                                        .value[i]
                                                        .isSelected = false;
                                                  }
                                                  createGroupController
                                                      .studentSelectList
                                                      .value = [];
                                                }
                                                createGroupController.update();
                                                print("CHECKED ALL:$changed");
                                              },
                                            ),
                                          ),
                                          const Text("Select All"),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: AppDimens.paddingVertical16,
                                      ),
                                      Expanded(
                                          child: Stack(
                                        children: [
                                          GetBuilder<CreateGroupController>(
                                            builder: (controller) =>
                                                GridView.builder(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 60),
                                                    shrinkWrap: true,
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 3,
                                                            childAspectRatio:
                                                                2 / 2,
                                                            crossAxisSpacing: 0,
                                                            mainAxisSpacing:
                                                                16),
                                                    itemCount: controller
                                                        .studentList.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 0.0,
                                                                horizontal: 4),
                                                        child: InkWell(
                                                          onTap: () {
                                                            controller
                                                                    .studentList[
                                                                        index]
                                                                    .isSelected =
                                                                !controller
                                                                    .studentList[
                                                                        index]
                                                                    .isSelected;
                                                            if (controller
                                                                .studentList[
                                                                    index]
                                                                .isSelected) {
                                                              controller
                                                                  .studentSelectList
                                                                  .add(controller
                                                                          .studentList[
                                                                      index]);
                                                            } else {
                                                              controller
                                                                  .studentSelectList
                                                                  .remove(controller
                                                                      .studentList
                                                                      .value[index]);
                                                            }
                                                            controller.update();
                                                          },
                                                          child: Container(
                                                            height: 120,
                                                            width: 80,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              150),
                                                                  child:
                                                                      Container(
                                                                    height: 65,
                                                                    width: 65,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(65),
                                                                        boxShadow: const [
                                                                          BoxShadow(
                                                                              color: Colors.black26,
                                                                              blurRadius: 6.0,
                                                                              spreadRadius: 2.0,
                                                                              offset: Offset(0.0, 0.0))
                                                                        ]),
                                                                    child: controller
                                                                            .studentList[index]
                                                                            .isSelected
                                                                        ? Stack(
                                                                            children: [
                                                                              CachedNetworkImage(
                                                                                placeholder: (context, url) => const Image(
                                                                                  height: 65,
                                                                                  width: 65,
                                                                                  image: AssetImage(
                                                                                    AppAssets.placeHolder,
                                                                                  ),
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                                imageUrl: '${controller.studentList[index].profilePic}',
                                                                                fit: BoxFit.cover,
                                                                                errorWidget: (context, url, error) => const Image(
                                                                                  height: 65,
                                                                                  width: 65,
                                                                                  image: AssetImage(
                                                                                    AppAssets.placeHolder,
                                                                                  ),
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                              SvgPicture.asset(AppAssets.checkInSelectedIcon)
                                                                            ],
                                                                          )
                                                                        : CachedNetworkImage(
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
                                                                                '${controller.studentList[index].profilePic}',
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            errorWidget: (context, url, error) =>
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
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          0.0,
                                                                      horizontal:
                                                                          4),
                                                                  child: Center(
                                                                    child: Text(
                                                                      '${controller.studentList[index].studentFullName.toString()} ',
                                                                      style: GoogleFonts.poppins(
                                                                          color: AppColor
                                                                              .black,
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          2,
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
                                        ],
                                      )),
                                    ],
                                  ),
                                ))
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 2),
                                child: SizedBox(
                                  height: 240,
                                  width: double.maxFinite,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Obx(
                                            () => Checkbox(
                                              value: createGroupController
                                                  .isSelectedStaff.value,
                                              checkColor: AppColor.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              onChanged: (changed) {
                                                createGroupController
                                                        .isSelectedStaff.value =
                                                    !createGroupController
                                                        .isSelectedStaff.value;
                                                if (createGroupController
                                                    .isSelectedStaff.value) {
                                                  createGroupController
                                                      .staffSelectList
                                                      .value = [];
                                                  for (int i = 0;
                                                      i <
                                                          createGroupController
                                                              .staffList
                                                              .value
                                                              .length;
                                                      i++) {
                                                    createGroupController
                                                        .staffList
                                                        .value[i]
                                                        .isSelected = true;
                                                    createGroupController
                                                        .staffSelectList.value
                                                        .add(
                                                            createGroupController
                                                                .staffList
                                                                .value[i]);
                                                  }
                                                } else {
                                                  for (int i = 0;
                                                      i <
                                                          createGroupController
                                                              .staffList
                                                              .value
                                                              .length;
                                                      i++) {
                                                    createGroupController
                                                        .staffList
                                                        .value[i]
                                                        .isSelected = false;
                                                  }
                                                  createGroupController
                                                      .staffSelectList
                                                      .value = [];
                                                }
                                                createGroupController.update();
                                                print("CHECKED ALL:$changed");
                                              },
                                            ),
                                          ),
                                          const Text("Select All"),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: AppDimens.paddingVertical16,
                                      ),
                                      Expanded(
                                          child: Stack(
                                        children: [
                                          GetBuilder<CreateGroupController>(
                                            builder: (controller) =>
                                                GridView.builder(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 60),
                                                    shrinkWrap: true,
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 3,
                                                            childAspectRatio:
                                                                2 / 2,
                                                            crossAxisSpacing: 3,
                                                            mainAxisSpacing:
                                                                16),
                                                    itemCount: controller
                                                        .staffList.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 0.0,
                                                                horizontal: 4),
                                                        child: InkWell(
                                                          onTap: () {
                                                            controller
                                                                    .staffList[
                                                                        index]
                                                                    .isSelected =
                                                                !controller
                                                                    .staffList[
                                                                        index]
                                                                    .isSelected;
                                                            if (controller
                                                                .staffList[
                                                                    index]
                                                                .isSelected) {
                                                              controller
                                                                  .staffSelectList
                                                                  .add(controller
                                                                      .staffList
                                                                      .value[index]);
                                                            } else {
                                                              controller
                                                                  .staffSelectList
                                                                  .remove(controller
                                                                      .staffList
                                                                      .value[index]);
                                                            }
                                                            controller.update();
                                                          },
                                                          child: Container(
                                                            height: 120,
                                                            width: 80,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              150),
                                                                  child:
                                                                      Container(
                                                                    height: 65,
                                                                    width: 65,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(65),
                                                                        boxShadow: const [
                                                                          BoxShadow(
                                                                              color: Colors.black26,
                                                                              blurRadius: 6.0,
                                                                              spreadRadius: 2.0,
                                                                              offset: Offset(0.0, 0.0))
                                                                        ]),
                                                                    child: controller
                                                                            .staffList[index]
                                                                            .isSelected
                                                                        ? Stack(
                                                                            children: [
                                                                              CachedNetworkImage(
                                                                                placeholder: (context, url) => const Image(
                                                                                  height: 75,
                                                                                  width: 75,
                                                                                  image: AssetImage(
                                                                                    AppAssets.placeHolder,
                                                                                  ),
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                                imageUrl: '${controller.staffList[index].profilePic}',
                                                                                fit: BoxFit.cover,
                                                                                errorWidget: (context, url, error) => const Image(
                                                                                  height: 75,
                                                                                  width: 75,
                                                                                  image: AssetImage(
                                                                                    AppAssets.placeHolder,
                                                                                  ),
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                              SvgPicture.asset(AppAssets.checkInSelectedIcon)
                                                                            ],
                                                                          )
                                                                        : CachedNetworkImage(
                                                                            placeholder: (context, url) =>
                                                                                const Image(
                                                                              height: 75,
                                                                              width: 75,
                                                                              image: AssetImage(
                                                                                AppAssets.placeHolder,
                                                                              ),
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                            imageUrl:
                                                                                '${controller.staffList[index].profilePic}',
                                                                            fit:
                                                                                BoxFit.cover,
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
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          0.0,
                                                                      horizontal:
                                                                          4),
                                                                  child: Center(
                                                                    child: Text(
                                                                      '${controller.staffList[index].firstName.toString()} ${controller.staffList[index].lastName}',
                                                                      style: GoogleFonts.poppins(
                                                                          color: AppColor
                                                                              .black,
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          2,
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
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                      )
                      .toList())),
          Container(
            margin: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
            child: RoundedButton(
              height: 42,
              width: double.maxFinite,
              color: AppColor.appPrimary,
              text: 'Next',
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
              onClick: () async {
                List<int> StafListId = [];
                List<int> studentListId = [];
                var groupListId = [];
                print(createGroupController.studentSelectList);
                print(createGroupController.staffSelectList);
                if (createGroupController.studentSelectList.isNotEmpty ||
                    createGroupController.staffSelectList.isNotEmpty) {
                  if (await Get.toNamed(AppRoute.createGroupForBothPreview)) {
                    Get.back(result: true);
                  }
                } else {
                  createGroupController.hideLoading();
                  messageToastWarning(
                      context, "Please select minimum one staff or setudent");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

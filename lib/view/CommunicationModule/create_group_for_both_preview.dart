import 'dart:collection';
import 'dart:convert';

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
import 'package:preto3/utils/app_string.dart';
import 'package:preto3/utils/toast.dart';

import '../../controller/Communication/communication_controller.dart';
import '../../model/comm_staff_model.dart';
import '../../model/comm_student_model.dart';
import '../../network/socket_server.dart';

class CreateGroupForBothPreview extends StatelessWidget {
  CreateGroupForBothPreview({super.key});

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
          "Create a Group",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.back(result: false);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(
                Icons.person_add_alt,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Group Name",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                Form(
                  key: createGroupController.groupNameKey,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    cursorColor: AppColor.appPrimary,
                    style: GoogleFonts.poppins(
                        color: AppColor.hintTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    onEditingComplete: () => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(
                      hintText: "Type group name",
                      helperStyle: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.borderColor),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.appPrimary),
                      ),
                      contentPadding: const EdgeInsets.all(0),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      createGroupController.groupNameKey.currentState!
                          .validate();
                    },
                    controller: createGroupController.groupNameController,
                    validator: (valid) {
                      return createGroupController
                          .groupNameValidator(valid.toString());
                    },
                  ),
                ),
              ],
            ),
          ),
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
                                                        .studentSelectList
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 0.0,
                                                                horizontal: 4),
                                                        child: Container(
                                                          height: 120,
                                                          width: 80,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
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
                                                                        height:
                                                                            65,
                                                                        width:
                                                                            65,
                                                                        decoration: BoxDecoration(
                                                                            color: Colors
                                                                                .white,
                                                                            borderRadius: BorderRadius.circular(
                                                                                65),
                                                                            boxShadow: const [
                                                                              BoxShadow(color: Colors.black26, blurRadius: 6.0, spreadRadius: 2.0, offset: Offset(0.0, 0.0))
                                                                            ]),
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            ClipRRect(
                                                                              borderRadius: BorderRadius.circular(65),
                                                                              child: CachedNetworkImage(
                                                                                placeholder: (context, url) => const Image(
                                                                                  height: 65,
                                                                                  width: 65,
                                                                                  image: AssetImage(
                                                                                    AppAssets.placeHolder,
                                                                                  ),
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                                imageUrl: '${controller.studentSelectList[index].profilePic}',
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
                                                                            ),
                                                                            SvgPicture.asset(AppAssets.checkInSelectedIcon)
                                                                          ],
                                                                        )),
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
                                                                    '${controller.studentSelectList[index].studentFullName.toString()} ',
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
                                                                    maxLines: 2,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
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
                                                        .staffSelectList.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 0.0,
                                                                horizontal: 4),
                                                        child: Container(
                                                          height: 120,
                                                          width: 80,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
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
                                                                        height:
                                                                            65,
                                                                        width:
                                                                            65,
                                                                        decoration: BoxDecoration(
                                                                            color: Colors
                                                                                .white,
                                                                            borderRadius: BorderRadius.circular(
                                                                                65),
                                                                            boxShadow: const [
                                                                              BoxShadow(color: Colors.black26, blurRadius: 6.0, spreadRadius: 2.0, offset: Offset(0.0, 0.0))
                                                                            ]),
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            CachedNetworkImage(
                                                                              placeholder: (context, url) => const Image(
                                                                                image: AssetImage(
                                                                                  AppAssets.placeHolder,
                                                                                ),
                                                                                fit: BoxFit.fill,
                                                                              ),
                                                                              imageUrl: '${controller.staffSelectList[index].profilePic}',
                                                                              fit: BoxFit.fill,
                                                                              errorWidget: (context, url, error) => const Image(
                                                                                image: AssetImage(
                                                                                  AppAssets.placeHolder,
                                                                                ),
                                                                                fit: BoxFit.fill,
                                                                              ),
                                                                            ),
                                                                            SvgPicture.asset(AppAssets.checkInSelectedIcon)
                                                                          ],
                                                                        )),
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
                                                                    '${controller.staffSelectList[index].firstName.toString()} ${controller.staffList[index].lastName}',
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
                                                                    maxLines: 2,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
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
              text: 'Send',
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
              onClick: () async {
                List<int> StafListId = [];
                List<int> studentListId = [];
                var groupListId = [];

                if (createGroupController.groupNameKey.currentState!
                    .validate()) {
                  if (createGroupController.studentSelectList.isNotEmpty ||
                      createGroupController.staffSelectList.isNotEmpty) {
                    createGroupController.showLoading();
                    for (CommStudentModel commStudentModel
                        in createGroupController.studentSelectList.value) {
                      studentListId.add(commStudentModel.id);
                      for (ParentDetail parentDetail
                          in commStudentModel.parentDetails) {
                        groupListId.add(parentDetail.userName);
                      }
                    }

                    for (CommStaffModel commStaffModel
                        in createGroupController.staffSelectList.value) {
                      StafListId.add(commStaffModel.staffId);
                      groupListId.add(commStaffModel.userName);
                    }
                    groupListId.add(createGroupController.username.value);
                    String groupId =
                        "${createGroupController.groupNameController.text.replaceAll(' ', '').toLowerCase()}_${createGroupController.userId.value}_${DateTime.now().millisecondsSinceEpoch}"
                            .toLowerCase();
                    bool flag = await createGroupController.createGroup(
                        studentListId,
                        StafListId,
                        groupId,
                        createGroupController.groupNameController.text);
                    if (flag) {
                      await commController.getGroupFromBackend();
                      createGroupController.hideLoading();
                      Get.back(result: true);
                    } else {
                      createGroupController.hideLoading();
                      messageToastWarning(context, "Somthing went wrong");
                    }
                    createGroupController.hideLoading();
                  } else {
                    createGroupController.hideLoading();
                    messageToastWarning(
                        context, "Please select minimum one staff or setudent");
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

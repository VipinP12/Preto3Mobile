import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/components/rounded_button.dart';
import 'package:preto3/controller/Communication/communication_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_string.dart';

import '../../model/comm_student_model.dart';
import '../../network/socket_server.dart';
import '../../utils/toast.dart';

class CreateGroupPreviewPage extends StatelessWidget {
  CreateGroupPreviewPage({Key? key}) : super(key: key);

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
          communicationController.flagCreateRoom.value == 1
              ? AppString.messageToParent
              : "Message to staffs",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "To",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 60,
                width: 320,
                decoration: const BoxDecoration(color: Colors.white),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                communicationController.userNameList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(45)),
                                  child: Text(
                                      communicationController
                                          .userNameList.value[index],
                                      style: GoogleFonts.poppins(
                                          color: AppColor.heavyTextColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700)),
                                ),
                              );
                            }),
                      ),
                      Text(
                        communicationController.userCount.value > 5 ? "5+" : "",
                        style: GoogleFonts.poppins(
                            color: AppColor.heavyTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                        onTap: () {
                          Get.back(result: false);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: SvgPicture.asset(
                            AppAssets.editIcon,
                            color: AppColor.heavyTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 150,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  border: Border.all(color: AppColor.borderColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: communicationController.messageKey,
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.done,
                      cursorColor: AppColor.appPrimary,
                      style: GoogleFonts.poppins(
                        color: AppColor.hintTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      onEditingComplete: () => FocusScope.of(context).unfocus(),
                      maxLines: 8,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        helperStyle: GoogleFonts.poppins(
                            color: AppColor.heavyTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        contentPadding: const EdgeInsets.all(16),
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      controller: communicationController.messageController,
                      onChanged: (value) {
                        communicationController.messageKey.currentState!
                            .validate();
                      },
                      onSaved: (savedValue) {
                        // loginController.emailController.text = savedValue!;
                      },
                      validator: (valid) {
                        return communicationController
                            .messageValidator(valid.toString());
                      },
                    ),
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Stack(
              //   children: [
              //     Container(
              //         height: 140,
              //         width: double.maxFinite,
              //         decoration: BoxDecoration(
              //             color: AppColor.dashRoomBg,
              //             borderRadius: BorderRadius.circular(10)),
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               SvgPicture.asset(AppAssets.uploadFileIcon),
              //               Padding(
              //                 padding:
              //                     const EdgeInsets.only(top: 12.0, bottom: 5),
              //                 child: Text(
              //                   "Add file",
              //                   style: GoogleFonts.poppins(
              //                       color: AppColor.heavyTextColor,
              //                       fontSize: 16,
              //                       fontWeight: FontWeight.w500),
              //                 ),
              //               ),
              //               Text(
              //                 "Please upload a JPG, PNG, PDF and MP4 with maximum file size of 2 MB.",
              //                 style: GoogleFonts.poppins(
              //                     color: AppColor.heavyTextColor,
              //                     fontSize: 12,
              //                     fontWeight: FontWeight.w400),
              //                 textAlign: TextAlign.center,
              //               ),
              //             ],
              //           ),
              //         )),
              //     const DottedContainer(
              //       color: Colors.red,
              //       strokeWidth: 2.0,
              //       gap: 3.0,
              //     ),
              //   ],
              // ),

              const SizedBox(
                height: 40,
              ),
              RoundedButton(
                  height: 50,
                  width: 320,
                  color: AppColor.appPrimary,
                  onClick: () async {
                    if (communicationController.messageKey.currentState!
                        .validate()) {
                      if (communicationController.flagCreateRoom.value == 1) {
                        //create group for student
                        communicationController.showLoading();
                        bool flag = false;
                        for (int i = 0;
                            i <
                                communicationController
                                    .studentCommList.value.length;
                            i++) {
                          if (communicationController
                              .studentCommList.value[i].isSelected) {
                            flag = true;
                            List<String> listOfUser = [];
                            for (ParentDetail parentDetails
                                in communicationController
                                    .studentCommList.value[i].parentDetails) {
                              if (parentDetails.userName.trim() !=
                                  communicationController.username.value
                                      .trim()) {
                                listOfUser.add(parentDetails.userName);
                              }
                            }
                            String groupIdVal =
                                "${communicationController.studentCommList.value[i].studentFullName.replaceAll(' ', '')}_${communicationController.userId}_${DateTime.now().millisecondsSinceEpoch}"
                                    .toLowerCase();
                            listOfUser
                                .add(communicationController.username.value);

                            if (await communicationController
                                .staffCreateStudentGroup(
                                    groupIdVal,
                                    communicationController.firstname.value,
                                    communicationController
                                        .studentCommList.value[i].id
                                        .toString(),
                                    communicationController.userId
                                        .toString())) {
                              if (communicationController
                                  .messageController.text.isNotEmpty) {
                                SocketServer.instance!.sendMyMessage(
                                    communicationController
                                        .messageController.text,
                                    groupIdVal,
                                    "");
                              }
                            }

                            //SocketServer.instance!.staffCreatingStudent(param);
                            log("CREAT GROUP");
                          }
                        }
                        communicationController.hideLoading();
                        if (flag) {
                          await communicationController
                              .getStudentGroupFromBackend(
                                  communicationController.schoolId.value,
                                  communicationController.roleId.value);

                          //Get.offAndToNamed(AppRoute.communication);
                          Get.back(result: true);
                        } else {
                          // ignore: use_build_context_synchronously
                          messageToastWarning(context,
                              "Please select children then you can continue");
                        }
                        communicationController.hideLoading();
                      } else if (communicationController.flagCreateRoom.value ==
                          2) {
                        //create group for staffs
                        communicationController.showLoading();
                        bool flag = false;
                        try {
                          for (int i = 0;
                              i < communicationController.staffCommList.length;
                              i++) {
                            if (communicationController
                                .staffCommList[i].isSelected) {
                              flag = true;
                              List<String> owenerList = [];
                              String groupId =
                                  "${communicationController.staffCommList[i].firstName + communicationController.staffCommList[i].lastName}_${communicationController.staffCommList[i].staffId}_${DateTime.now().millisecondsSinceEpoch}"
                                      .toLowerCase();
                              String groupName = communicationController
                                  .staffCommList[i].firstName;
                              owenerList.add(communicationController
                                  .staffCommList[i].userName);
                              owenerList.add(communicationController
                                  .username.value
                                  .toString());
                              if (await communicationController
                                  .staffCreateStaffGroup(
                                      groupId,
                                      groupName,
                                      communicationController
                                          .staffCommList[i].staffId
                                          .toString())) {
                                if (communicationController
                                    .messageController.text.isNotEmpty) {
                                  SocketServer.instance!.sendMyMessage(
                                      communicationController
                                          .messageController.text,
                                      groupId,
                                      "");
                                }
                              }
                            }
                          }
                        } catch (e) {
                          print(e);
                          communicationController.hideLoading();
                        }
                        communicationController.hideLoading();
                        if (flag) {
                          await communicationController
                              .getStaffGroupFromBackend(
                                  communicationController.schoolId.value,
                                  communicationController.roleId.value);
                          Get.back(result: true);
                        } else {
                          messageToastWarning(context, "Please select staff");
                        }
                        communicationController.hideLoading();
                      }
                    }
                  },
                  text: 'Send',
                  style: GoogleFonts.poppins(
                      color: AppColor.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/Communication/communication_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/app_string.dart';

class StaffAdminCreateGroup extends StatelessWidget {
  StaffAdminCreateGroup({Key? key}) : super(key: key);

  final communicationController = Get.find<CommunicationController>();

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
        centerTitle: false,
        title: Text(
          AppString.communication,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Text(
            "Message to ",
            style: GoogleFonts.poppins(
                color: AppColor.heavyTextColor,
                fontSize: 24,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 14,
          ),
          Expanded(
            child: GetBuilder<CommunicationController>(
              builder: (controller) => controller.roleId.value == 2
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24.0, horizontal: 16),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(AppRoute.createStaffGroup);
                        },
                        child: ListView.builder(
                            itemCount: controller.adminRoleList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.7,
                                decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(4, 4),
                                          blurRadius: 10,
                                          spreadRadius: 1),
                                      BoxShadow(
                                          color: Colors.white12,
                                          offset: Offset(-4, -4),
                                          blurRadius: 10,
                                          spreadRadius: 1),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        controller.adminRoleList[index],
                                        style: const TextStyle(
                                            color: AppColor.heavyTextColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SvgPicture.asset(AppAssets.arrow),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24.0, horizontal: 16),
                      child: ListView.builder(
                          itemCount: controller.staffRoleList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                switch (controller.staffRoleList[index]) {
                                  case "Parents":
                                    controller.staffSelect.value = false;
                                    controller.studentSelect.value = true;
                                    controller.adminSelect.value = false;
                                    controller.storeCreateGroupDetails.clear();
                                    for (int i = 0;
                                        i <
                                            controller
                                                .studentCommList.value.length;
                                        i++) {
                                      controller.studentCommList.value[i]
                                          .isSelected = false;
                                    }
                                    controller.update();
                                    if (await Get.toNamed(
                                        AppRoute.createStudentGroup)) {
                                      Get.back();
                                    }
                                    break;
                                  case "Staff":
                                    controller.staffSelect.value = true;
                                    controller.studentSelect.value = false;
                                    controller.adminSelect.value = false;
                                    for (int i = 0;
                                        i <
                                            controller
                                                .staffCommList.value.length;
                                        i++) {
                                      controller.staffCommList.value[i]
                                          .isSelected = false;
                                    }
                                    controller.update();
                                    if (await Get.toNamed(
                                        AppRoute.staffCreateStudentGroup)) {
                                      Get.back();
                                    }
                                    break;
                                  case "Create a Group":
                                    if (await Get.toNamed(
                                        AppRoute.createGroup)) {
                                      Get.back();
                                    }
                                    break;
                                  default:
                                    return print("GO TO PARENT");
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black12,
                                            offset: Offset(4, 4),
                                            blurRadius: 10,
                                            spreadRadius: 1),
                                        BoxShadow(
                                            color: Colors.white12,
                                            offset: Offset(-4, -4),
                                            blurRadius: 10,
                                            spreadRadius: 1),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.staffRoleList[index],
                                          style: const TextStyle(
                                              color: AppColor.heavyTextColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SvgPicture.asset(AppAssets.arrow),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
            ),
          )
        ],
      ),
    );
  }
}

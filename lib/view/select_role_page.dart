import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/select_role_controller.dart';
import 'package:preto3/model/role_model.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_dimens.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/argument_keys.dart';

import '../components/rounded_button.dart';
import '../utils/app_assets.dart';

class SelectRolePage extends StatelessWidget {
  SelectRolePage({Key? key}) : super(key: key);

  final roleController = Get.find<SelectRoleController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: AppDimens.paddingVertical16,
                  ),
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Select your school & role",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )),
          ];
        },
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppDimens.paddingVertical8),
              child: Text(
                "You are assigned in multiple Schools/Role. Please choose your school & role.",
                style: GoogleFonts.poppins(
                  color: AppColor.mediumTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: AppDimens.paddingVertical16,
            ),
            Container(
                height: 42,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: AppColor.disableColor,
                    borderRadius: BorderRadius.circular(10)),
                child: GetBuilder<SelectRoleController>(
                  builder: (controller) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: DropdownButton<RoleModel>(
                      hint: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Select School',
                          style: GoogleFonts.poppins(
                              color: AppColor.lightTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      isExpanded: true,
                      icon: Visibility(
                          visible: true,
                          child: SvgPicture.asset(AppAssets.dropdownIcon)),
                      dropdownColor: AppColor.white,
                      borderRadius: BorderRadius.circular(10),
                      iconEnabledColor: AppColor.appPrimary,
                      underline: Container(),
                      alignment: Alignment.topCenter,
                      items: controller.uniquelist
                          .map((RoleModel? raceModel) =>
                              DropdownMenuItem<RoleModel>(
                                  value: raceModel,
                                  child: Text(
                                    raceModel!.schoolName.toString(),
                                    style: GoogleFonts.poppins(
                                        color: AppColor.heavyTextColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  )))
                          .toList(),
                      onChanged: (changed) {
                        controller.setSchool(changed!);
                        log("My School Type:${controller.selectedSchool}");
                      },
                      value: controller.roleType,
                    ),
                  ),
                )),
            const SizedBox(
              height: AppDimens.paddingVertical16,
            ),
            GetBuilder<SelectRoleController>(
                builder: (controller) => ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.filteredRole.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: InkWell(
                          onTap: () {
                            controller.changeRole(index);
                          },
                          child: Container(
                            height: 42,
                            width: 96,
                            decoration: BoxDecoration(
                                color: AppColor.white,
                                border: Border.all(color: AppColor.borderColor),
                                borderRadius: BorderRadius.circular(40)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  controller.roleIndex.value == index
                                      ? SvgPicture.asset(AppAssets.activeGender)
                                      : SvgPicture.asset(
                                          AppAssets.inactiveGender),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text(
                                      controller.filteredRole[index]!.roleName
                                          .toString(),
                                      style: GoogleFonts.poppins(
                                          color: controller.roleIndex.value ==
                                                  index
                                              ? AppColor.appPrimary
                                              : AppColor.lightTextColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
            const SizedBox(
              height: AppDimens.paddingVertical32,
            ),
            Obx(() => roleController.filteredRole.isNotEmpty
                ? RoundedButton(
                    height: 50,
                    width: double.maxFinite,
                    color: AppColor.appPrimary,
                    onClick: () {
                      switch (roleController.roleId.value) {
                        case 2:
                          // Get.offAllNamed(AppRoute.dashboard, arguments: {
                          //   ArgumentKeys.argumentRoleId:
                          //       roleController.roleId.value,
                          //   ArgumentKeys.argumentSchoolId:
                          //       roleController.schoolId.value
                          // });
                          // Get.toNamed(AppRoute.adminDashboardSoon);
                          Get.toNamed(AppRoute.dashboard);
                          //SCHOOL ADMIN
                          break;
                        case 3:
                          //STAFF
                          roleController.addTokenToNotification();
                          Get.offAllNamed(AppRoute.dashboardStaff, arguments: {
                            ArgumentKeys.argumentRoleId:
                                roleController.roleId.value,
                            ArgumentKeys.argumentSchoolId:
                                roleController.schoolId.value
                          });
                          break;
                        case 4:
                          //PARENT
                          roleController.addTokenToNotification();
                          Get.offAllNamed(AppRoute.dashboardParent, arguments: {
                            ArgumentKeys.argumentRoleId:
                                roleController.roleId.value,
                            ArgumentKeys.argumentSchoolId:
                                roleController.schoolId.value
                          });
                          break;
                        case 5:
                          //SUB ADMIN
                          Get.toNamed(AppRoute.adminDashboardSoon);
                          break;
                        default:
                          Get.toNamed(AppRoute.dashboard);
                          // Get.toNamed(AppRoute.adminDashboardSoon);
                      }
                    },
                    text: 'Continue',
                    style: GoogleFonts.poppins(
                        color: AppColor.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )
                : Container())
          ],
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/Staff/staff_dashboard_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_dimens.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/app_routes.dart';

import '../../components/rounded_button.dart';

class StaffDetailPage extends StatelessWidget {
  StaffDetailPage({Key? key}) : super(key: key);

  final staffController = Get.find<StaffDashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool isInnerScroll) {
            return [
              SliverAppBar(
                expandedHeight: 320,
                floating: false,
                pinned: true,
                // actions: [
                //   Padding(
                //     padding: const EdgeInsets.only(right: 16.0, top: 16),
                //     child: InkWell(
                //       onTap: () {
                //         Get.toNamed(AppRoute.editStaffProfile);
                //       },
                //       child: Text(
                //         "Edit",
                //         textAlign: TextAlign.center,
                //         style: GoogleFonts.poppins(
                //             color: AppColor.white,
                //             fontSize: 18,
                //             fontWeight: FontWeight.w500),
                //       ),
                //     ),
                //   )
                // ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: const Image(
                    image: AssetImage(AppAssets.profileBg),
                    fit: BoxFit.fill,
                  ),
                  title: SingleChildScrollView(
                    child: SizedBox(
                      height: 280,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 90,
                          ),
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(90)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(90),
                              child: CachedNetworkImage(
                                placeholder: (context, url) => const Image(
                                  height: 75,
                                  width: 75,
                                  image: AssetImage(
                                    AppAssets.placeHolder,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                imageUrl: '',
                                fit: BoxFit.cover,
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
                          const SizedBox(
                            height: 8,
                          ),
                          Flexible(
                            flex: 1,
                            child: Text(
                              "${staffController.storageBox.read(AppKeys.keyFirstName)} ${staffController.storageBox.read(AppKeys.keyLastName)}",
                              style: GoogleFonts.poppins(
                                  color: AppColor.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Teacher",
                            style: GoogleFonts.poppins(
                                color: AppColor.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Check in/out Pin:${staffController.storageBox.read(AppKeys.keyCheckInOutPin) ?? ""}",
                            style: GoogleFonts.poppins(
                                color: AppColor.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                  collapseMode: CollapseMode.parallax,
                ),
              )
            ];
          },
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text(
                "First Name",
                style: GoogleFonts.poppins(
                    color: AppColor.heavyTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                staffController.firstName.value,
                style: GoogleFonts.poppins(
                    color: AppColor.heavyTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text(
                "Last Name",
                style: GoogleFonts.poppins(
                    color: AppColor.heavyTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                staffController.lastName.value,
                style: GoogleFonts.poppins(
                    color: AppColor.heavyTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text(
                "Email",
                style: GoogleFonts.poppins(
                    color: AppColor.heavyTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              Obx(
                () => Text(staffController.email.value,
                    style: GoogleFonts.poppins(
                        color: AppColor.lightTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text("Phone Number",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              Text(
                staffController.phone.value,
                style: GoogleFonts.poppins(
                    color: AppColor.heavyTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical10,
              ),
              Text(
                "Date of Birth",
                style: GoogleFonts.poppins(
                    color: AppColor.heavyTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                height: 42,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: AppColor.disableColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SvgPicture.asset(AppAssets.calenderIcon),
                    ),
                    Obx(() => Text(
                          staffController.dob.value,
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text(
                "Spoken Languages",
                style: GoogleFonts.poppins(
                    color: AppColor.heavyTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              GetBuilder<StaffDashboardController>(
                  builder: (controller) => Wrap(
                        children: controller.languageList
                            .map(
                              (element) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    // controller.languageList(
                                    //     controller.languageList[index]!);
                                  },
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: AppColor.allergiesBg,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 6.0),
                                        child: Wrap(
                                          children: [
                                            Text(
                                              element.languageName.toString(),
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                  color: AppColor.allergiesText,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      )),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text("Address",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              Wrap(
                children: [
                  Text(staffController.addressController.text,
                      style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ],
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text("Country",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              Form(
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: AppColor.appPrimary,
                  /*focusNode:profileController.allergiesFocusNode,
                    onTap: (){
                      profileController.focusAllergies(true);
                      profileController.focusMedication(false);
                    },*/
                  style: GoogleFonts.poppins(
                      color: AppColor.hintTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintText: "country",
                    helperStyle: GoogleFonts.poppins(
                        color: AppColor.heavyTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    enabled: false,
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
                  controller: staffController.countryController,
                  onSaved: (savedValue) {
                    staffController.country.value = savedValue!;
                  },
                  validator: (valid) {
                    return staffController.countryValidator(valid.toString());
                  },
                ),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text("State",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              Form(
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: AppColor.appPrimary,
                  /*focusNode:profileController.allergiesFocusNode,
                    onTap: (){
                      profileController.focusAllergies(true);
                      profileController.focusMedication(false);
                    },*/
                  style: GoogleFonts.poppins(
                      color: AppColor.hintTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintText: "state",
                    helperStyle: GoogleFonts.poppins(
                        color: AppColor.heavyTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    enabled: false,
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
                  controller: staffController.stateController,
                  onSaved: (savedValue) {
                    staffController.state.value = savedValue!;
                  },
                  validator: (valid) {
                    return staffController.stateValidator(valid.toString());
                  },
                ),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text("City",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              Form(
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: AppColor.appPrimary,
                  /*focusNode:profileController.allergiesFocusNode,
                    onTap: (){
                      profileController.focusAllergies(true);
                      profileController.focusMedication(false);
                    },*/
                  style: GoogleFonts.poppins(
                      color: AppColor.hintTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintText: "city",
                    helperStyle: GoogleFonts.poppins(
                        color: AppColor.heavyTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    enabled: false,
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
                  controller: staffController.cityController,
                  onSaved: (savedValue) {
                    staffController.city.value = savedValue!;
                  },
                  validator: (valid) {
                    return staffController.cityValidator(valid.toString());
                  },
                ),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Container(
                height: 40,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColor.profileHeaderBG,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Employment Details",
                      style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text("Joining Date",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Obx(() => Text(
                      staffController.joiningDate.value,
                      style: GoogleFonts.poppins(
                          color: AppColor.lightTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    )),
              ),
              const Divider(
                color: AppColor.borderColor,
                height: 1,
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text("Pay Information",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: staffController.salaried.isTrue
                    ? Text(
                        "Salaried",
                        style: GoogleFonts.poppins(
                            color: AppColor.lightTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      )
                    : Text(
                        "Part time",
                        style: GoogleFonts.poppins(
                            color: AppColor.lightTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
              ),
              const Divider(
                color: AppColor.borderColor,
                height: 1,
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text("Status",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: staffController.active.isTrue
                    ? Text(
                        "Active",
                        style: GoogleFonts.poppins(
                            color: AppColor.lightTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      )
                    : Text(
                        "Inactive",
                        style: GoogleFonts.poppins(
                            color: AppColor.lightTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
              ),
              const Divider(
                color: AppColor.borderColor,
                height: 1,
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Container(
                height: 40,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColor.profileHeaderBG,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "My Rooms",
                      style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              GetBuilder<StaffDashboardController>(
                  builder: (controller) => ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => const Divider(
                          color: AppColor.borderColor,
                          height: 1,
                        ),
                        itemCount: controller.classRoomList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(
                              height: 40,
                              width: double.maxFinite,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: AppDimens.containerHeight,
                                        width: AppDimens.containerHeight,
                                        decoration: BoxDecoration(
                                            color: AppColor.appPrimary,
                                            borderRadius: BorderRadius.circular(
                                                AppDimens.containerHeight)),
                                        child: Center(
                                          child: Text(
                                            controller.classRoomList[index]
                                                .roomName[0],
                                            style: GoogleFonts.poppins(
                                                color: AppColor.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          controller
                                              .classRoomList[index].roomName,
                                          style: GoogleFonts.poppins(
                                              color: AppColor.heavyTextColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child:
                                        SvgPicture.asset(AppAssets.forwardIcon),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Container(
                height: 40,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColor.profileHeaderBG,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Emergency Contacts",
                      style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              GetBuilder<StaffDashboardController>(
                  builder: (controller) => controller
                          .emergencyContactList.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.emergencyContactList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                height: 95,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: AppColor.borderColor, width: 1)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Center(
                                          child: Text(
                                            controller
                                                .emergencyContactList[index]
                                                .contactPersonFirstName[0],
                                            style: GoogleFonts.poppins(
                                                color: AppColor.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${controller.emergencyContactList[index].contactPersonFirstName} ${controller.emergencyContactList[index].contactPersonLastName}',
                                            style: GoogleFonts.poppins(
                                                color: AppColor.heavyTextColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SvgPicture.asset(
                                                  AppAssets.mailIcon),
                                              Text(
                                                controller
                                                    .emergencyContactList[index]
                                                    .emailId,
                                                style: GoogleFonts.poppins(
                                                    color:
                                                        AppColor.heavyTextColor,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SvgPicture.asset(
                                                  AppAssets.callIcon),
                                              Text(
                                                controller
                                                    .emergencyContactList[index]
                                                    .contactNumber,
                                                style: GoogleFonts.poppins(
                                                    color:
                                                        AppColor.heavyTextColor,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      InkWell(
                                          onTap: () {
                                            Get.toNamed(AppRoute.addEmergency);
                                          },
                                          child: SvgPicture.asset(
                                            AppAssets.editIcon,
                                            height: 18,
                                            width: 18,
                                          )),
                                      InkWell(
                                          onTap: () {
                                            staffController
                                                .deleteEmergencyContact(
                                                    controller
                                                        .emergencyContactList[
                                                            index]
                                                        .userId,
                                                    controller
                                                        .emergencyContactList[
                                                            index]
                                                        .emergencyContactId,
                                                    controller.roleId.value);
                                          },
                                          child: SvgPicture.asset(
                                            AppAssets.deleteIcon,
                                            height: 18,
                                            width: 18,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                      : Center(
                          child: Text(
                            "No Emergency contact provided",
                            style: GoogleFonts.poppins(
                                color: AppColor.heavyTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Container(
                height: 40,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColor.profileHeaderBG,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Change Password",
                      style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Password",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Form(
                key: staffController.passwordKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  cursorColor: AppColor.appPrimary,
                  focusNode: staffController.passwordFocusNode,
                  onTap: () {
                    staffController.focusPasswordIcons(true);
                    staffController.focusNewPasswordIcons(false);
                    staffController.focusCPasswordIcons(false);
                  },
                  style: GoogleFonts.poppins(
                      color: AppColor.hintTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintText: "Enter your current password",
                    helperStyle: GoogleFonts.poppins(
                        color: AppColor.hintTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: AppColor.borderColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: AppColor.appPrimary),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: staffController.passwordController,
                  onSaved: (savedValue) {
                    staffController.currentPassword.value = savedValue!;
                  },
                  validator: (valid) {
                    return staffController.passwordValidator(valid.toString());
                  },
                ),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "New Password",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Form(
                key: staffController.newPasswordKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  cursorColor: AppColor.appPrimary,
                  focusNode: staffController.newPasswordFocusNode,
                  onTap: () {
                    staffController.focusPasswordIcons(false);
                    staffController.focusNewPasswordIcons(true);
                    staffController.focusCPasswordIcons(false);
                  },
                  style: GoogleFonts.poppins(
                      color: AppColor.hintTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintText: "Enter new password",
                    helperStyle: GoogleFonts.poppins(
                        color: AppColor.hintTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: AppColor.borderColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: AppColor.appPrimary),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: staffController.newPasswordController,
                  onSaved: (savedValue) {
                    staffController.newPassword.value = savedValue!;
                  },
                  validator: (valid) {
                    return staffController.passwordValidator(valid.toString());
                  },
                ),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Confirm Password",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Form(
                key: staffController.cPasswordKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  cursorColor: AppColor.appPrimary,
                  focusNode: staffController.cPasswordFocusNode,
                  onTap: () {
                    staffController.focusPasswordIcons(false);
                    staffController.focusNewPasswordIcons(false);
                    staffController.focusCPasswordIcons(true);
                  },
                  style: GoogleFonts.poppins(
                      color: AppColor.hintTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintText: "Enter confirm password",
                    helperStyle: GoogleFonts.poppins(
                        color: AppColor.hintTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: AppColor.borderColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: AppColor.appPrimary),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: staffController.cPasswordController,
                  onSaved: (savedValue) {
                    staffController.newPassword.value = savedValue!;
                  },
                  validator: (valid) {
                    return staffController.cPasswordValidator(valid.toString());
                  },
                ),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              RoundedButton(
                height: 50,
                width: 120,
                color: AppColor.appPrimary,
                onClick: () {
                  staffController.changePasswordSession(context);
                },
                text: 'Change Password',
                style: GoogleFonts.poppins(
                    color: AppColor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 70,
              ),
            ],
          )),
    );
  }
}

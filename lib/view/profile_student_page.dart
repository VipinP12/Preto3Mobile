import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/profile_student_controller.dart';
import 'package:preto3/model/race_model.dart';
import 'package:preto3/model/room_list_model.dart';
import 'package:preto3/model/school_programme_model.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_dimens.dart';

class ProfileStudentPage extends StatelessWidget {
  ProfileStudentPage({Key? key}) : super(key: key);

  final profileController = Get.find<ProfileStudentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool isInnerScroll) {
              return [
                SliverAppBar(
                  expandedHeight: 280,
                  floating: false,
                  pinned: true,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0,top: 16),
                      child: Text(
                        "Save",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: AppColor.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background:  const Image(image: AssetImage(AppAssets.profileBg),fit: BoxFit.fill,),
                    title: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 80,
                          ),

                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(90)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(90),
                                child: const Image(
                                  image: AssetImage(AppAssets.profile),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Olivia",
                            style: GoogleFonts.poppins(
                                color: AppColor.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SvgPicture.asset(AppAssets.editProfileIcon)
                        ],
                      ),
                    ),
                    collapseMode: CollapseMode.parallax,
                  ),
                )
              ];
            },
            body: Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Obx(
                      () => ListView(
                        children: [
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  "Personal Details",
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
                          Text(
                            "First Name",
                            style: GoogleFonts.poppins(
                                color: AppColor.heavyTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "Olivia",
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
                            "Davis",
                            style: GoogleFonts.poppins(
                                color: AppColor.heavyTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: AppDimens.paddingVertical16,
                          ),
                          Text(
                            "Gender",
                            style: GoogleFonts.poppins(
                                color: AppColor.heavyTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 60,
                            width: double.maxFinite,
                            child: GetBuilder<ProfileStudentController>(
                              builder: (controller) => ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.genderList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          controller.changeGender(index);
                                        },
                                        child: Container(
                                          height: 42,
                                          width: 96,
                                          decoration: BoxDecoration(
                                              color: AppColor.white,
                                              border: Border.all(
                                                  color: AppColor.borderColor),
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                controller.genderIndex.value ==
                                                        index
                                                    ? SvgPicture.asset(
                                                        AppAssets.activeGender)
                                                    : SvgPicture.asset(AppAssets
                                                        .inactiveGender),
                                                Text(
                                                  controller
                                                      .genderList[index].name,
                                                  style: GoogleFonts.poppins(
                                                      color: controller
                                                                  .genderIndex
                                                                  .value ==
                                                              index
                                                          ? AppColor.appPrimary
                                                          : AppColor
                                                              .lightTextColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          const SizedBox(
                            height: AppDimens.paddingVertical16,
                          ),
                          Text("Date of Birth",
                              style: GoogleFonts.poppins(
                                  color: AppColor.heavyTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400)),
                          const SizedBox(
                            height: AppDimens.paddingVertical10,
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child:
                                      SvgPicture.asset(AppAssets.calenderIcon),
                                ),
                                Text(
                                  "01/10/2020",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: AppDimens.paddingVertical16,
                          ),
                          Text(
                            "Race",
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
                              child: GetBuilder<ProfileStudentController>(
                                builder: (controller) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: DropdownButton<RaceList>(
                                    isExpanded: true,
                                    icon: Visibility(
                                        visible: true,
                                        child: SvgPicture.asset(
                                            AppAssets.dropdownIcon)),
                                    dropdownColor: AppColor.white,
                                    borderRadius: BorderRadius.circular(10),
                                    iconEnabledColor: AppColor.appPrimary,
                                    underline: Container(),
                                    alignment: Alignment.topCenter,
                                    items: controller.raceList
                                        .map((RaceList? raceModel) =>
                                            DropdownMenuItem<RaceList>(
                                                value: raceModel,
                                                child: Text(
                                                  raceModel!.raceDescription
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      color: AppColor
                                                          .heavyTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )))
                                        .toList(),
                                    onChanged: (changed) {
                                      controller.setRace(changed!);
                                      log("My Race Type:${controller.raceType}");
                                    },
                                    value: controller.raceType,
                                  ),
                                ),
                              )),
                          const SizedBox(
                            height: AppDimens.paddingVertical16,
                          ),
                          Text(
                            "Ethnicity",
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
                              child: GetBuilder<ProfileStudentController>(
                                builder: (controller) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: DropdownButton<EthnicityList>(
                                    isExpanded: true,
                                    icon: Visibility(
                                        visible: true,
                                        child: SvgPicture.asset(
                                            AppAssets.dropdownIcon)),
                                    dropdownColor: AppColor.white,
                                    borderRadius: BorderRadius.circular(10),
                                    iconEnabledColor: AppColor.appPrimary,
                                    underline: Container(),
                                    alignment: Alignment.topCenter,
                                    items: controller.ethnicityList
                                        .map((EthnicityList? raceModel) =>
                                            DropdownMenuItem<EthnicityList>(
                                                value: raceModel,
                                                child: Text(
                                                  raceModel!
                                                      .ethnicityIdDescription
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      color: AppColor
                                                          .heavyTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )))
                                        .toList(),
                                    onChanged: (changed) {
                                      controller.setEthnic(changed!);
                                      log("My Race Type:${controller.ethnicType}");
                                    },
                                    value: controller.ethnicType,
                                  ),
                                ),
                              )),
                          const SizedBox(
                            height: AppDimens.paddingVertical16,
                          ),
                          Text(
                            "Doctor’s Name",
                            style: GoogleFonts.poppins(
                                color: AppColor.heavyTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "John",
                            style: GoogleFonts.poppins(
                                color: AppColor.heavyTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: AppDimens.paddingVertical16,
                          ),
                          Text(
                            "Doctor’s Phone Number",
                            style: GoogleFonts.poppins(
                                color: AppColor.heavyTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "93823929292",
                            style: GoogleFonts.poppins(
                                color: AppColor.heavyTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: AppDimens.paddingVertical16,
                          ),
                          Text(
                            "Allergies",
                            style: GoogleFonts.poppins(
                                color: AppColor.heavyTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          profileController.allergiesList.isEmpty
                              ? Container()
                              : SizedBox(
                                  height: 48,
                                  width: double.maxFinite,
                                  child: GetBuilder<ProfileStudentController>(
                                    builder: (controller) => ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            controller.allergiesList.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () {
                                                controller.removeAllergies(
                                                    controller
                                                        .allergiesList[index]!);
                                              },
                                              child: Container(
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: AppColor.allergiesBg,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          controller
                                                              .allergiesList[
                                                                  index]
                                                              .toString(),
                                                          style: GoogleFonts.poppins(
                                                              color: AppColor
                                                                  .allergiesText,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8.0),
                                                          child: Icon(
                                                            Icons.close,
                                                            size: 18,
                                                            color: AppColor
                                                                .allergiesText,
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                          Form(
                            key: profileController.addAllergiesKey,
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
                              onEditingComplete: () =>
                                  FocusScope.of(context).unfocus(),
                              decoration: InputDecoration(
                                  hintText: "Add allergies",
                                  helperStyle: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.borderColor),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.appPrimary),
                                  ),
                                  contentPadding: const EdgeInsets.all(16),
                                  filled: true,
                                  fillColor: Colors.white,
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        profileController.allergySession();
                                      },
                                      child: SvgPicture.asset(
                                        AppAssets.roundedAdd,
                                        fit: BoxFit.scaleDown,
                                      ))),
                              controller: profileController.allergiesController,
                              onSaved: (savedValue) {
                                profileController.allergies.value = savedValue!;
                              },
                              validator: (valid) {
                                return profileController
                                    .allergyValidator(valid.toString());
                              },
                            ),
                          ),
                          const SizedBox(
                            height: AppDimens.paddingVertical16,
                          ),
                          Text(
                            "Medications",
                            style: GoogleFonts.poppins(
                                color: AppColor.heavyTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          profileController.medicationList.isEmpty
                              ? Container()
                              : SizedBox(
                                  height: 48,
                                  width: double.maxFinite,
                                  child: GetBuilder<ProfileStudentController>(
                                    builder: (controller) => ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            controller.medicationList.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () {
                                                controller.removeMedication(
                                                    controller.medicationList[
                                                        index]!);
                                              },
                                              child: Container(
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: AppColor.allergiesBg,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          controller
                                                              .medicationList[
                                                                  index]
                                                              .toString(),
                                                          style: GoogleFonts.poppins(
                                                              color: AppColor
                                                                  .allergiesText,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8.0),
                                                          child: Icon(
                                                            Icons.close,
                                                            size: 18,
                                                            color: AppColor
                                                                .allergiesText,
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                          Form(
                            key: profileController.addMedicationKey,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              cursorColor: AppColor.appPrimary,
                              /*focusNode:profileController.medicationFocusNode,
                        onTap: (){
                          profileController.focusAllergies(false);
                          profileController.focusMedication(true);
                        },*/
                              style: GoogleFonts.poppins(
                                  color: AppColor.hintTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              onEditingComplete: () =>
                                  FocusScope.of(context).unfocus(),
                              decoration: InputDecoration(
                                  hintText: "Add Medications",
                                  helperStyle: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.borderColor),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.appPrimary),
                                  ),
                                  contentPadding: const EdgeInsets.all(16),
                                  filled: true,
                                  fillColor: Colors.white,
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        profileController.medicationSession();
                                      },
                                      child: SvgPicture.asset(
                                        AppAssets.roundedAdd,
                                        fit: BoxFit.scaleDown,
                                      ))),
                              controller:
                                  profileController.medicationController,
                              onSaved: (savedValue) {
                                profileController.medication.value =
                                    savedValue!;
                              },
                              validator: (valid) {
                                return profileController
                                    .medicationValidator(valid.toString());
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  "Enrollment Details",
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
                          Text("Program name",
                              style: GoogleFonts.poppins(
                                  color: AppColor.heavyTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400)),
                          const SizedBox(
                            height: AppDimens.paddingVertical10,
                          ),
                          Container(
                              height: 42,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: AppColor.disableColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: GetBuilder<ProfileStudentController>(
                                builder: (controller) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child:
                                      DropdownButton<SchoolProgrammeModelDart>(
                                    isExpanded: true,
                                    icon: Visibility(
                                        visible: true,
                                        child: SvgPicture.asset(
                                            AppAssets.dropdownIcon)),
                                    dropdownColor: AppColor.white,
                                    borderRadius: BorderRadius.circular(10),
                                    iconEnabledColor: AppColor.appPrimary,
                                    underline: Container(),
                                    alignment: Alignment.topCenter,
                                    items: controller.schoolProgrammeList
                                        .map((SchoolProgrammeModelDart?
                                                raceModel) =>
                                            DropdownMenuItem<
                                                    SchoolProgrammeModelDart>(
                                                value: raceModel,
                                                child: Text(
                                                  raceModel!.programName
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      color: AppColor
                                                          .heavyTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )))
                                        .toList(),
                                    onChanged: (changed) {
                                      controller.setProgramme(changed!);
                                      log("SCHOOL PROGRAMME TYPE:${controller.programmeType}");
                                    },
                                    value: controller.programmeType,
                                  ),
                                ),
                              )),
                          const SizedBox(
                            height: AppDimens.paddingVertical16,
                          ),
                          Text("Enrollment Date",
                              style: GoogleFonts.poppins(
                                  color: AppColor.heavyTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400)),
                          const SizedBox(
                            height: AppDimens.paddingVertical10,
                          ),
                          Container(
                            height: 45,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                color: AppColor.disableColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child:
                                      SvgPicture.asset(AppAssets.calenderIcon),
                                ),
                                Text(
                                  "01/10/2020",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: AppDimens.paddingVertical16,
                          ),
                          Text("Enrollment Type",
                              style: GoogleFonts.poppins(
                                  color: AppColor.heavyTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400)),
                          SizedBox(
                            height: 60,
                            width: double.maxFinite,
                            child: GetBuilder<ProfileStudentController>(
                              builder: (controller) => ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.enrollmentList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          controller.changeEnrollment(index);
                                        },
                                        child: Flexible(
                                          flex: 1,
                                          child: Container(
                                            height: 42,
                                            decoration: BoxDecoration(
                                                color: AppColor.white,
                                                border: Border.all(
                                                    color:
                                                        AppColor.borderColor),
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  controller.enrollmentIndex
                                                              .value ==
                                                          index
                                                      ? SvgPicture.asset(
                                                          AppAssets
                                                              .activeGender)
                                                      : SvgPicture.asset(
                                                          AppAssets
                                                              .inactiveGender),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 16.0),
                                                    child: Text(
                                                      controller
                                                          .enrollmentList[index]
                                                          .name,
                                                      style: GoogleFonts.poppins(
                                                          color: controller
                                                                      .enrollmentIndex
                                                                      .value ==
                                                                  index
                                                              ? AppColor
                                                                  .appPrimary
                                                              : AppColor
                                                                  .lightTextColor,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          const SizedBox(
                            height: AppDimens.paddingVertical16,
                          ),
                          Text("Select Room",
                              style: GoogleFonts.poppins(
                                  color: AppColor.heavyTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400)),
                          Container(
                              height: 42,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: AppColor.disableColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: GetBuilder<ProfileStudentController>(
                                builder: (controller) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: DropdownButton<RoomListModel>(
                                    isExpanded: true,
                                    icon: Visibility(
                                        visible: true,
                                        child: SvgPicture.asset(
                                            AppAssets.dropdownIcon)),
                                    dropdownColor: AppColor.white,
                                    borderRadius: BorderRadius.circular(10),
                                    iconEnabledColor: AppColor.appPrimary,
                                    underline: Container(),
                                    alignment: Alignment.topCenter,
                                    items: controller.allRoomList
                                        .map((RoomListModel? raceModel) =>
                                            DropdownMenuItem<RoomListModel>(
                                                value: raceModel,
                                                child: Text(
                                                  raceModel!.className
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      color: AppColor
                                                          .heavyTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )))
                                        .toList(),
                                    onChanged: (changed) {
                                      controller.setClassRoom(changed!);
                                      log("My Race Type:${controller.raceType}");
                                    },
                                    value: controller.roomType,
                                  ),
                                ),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  "Parent Details",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  "Emergency Contact Details",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  "Student Fee Plan",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  "Immunization Records",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )))));
  }
}

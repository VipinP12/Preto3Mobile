import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import '../../../controller/Admin/staff_management/add_new_staff_controller.dart';
import '../../../model/race_model.dart';
import '../../../model/room_list_model.dart';
import '../../../model/school_programme_model.dart';
import '../../../utils/app_dimens.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/comman_textStyle.dart';
import '../../../utils/comman_textfield.dart';

class AddStaffProfile extends StatelessWidget {
  AddStaffProfile({Key? key}) : super(key: key);

  final profileAddStaffController = Get.find<ProfileAddStaffController>();

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          backgroundColor: AppColor.scaffoldBackground,
          appBar: AppBar(
            title: Text("Add Staff",
              style: GoogleFonts.poppins(
                  color: AppColor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            actions:   [
              InkWell(
                onTap: (){
                  // staffController.updateStaffProfileSession();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0, top: 16),
                  child: Text(
                    "Save",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: AppColor.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],

          ),
          body: Obx(()=> Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
            child: SingleChildScrollView(
              child: Form(
                key: profileAddStaffController.addStaffKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        _bottomUploadImageSheet(context);
                      },
                      child: Center(
                        child: Container(
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                              color: AppColor.black.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            child: const Icon(Icons.camera_alt,color: Colors.white,size: 50,)
                          // SvgPicture.asset(AppAssets.roundedAdd),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    const CommonTextField(hintText: 'First Name', title: "First Name",),
                    const CommonTextField(hintText: 'Last Name', title: "Last Name",),
                    Text("Gender",style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14)),
                    SizedBox(
                      height: 60,
                      width: double.maxFinite,
                      child: GetBuilder<ProfileAddStaffController>(
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
                      ), ),
                    const SizedBox(height: 10,),
                    Text("Date Of Birth",style:TextStyles.textStyleFW500(AppColor.heavyTextColor, 14)),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColor.disableColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:   Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                        child: InkWell(
                          onTap: (){
                            // selectDatePicker();
                            // print(selectedDate != null
                            //     ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                            //     : "Enter date");
                          },
                          child:    Row(
                            children: [
                              Icon(Icons.calendar_month_sharp),
                              SizedBox(width: 10,),
                              Text(
                                // selectedDate != null
                                //   ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                                //   :
                                  "Date of birth",
                                  style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                        "Race",
                        style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14)
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 42,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: AppColor.disableColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: GetBuilder<ProfileAddStaffController>(
                          builder: (controller) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, ),
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
                              // alignment: Alignment.topCenter,
                              hint: Text("Race"),
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
                        style:  TextStyles.textStyleFW500(AppColor.heavyTextColor, 14)
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 42,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: AppColor.disableColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: GetBuilder<ProfileAddStaffController>(
                          builder: (controller) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, ),
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
                              // alignment: Alignment.topCenter,
                              hint: Text("ethnicity",style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),),
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
                    const SizedBox(height: 10,),
                    const CommonTextField(hintText: 'Doctor Name', title: "Doctor Name",),
                    const CommonTextField(hintText: "1234567890", title: "Doctor's Phone Number",),
                    Text(
                        "Allergies",
                        style:  TextStyles.textStyleFW500(AppColor.heavyTextColor, 14)
                    ),
                    profileAddStaffController.allergiesList.isEmpty
                        ? Container()
                        : SizedBox(
                      height: 48,
                      width: double.maxFinite,
                      child: GetBuilder<ProfileAddStaffController>(
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
                    CommonTextField(
                      hintText: 'Add allergies',
                      suffixImage: InkWell(
                          onTap: () {
                            print("add data");
                            profileAddStaffController.allergySession();
                          },
                          child: SvgPicture.asset(
                            AppAssets.roundedAdd,
                            fit: BoxFit.scaleDown,
                          )),
                      controller: profileAddStaffController.allergiesController,
                      onSaved: (savedValue) {
                        profileAddStaffController.allergies.value = savedValue;
                      },
                    ),
                    const SizedBox(
                      height: AppDimens.paddingVertical16,
                    ),
                    Text(
                        "Medications",
                        style:  TextStyles.textStyleFW500(AppColor.heavyTextColor, 14)
                    ),
                    profileAddStaffController.medicationList.isEmpty
                        ? Container()
                        : SizedBox(
                      height: 48,
                      width: double.maxFinite,
                      child: GetBuilder<ProfileAddStaffController>(
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
                    CommonTextField(
                      hintText: 'Add Medications',
                      suffixImage: InkWell(
                          onTap: () {
                            print("add data");
                            profileAddStaffController.medicationSession();
                          },
                          child: SvgPicture.asset(
                            AppAssets.roundedAdd,
                            fit: BoxFit.scaleDown,
                          )),
                      controller: profileAddStaffController.medicationController,
                      onSaved: (savedValue) {
                        profileAddStaffController.medication.value =
                            savedValue;
                      },
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
                              style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14)
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppDimens.paddingVertical16,
                    ),
                    Text(
                        "Program Name",
                        style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14)
                    ),
                    const SizedBox(
                      height: AppDimens.paddingVertical10,
                    ),
                    Container(
                        height: 42,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: AppColor.disableColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: GetBuilder<ProfileAddStaffController>(
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
                              // alignment: Alignment.topCenter,
                              hint: Text("School Program"),
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
                    SizedBox(height: 20,),
                    Text(
                        "Enrollment Date",
                        style:  TextStyles.textStyleFW500(AppColor.heavyTextColor, 14)
                    ),
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
                              style: TextStyles.textStyleFW400(AppColor.heavyTextColor, 14)
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                        "Enrollment Type",
                        style:  TextStyles.textStyleFW500(AppColor.heavyTextColor, 14)
                    ),
                    const SizedBox(height: AppDimens.paddingVertical10,),
                    SizedBox(
                      height: 60,
                      width: double.maxFinite,
                      child: GetBuilder<ProfileAddStaffController>(
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
                              );
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                        "Select Room",
                        style:  TextStyles.textStyleFW500(AppColor.heavyTextColor, 14)
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 42,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: AppColor.disableColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: GetBuilder<ProfileAddStaffController>(
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
                              // alignment: Alignment.topCenter,
                              hint: Text("Room Select"),
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
                      height: 20,
                    ),
                    Text(
                        "Schedule Start Time",
                        style:  TextStyles.textStyleFW500(AppColor.heavyTextColor, 14)
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 42,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: AppColor.disableColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0),
                          child:  Row(children: [
                            Icon(Icons.access_time,color: AppColor.mediumTextColor,),
                            SizedBox(width: 10,),
                            Text("Schedule Start Time")
                          ],)
                      ),),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                        "Schedule End Time",
                        style:  TextStyles.textStyleFW500(AppColor.heavyTextColor, 14)
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 42,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: AppColor.disableColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0),
                          child:  Row(children: [
                            Icon(Icons.access_time,color: AppColor.mediumTextColor,),
                            SizedBox(width: 10,),
                            Text("Schedule End Time")
                          ],)
                      ),),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColor.dashRoomBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                        child: Text("Parent Detail",style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14)),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        print("vandana");
                        Get.toNamed(AppRoute.addPrimaryParent);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Add Primary Parent",
                              style: TextStyles.textStyleFW400(AppColor.heavyTextColor, 14),),
                            SvgPicture.asset(
                              AppAssets.roundedAdd,
                              fit: BoxFit.scaleDown,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(thickness: 1,height: 0,),
                    InkWell(
                      onTap: (){
                        print("Add Secondary Parent");
                        Get.toNamed(AppRoute.addPrimaryParent);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Add Secondary Parent",
                              style: TextStyles.textStyleFW400(AppColor.heavyTextColor, 14),),
                            SvgPicture.asset(
                              AppAssets.roundedAdd,
                              fit: BoxFit.scaleDown,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(thickness: 1, ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ))

      );
  }

  void _bottomUploadImageSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        isDismissible: false,
        builder: (ctx) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setter) {
                return Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                      color: AppColor.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  // staffController.getImage(ImageSource.camera);
                                  Get.back();
                                },
                                child: Container(
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.circular(20),
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
                                  child: const Center(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.camera_alt,
                                          color: AppColor.appPrimary,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Camera",
                                          style: TextStyle(
                                              color: AppColor.appPrimary,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  // staffController.getImage(ImageSource.gallery);
                                  Get.back();
                                },
                                child: Container(
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.circular(20),
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
                                  child: const Center(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.image_outlined,
                                          color: AppColor.appPrimary,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Gallery",
                                          style: TextStyle(
                                              color: AppColor.appPrimary,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ));
              });
        });
  }
}

void _bottomUploadImageSheet(BuildContext ctx) {
  showModalBottomSheet(
      context: ctx,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setter) {
              return Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                    color: AppColor.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                // staffController.getImage(ImageSource.camera);
                                Get.back();
                              },
                              child: Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(20),
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
                                child: const Center(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                        color: AppColor.appPrimary,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Camera",
                                        style: TextStyle(
                                            color: AppColor.appPrimary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // staffController.getImage(ImageSource.gallery);
                                // Get.back();
                              },
                              child: Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(20),
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
                                child: const Center(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image_outlined,
                                        color: AppColor.appPrimary,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Gallery",
                                        style: TextStyle(
                                            color: AppColor.appPrimary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ));
            });
      });
}
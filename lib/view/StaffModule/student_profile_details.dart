import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/Staff/staff_student_detail_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_dimens.dart';

class StudentProfileDetails extends StatelessWidget {
  StudentProfileDetails({Key? key}) : super(key: key);

  final studentDetailsController = Get.find<StaffStudentDetailsController>();

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
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: const Image(
                      image: AssetImage(AppAssets.profileBg),
                      fit: BoxFit.fill,
                    ),
                    title: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 120,
                          ),
                          Container(
                            height: 90,
                            width: 90,
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
                                imageUrl: studentDetailsController
                                    .profilePic.value
                                    .toString(),
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
                            height: 10,
                          ),
                          Text(
                            "${studentDetailsController.firstName.value} ${studentDetailsController.lastName.value}",
                            style: GoogleFonts.poppins(
                                color: AppColor.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                        ],
                      ),
                    ),
                    collapseMode: CollapseMode.parallax,
                  ),
                )
              ];
            },
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GetBuilder<StaffStudentDetailsController>(
                  builder: (controller) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: double.maxFinite,
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: AppColor.profileHeaderBG,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
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
                        controller.stufirstName.value.toString(),
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
                        controller.stuLastName.value.toString(),
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
                      Text(
                        controller.stuGender.value.toString(),
                        style: GoogleFonts.poppins(
                            color: AppColor.heavyTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
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
                      Text(
                        controller.stuBirthDay.value.toString(),
                        style: GoogleFonts.poppins(
                            color: AppColor.heavyTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
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
                      Text(
                        controller.stuRace.value.toString(),
                        style: GoogleFonts.poppins(
                            color: AppColor.heavyTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
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
                      Text(
                        controller.stuEthnicity.value.toString(),
                        style: GoogleFonts.poppins(
                            color: AppColor.heavyTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
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
                        controller.stuDoctorName.value.toString(),
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
                        controller.stuDoctorPhoneNum.value.toString(),
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
                      Container(
                        height: 30,
                        //width: 70,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(right: 220),
                        decoration: BoxDecoration(
                            color: AppColor.allergiesBg,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  controller.stuAllergies.value.toString(),
                                  style: GoogleFonts.poppins(
                                      color: AppColor.allergiesText,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )),
                      ),
                      /*SizedBox(
                                  height: 48,
                                  width: double.maxFinite,
                                  child: GetBuilder<ParentStudentDetailsController>(
                                    builder: (controller) => ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            controller.studentProfile.studentPersonalDetails.,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () {
                                                */ /*controller.removeAllergies(
                                                    controller
                                                        .allergiesList[index]!);*/ /*
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
                                ),*/
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
                      Container(
                        height: 30,
                        //width: 70,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(right: 220),
                        decoration: BoxDecoration(
                            color: AppColor.allergiesBg,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  controller.stuMedications.value.toString(),
                                  style: GoogleFonts.poppins(
                                      color: AppColor.allergiesText,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
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
                      Text(
                        controller.studentProfile != null
                            ? controller.studentProfile!
                                .studentEnrollmentDetails.programName
                                .toString()
                            : "",
                        style: GoogleFonts.poppins(
                            color: AppColor.heavyTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
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
                      Text(
                        controller.studentProfile != null
                            ? controller.studentProfile!
                                .studentEnrollmentDetails.enrollmentDate
                                .toString()
                            : "",
                        style: GoogleFonts.poppins(
                            color: AppColor.heavyTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: AppDimens.paddingVertical16,
                      ),
                      Text("Enrollment Type",
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                      Text(
                        controller.studentProfile != null
                            ? controller.studentProfile!
                                .studentEnrollmentDetails.enrollmentType
                                .toString()
                            : "",
                        style: GoogleFonts.poppins(
                            color: AppColor.heavyTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: AppDimens.paddingVertical16,
                      ),
                      Text("Room",
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                      Text(
                        controller.studentProfile != null
                            ? controller.studentProfile!
                                .studentEnrollmentDetails.className
                                .toString()
                            : "",
                        style: GoogleFonts.poppins(
                            color: AppColor.heavyTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: AppDimens.paddingVertical16,
                      ),
                      Text("Schedule Start Time",
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
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  AppAssets.clockIcon,
                                  color: AppColor.lightTextColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Text(
                                    controller.studentProfile != null
                                        ? controller
                                            .studentProfile!
                                            .studentEnrollmentDetails
                                            .scheduledStartTime
                                            .toString()
                                        : "",
                                    style: GoogleFonts.poppins(
                                        color: AppColor.lightTextColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: AppDimens.paddingVertical16,
                      ),
                      Text("Schedule End Time",
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
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  AppAssets.clockIcon,
                                  color: AppColor.lightTextColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Text(
                                    controller.studentProfile != null
                                        ? controller
                                            .studentProfile!
                                            .studentEnrollmentDetails!
                                            .scheduledEndTime
                                            .toString()
                                        : "",
                                    style: GoogleFonts.poppins(
                                        color: AppColor.lightTextColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                )
                              ],
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
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
                      const SizedBox(
                        height: AppDimens.paddingVertical16,
                      ),
                      GetBuilder<StaffStudentDetailsController>(
                        builder: (controller) => ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount:
                                controller.studentProfile!.parents.length,
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
                                          color: AppColor.borderColor,
                                          width: 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                              controller.studentProfile!
                                                  .parents[index].firstName[0],
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
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0),
                                                child: Text(
                                                  "${controller.studentProfile!.parents[index].firstName} ${controller.studentProfile!.parents[index].lastName}",
                                                  style: GoogleFonts.poppins(
                                                      color: AppColor
                                                          .heavyTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
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
                                                    controller.studentProfile!
                                                        .parents[index].emailId,
                                                    style: GoogleFonts.poppins(
                                                        color: AppColor
                                                            .heavyTextColor,
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
                                                        .studentProfile!
                                                        .parents[index]
                                                        .phoneNumber,
                                                    style: GoogleFonts.poppins(
                                                        color: AppColor
                                                            .heavyTextColor,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
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
                      GetBuilder<StaffStudentDetailsController>(
                        builder: (controller) => ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: controller
                                .studentProfile!.emergencyContacts.length,
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
                                          color: AppColor.borderColor,
                                          width: 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                  .studentProfile!
                                                  .emergencyContacts[index]
                                                  .firstName[0],
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
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${controller.studentProfile!.emergencyContacts[index].firstName} ${controller.studentProfile!.emergencyContacts[index].lastName}",
                                                style: GoogleFonts.poppins(
                                                    color:
                                                        AppColor.heavyTextColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                                        .studentProfile!
                                                        .emergencyContacts[
                                                            index]
                                                        .contactPhone,
                                                    style: GoogleFonts.poppins(
                                                        color: AppColor
                                                            .heavyTextColor,
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
                                                        .studentProfile!
                                                        .emergencyContacts[
                                                            index]
                                                        .contactPhone,
                                                    style: GoogleFonts.poppins(
                                                        color: AppColor
                                                            .heavyTextColor,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Table(
                          border: TableBorder.all(
                              color: AppColor.borderColor, width: 0.5),
                          columnWidths: const {
                            0: FlexColumnWidth(4),
                            1: FlexColumnWidth(4),
                          },
                          children: [
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Plan Name",
                                    style: GoogleFonts.poppins(
                                        color: AppColor.heavyTextColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  controller.studentProfile != null &&
                                          controller.studentProfile!
                                                  .studentFeePlanDetails !=
                                              null
                                      ? controller.studentProfile!
                                          .studentFeePlanDetails!.planName
                                          .toString()
                                      : "",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.lightTextColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Day Plan",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  controller.studentProfile != null &&
                                          controller.studentProfile!
                                                  .studentFeePlanDetails !=
                                              null
                                      ? controller.studentProfile!
                                          .studentFeePlanDetails!.feePlanDays
                                          .toString()
                                      : "",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.lightTextColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Payment Frequency",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  controller.studentProfile != null &&
                                          controller.studentProfile!
                                                  .studentFeePlanDetails !=
                                              null
                                      ? controller
                                          .studentProfile!
                                          .studentFeePlanDetails!
                                          .paymentFrequency
                                          .toString()
                                      : "",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.lightTextColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ]),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Table(
                          border: TableBorder.all(
                              color: AppColor.borderColor, width: 0.5),
                          columnWidths: const {
                            0: FlexColumnWidth(4),
                            1: FlexColumnWidth(4),
                          },
                          children: [
                            TableRow(
                                decoration: const BoxDecoration(
                                    color: Color(0x265463D6)),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Charge Type",
                                        style: GoogleFonts.poppins(
                                            color: AppColor.heavyTextColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Amount",
                                      style: GoogleFonts.poppins(
                                          color: AppColor.heavyTextColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Tuition Fee",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  controller.studentProfile != null &&
                                          controller.studentProfile!
                                                  .studentFeePlanDetails !=
                                              null &&
                                          controller
                                                  .studentProfile!
                                                  .studentFeePlanDetails!
                                                  .chargeTypes !=
                                              null
                                      ? controller
                                          .studentProfile!
                                          .studentFeePlanDetails!
                                          .chargeTypes!
                                          .tuitionFee
                                          .toString()
                                      : "",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.lightTextColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ]),
                            /* TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Activity Fee",
                                      style: GoogleFonts.poppins(
                                          color: AppColor.heavyTextColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "100.00",
                                      style: GoogleFonts.poppins(
                                          color: AppColor.lightTextColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Meals & Snacks Fee",
                                      style: GoogleFonts.poppins(
                                          color: AppColor.heavyTextColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "100.00",
                                      style: GoogleFonts.poppins(
                                          color: AppColor.lightTextColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ]),*/
                            TableRow(
                                decoration: const BoxDecoration(
                                    color: Color(0x265463D6)),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Total Fee",
                                      style: GoogleFonts.poppins(
                                          color: AppColor.appPrimary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      controller.studentProfile != null &&
                                              controller.studentProfile!
                                                      .studentFeePlanDetails !=
                                                  null &&
                                              controller
                                                      .studentProfile!
                                                      .studentFeePlanDetails!
                                                      .chargeTypes !=
                                                  null
                                          ? controller
                                              .studentProfile!
                                              .studentFeePlanDetails!
                                              .chargeTypes!
                                              .totalFee
                                              .toString()
                                          : "",
                                      style: GoogleFonts.poppins(
                                          color: AppColor.appPrimary,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: AppDimens.paddingVertical16,
                      ),
                      const SizedBox(
                        height: AppDimens.paddingVertical16,
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}

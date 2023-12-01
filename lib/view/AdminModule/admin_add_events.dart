import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/Admin/admin_event_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_string.dart';

class AdminAddEvents extends StatelessWidget {
  AdminAddEvents({super.key});

  final adminAddEventController = Get.put(AdminEventController());

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
        title: Text(
          AppString.addEvents,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: InkWell(
              onTap: () {},
              child: Center(
                child: Text(
                  "Save",
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             GetBuilder<AdminEventController>(builder: (controller)=> Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 for(int index=0;index<controller.eventTypeList.length;index++)
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       InkWell(
                         onTap: (){
                           log("TAPPED:${index}");
                           controller.setEventTypeCheck(index);
                         },
                         child: Container(
                           height: 25,
                           width: 25,
                           alignment: Alignment.center,
                           decoration: BoxDecoration(
                             color: controller.eventTypeList[index].eventTypeIsChecked==true?AppColor.appPrimary:AppColor.white,
                             border: Border.all(
                               color: controller.eventTypeList[index].eventTypeIsChecked==true?AppColor.appPrimary:AppColor.borderColor,
                               width: controller.eventTypeList[index].eventTypeIsChecked==true?2.0:1.0,
                             ),
                             borderRadius: BorderRadius.circular(5),
                           ),
                           child: controller.eventTypeList[index].eventTypeIsChecked==true?Padding(
                             padding:  const EdgeInsets.all(2.0),
                             child: SvgPicture.asset(AppAssets.checkedIcon),
                           ):const SizedBox.shrink(),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(left: 8.0),
                         child: Center(
                           child: Text(
                             controller.eventTypeList[index].eventTypeName,
                             style: GoogleFonts.poppins(
                                 color: AppColor.lightTextColor,
                                 fontSize: 14,
                                 fontWeight: FontWeight.w400),
                           ),
                         ),
                       )
                     ],
                   ),
               ],
             )),
              const SizedBox(height: 20,),
              Text("Event Title",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              Form(
                key: adminAddEventController.eventTitle,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: AppColor.appPrimary,
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  decoration: InputDecoration(
                    hintText: "Event name",
                    helperStyle: GoogleFonts.poppins(
                        color: AppColor.hintTextColor,
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
                  controller: adminAddEventController.eventTitleController,
                  validator: (valid) {
                    return adminAddEventController.eventTitleValidator(valid.toString());
                  },
                ),
              ),
              const SizedBox(height: 10,),
              Text("Event Venue",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              Form(
                key: adminAddEventController.eventVenue,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: AppColor.appPrimary,
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  decoration: InputDecoration(
                    hintText: "Event venue name",
                    helperStyle: GoogleFonts.poppins(
                        color: AppColor.hintTextColor,
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
                  controller: adminAddEventController.eventVenueController,
                  validator: (valid) {
                    return adminAddEventController.eventVenueValidator(valid.toString());
                  },
                ),
              ),
              const SizedBox(height: 10,),
              Text("Description",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              Form(
                key: adminAddEventController.eventDesc,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: AppColor.appPrimary,
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintText: "Event venue name",
                    helperStyle: GoogleFonts.poppins(
                        color: AppColor.hintTextColor,
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
                  controller: adminAddEventController.eventDescController,
                  validator: (valid) {
                    return adminAddEventController.eventDescValidator(valid.toString());
                  },
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Start Date",
                        style: GoogleFonts.poppins(
                            color: AppColor.heavyTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      InkWell(
                        onTap: () {
                          adminAddEventController.addStartDate(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          height: 42,
                          width: 140,
                          decoration: BoxDecoration(
                              color: AppColor.disableColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: SvgPicture.asset(AppAssets.calenderIcon),
                              ),
                              Obx(() => adminAddEventController.selectedAddStartDate.isNotEmpty
                                  ? Text(
                                adminAddEventController.selectedAddStartDate.toString(),
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              )
                                  : Text(
                                "Start Date",
                                style: GoogleFonts.poppins(
                                    color: AppColor.lightTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "End Date",
                        style: GoogleFonts.poppins(
                            color: AppColor.heavyTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      InkWell(
                        onTap: () {
                          adminAddEventController.addEndDate(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          height: 42,
                          width: 140,
                          decoration: BoxDecoration(
                              color: AppColor.disableColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: SvgPicture.asset(AppAssets.calenderIcon),
                              ),
                              Obx(() => adminAddEventController.selectedEndDate.isNotEmpty
                                  ? Text(
                                adminAddEventController.selectedEndDate.toString(),
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              )
                                  : Text(
                                "End Date",
                                style: GoogleFonts.poppins(
                                    color: AppColor.lightTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      adminAddEventController.pickStartTime(context);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Start Time",
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8),
                          height: 42,
                          width: MediaQuery.of(context).size.width *
                              0.4,
                          decoration: BoxDecoration(
                              color: AppColor.disableColor,
                              borderRadius:
                              BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: SvgPicture.asset(
                                    AppAssets.clockIcon),
                              ),
                              Text(adminAddEventController
                                  .selectedStartTime.isNotEmpty?
                                adminAddEventController
                                    .selectedStartTime.value:"Start Time",
                                style: GoogleFonts.poppins(
                                    color: AppColor.lightTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      adminAddEventController.pickEndTime(context);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "End Time",
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8),
                          height: 42,
                          width: MediaQuery.of(context).size.width *
                              0.4,
                          decoration: BoxDecoration(
                              color: AppColor.disableColor,
                              borderRadius:
                              BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: SvgPicture.asset(
                                    AppAssets.clockIcon),
                              ),
                              Text(adminAddEventController
                                  .selectedEndTime.isNotEmpty?
                                adminAddEventController
                                    .selectedEndTime.value:
                                    "End Time",
                                style: GoogleFonts.poppins(
                                    color: AppColor.lightTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20,),
              Text("Select Invitees",
                  style: GoogleFonts.poppins(
                      color: AppColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Select Invitees",
                      style: GoogleFonts.poppins(
                          color: AppColor.lightTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                  SvgPicture.asset(AppAssets.roundedAdd)
                ],
              ),
              const SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }
}

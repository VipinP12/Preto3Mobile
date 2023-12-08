
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/Admin/drawer_controller/event_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/comman_textStyle.dart';
import 'package:preto3/utils/comman_textfield.dart';
import 'package:preto3/view/AdminModule/drawer/event_view/select_staff_invitees_page.dart';
import 'package:preto3/view/AdminModule/drawer/event_view/select_student_invitees_page.dart';

class EventAddPage extends StatelessWidget {
  EventAddPage({super.key});

  final eventController = Get.find<EventController>();
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
          "Add Event",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
            child: InkWell(
              onTap: () {
            
              },
              child:Text(
          "Save",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Row(
      children: [
        Obx(() => Checkbox(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          value: eventController.isAllDayEventChecked.value,
          onChanged: (value) {
            eventController.allDayEventCheckbox(value);
          },
        )),
        Text(
          "All Day Event",
          style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),
        ),
      ],
    ),
    Row(
      children: [
        Obx(() => Checkbox(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          value: eventController.isAnnouncementChecked.value,
          onChanged: (value) {
            eventController.announcementCheckbox(value);
          },
        )),
        Text(
          "Announcement",
          style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),
        ),
      ],
    ),
  ],
),
const SizedBox(height: 20),
             CommonTextField(
              title: "Event Title",
               hintText: "Event name",
                onSaved: (value) {
                 },
                  ),
                  CommonTextField(
              title: "Event Venue",
               hintText: "Event venue",
                onSaved: (value) {
                 },
                  ),
                  CommonTextField(
              title: "Description",
               hintText: "Description",
                onSaved: (value) {
                 },
                  ),
Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                    "Start Date",
                                    style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),
                                  ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 8.0,),
                                      child: InkWell(
                                        onTap: () {
                                          // eventController.pickStartDate(context);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 20,),
                                          height: 45,
                                          decoration: BoxDecoration(
                                              color: AppColor.disableColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            children: [
                                          SvgPicture.asset(
                                                    AppAssets.calenderIcon),
                                              const SizedBox(width: 20),
                                              Obx(() => eventController
                                                      .filteredStartDate.isNotEmpty
                                                  ? Text(
                                                      eventController
                                                          .filteredStartDate
                                                          .toString(),
                                                      style: GoogleFonts.poppins(
                                                          color: AppColor
                                                              .heavyTextColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  : Text(
                                                      "Start Date",
                                                      style: GoogleFonts.poppins(
                                                          color: AppColor
                                                              .lightTextColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      Text(
                                    "End Date",
                                    style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),
                                  ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 8.0),
                                      child: InkWell(
                                        onTap: () {
                                          // eventController.pickEndDate(context);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          height: 45,
                                          decoration: BoxDecoration(
                                              color: AppColor.disableColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                          
                                            children: [
                                              
                                              SvgPicture.asset(
                                                    AppAssets.calenderIcon),
                                              
                                              const SizedBox(width: 20),
                                              Obx(() => eventController
                                                      .filteredEndDate.isNotEmpty
                                                  ? Text(
                                                      eventController
                                                          .filteredEndDate
                                                          .toString(),
                                                      style: GoogleFonts.poppins(
                                                          color: AppColor
                                                              .heavyTextColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  : Text(
                                                      "End Date",
                                                      style: GoogleFonts.poppins(
                                                          color: AppColor
                                                              .lightTextColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
          ],
        ),
        
const SizedBox(height: 10),
Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                    "Start Time",
                                    style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),
                                  ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 8.0,),
                                      child: InkWell(
                                        onTap: () {
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          height: 45,
                                          decoration: BoxDecoration(
                                              color: AppColor.disableColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            children: [
                                          SvgPicture.asset(
                                                    AppAssets.clockIcon),
                                              const SizedBox(width: 20),
                                               Text(
                                                      "Start Time",
                                                      style: GoogleFonts.poppins(
                                                          color: AppColor
                                                              .lightTextColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      Text(
                                    "End Time",
                                    style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),
                                  ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 8.0),
                                      child: InkWell(
                                        onTap: () {
                                        
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          height: 45,
                                          decoration: BoxDecoration(
                                              color: AppColor.disableColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                          
                                            children: [
                                              
                                              SvgPicture.asset(
                                                    AppAssets.clockIcon),
                                              
                                              const SizedBox(width: 20),
                                            Text(
                                                      "End Time",
                                                      style: GoogleFonts.poppins(
                                                          color: AppColor
                                                              .lightTextColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
          ],
        ),
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
     Padding(
       padding: const EdgeInsets.symmetric(vertical: 16),
       child: Text(
            "Select Invitees",
            style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 16),
             ),
     ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
  "Select Invitees (Staff)",style: TextStyles.textStyleFW400(AppColor.hintTextColor, 14),),   
      InkWell(  
                           onTap: () { 
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectStaffInvitees()));
                            },   
                             child: SvgPicture.asset(
                               AppAssets.roundedAdd,
                           fit: BoxFit.scaleDown,
                             )
                              ),
                              
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
  "Select Invitees (Students)",style: TextStyles.textStyleFW400(AppColor.hintTextColor, 14),),   
      InkWell(  
                           onTap: () { 
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectStudentInvitees()));
                            },   
                             child: SvgPicture.asset(
                               AppAssets.roundedAdd,
                           fit: BoxFit.scaleDown,
                             )
                              ),
               
              ],
            ),
          ],
        ),
  ],
)
        ,])
      ),
      ));
        }
}

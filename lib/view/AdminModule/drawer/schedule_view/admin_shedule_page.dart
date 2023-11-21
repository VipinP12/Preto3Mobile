import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/view/AdminModule/drawer/schedule_view/schedule_bottomsheet.dart';
import 'package:preto3/view/AdminModule/drawer/schedule_view/staff_schedule.dart';
import 'package:preto3/view/AdminModule/drawer/schedule_view/students_schedule.dart';

import '../../../../components/schedule_dialog.dart';
import '../../../../components/success_dialog.dart';
import '../../../../controller/Admin/admin_schedule_controller.dart';
import '../../../../model/parent/parent_students_model.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/comman_textStyle.dart';

class AdminSchedule extends StatelessWidget {
  AdminSchedule({super.key});

  final adminScheduleController = Get.find<AdminScheduleController>();

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
          AppString.schedule,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: InkWell(
                onTap: () {
                  // _bottomFilterDateSheet(context);
                },
                child: Icon(Icons.add, color: AppColor.white, size: 30,)
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    // eventController.previousDate();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(40),
                        border: Border.all(
                            color: AppColor.borderColor,
                            width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        AppAssets.backwardIcon,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Text("10/26/2022",
                  style: TextStyles.textStyleFW500(
                      AppColor.heavyTextColor, 16),),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(40),
                        border: Border.all(
                            color: AppColor.borderColor,
                            width: 1)),
                    child: SvgPicture.asset(
                      AppAssets.forwardIcon,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ],
            ),
            TabBar(
              tabs: adminScheduleController.scheduleTabs,
              controller: adminScheduleController.tabController,
              labelColor: AppColor.appPrimary,
              indicatorColor: AppColor.appPrimary,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
                child: TabBarView(
                  controller: adminScheduleController.tabController,
                  children: adminScheduleController.scheduleTabs.map((Tab tab) {
                    if (tab.text == AppString.studentList) {
                      return InkWell(
                          onTap: () {
                            print("students data");
                            showModalBottomSheet(
                              // isScrollControlled:true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              isDismissible: true,
                              enableDrag: false,
                              builder: (context) {
                                return   SingleChildScrollView(
                                  child: ScheduleBottomSheet(),
                                );
                              },
                            );
                          },
                          child: StudentSchedule());
                    } else {
                      return InkWell(
                          onTap: () {
                            print("staff data");
                          },
                          child: StaffSchedule());
                    }
                  }).toList(),
                )
            )
          ],
        ),
      ),
    );
  }

}

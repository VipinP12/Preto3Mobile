import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:preto3/controller/daily_activity_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';

class ActivePage extends StatelessWidget {
  ActivePage({super.key});

  final dailyActivityController = Get.find<DailyActivityController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(176, 26, 167, 0.15),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Today ${DateFormat("MM/dd/yyyy").format(DateTime.now())}",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            dailyActivityController.notFound.isTrue
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: SvgPicture.asset(AppAssets.notFoundIcon),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(
                          child: Text(
                            "No content found",
                            style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  )
                : GetBuilder<DailyActivityController>(
                    builder: (controller) => Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.activityList.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 4,
                                  shadowColor: AppColor.borderColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          leading: controller
                                                      .activityList[index]
                                                      .activityId ==
                                                  12
                                              ? Container(
                                                  height: 42,
                                                  width: 42,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: AppColor
                                                              .borderColor,
                                                          width: 0.6),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              42)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: SvgPicture.asset(
                                                      AppAssets.lunchIcon,
                                                      color:
                                                          AppColor.appPrimary,
                                                      height: 24,
                                                      width: 24,
                                                    ),
                                                  ))
                                              : controller.activityList[index]
                                                          .activityId ==
                                                      19
                                                  ? Container(
                                                      height: 42,
                                                      width: 42,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: AppColor
                                                                  .borderColor,
                                                              width: 0.6),
                                                          borderRadius:
                                                              BorderRadius.circular(42)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SvgPicture.asset(
                                                          AppAssets.playIcon,
                                                          color:
                                                              AppColor.outdoor,
                                                          height: 24,
                                                          width: 24,
                                                        ),
                                                      ))
                                                  : controller.activityList[index].activityId == 4
                                                      ? Container(
                                                          height: 42,
                                                          width: 42,
                                                          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColor.borderColor, width: 0.6), borderRadius: BorderRadius.circular(42)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: SvgPicture
                                                                .asset(
                                                              AppAssets
                                                                  .milkIcon,
                                                              color: AppColor
                                                                  .appPrimary,
                                                              height: 24,
                                                              width: 24,
                                                            ),
                                                          ))
                                                      : controller.activityList[index].activityId == 3
                                                          ? Container(
                                                              height: 42,
                                                              width: 42,
                                                              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColor.borderColor, width: 0.6), borderRadius: BorderRadius.circular(42)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  AppAssets
                                                                      .sleepIcon,
                                                                  color: AppColor
                                                                      .appPrimary,
                                                                  height: 24,
                                                                  width: 24,
                                                                ),
                                                              ))
                                                          : Container(
                                                              height: 42,
                                                              width: 42,
                                                              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColor.borderColor, width: 0.6), borderRadius: BorderRadius.circular(42)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  AppAssets
                                                                      .breakfastIcon,
                                                                  color: AppColor
                                                                      .appPrimary,
                                                                  height: 24,
                                                                  width: 24,
                                                                ),
                                                              )),
                                          contentPadding: const EdgeInsets.only(
                                              top: 10, bottom: 5),
                                          title: Text(
                                            controller.activityList[index]
                                                        .activityId ==
                                                    12
                                                ? "Lunch"
                                                : controller.activityList[index]
                                                            .activityId ==
                                                        19
                                                    ? "Outdoor Play"
                                                    : controller
                                                                .activityList[
                                                                    index]
                                                                .activityId ==
                                                            4
                                                        ? "Afternoon Snacks"
                                                        : controller
                                                                    .activityList[
                                                                        index]
                                                                    .activityId ==
                                                                3
                                                            ? "Nap"
                                                            : "Evening Snacks",
                                            style: GoogleFonts.poppins(
                                                color: AppColor.heavyTextColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          subtitle: Text(
                                            "${DateFormat("hh:mm a").format(DateTime.parse(controller.activityList[index].activityStartTime))} to ${DateFormat("hh:mm a").format(DateTime.parse(controller.activityList[index].activityStartTime))}",
                                            style: GoogleFonts.poppins(
                                                color: AppColor.heavyTextColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5, left: 2),
                                          child: Text(
                                            controller.activityList[index].name,
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.poppins(
                                                color: AppColor.heavyTextColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:preto3/components/rounded_button.dart';
import 'package:preto3/controller/event_controller.dart';
import 'package:preto3/model/all_event_model.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/app_string.dart';
import 'package:preto3/utils/argument_keys.dart';

class EventPage extends StatelessWidget {
  EventPage({Key? key}) : super(key: key);

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
          AppString.events,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          eventController.roleId.value == 2
              ? Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: InkWell(
                    onTap: () {
                      // _bottomFilterDateSheet(context);
                      Get.toNamed(AppRoute.adminAddEvent);
                    },
                    child: SvgPicture.asset(
                      AppAssets.addIcon,
                      height: 24,
                      width: 24,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: InkWell(
              onTap: () {
                _bottomFilterDateSheet(context);
              },
              child: SvgPicture.asset(
                AppAssets.filterIcon,
                height: 24,
                width: 24,
              ),
            ),
          ),
        ],
      ),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool isInnerScroll) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              eventController.filteredDate.isTrue
                                  ? const SizedBox.shrink()
                                  : InkWell(
                                      onTap: () {
                                        eventController.previousDate();
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
                              Obx(() => eventController.filteredDate.isTrue
                                  ? Text(
                                      "${eventController.selectedStartDate.value} - ${eventController.selectedEndDate.value}")
                                  : Text(eventController.selectedDate.value)),
                              eventController.filteredDate.isTrue
                                  ? const SizedBox.shrink()
                                  : InkWell(
                                      onTap: () {
                                        eventController.nextDate();
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
                                        child: SvgPicture.asset(
                                          AppAssets.forwardIcon,
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),
                            ],
                          )),
                    ),
                  ],
                ),
              )
            ];
          },
          body: Obx(() => eventController.noContentFound.isTrue
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
                          "No events available",
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: GetBuilder<EventController>(
                    builder: (controller) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        children: [
                          eventController.ongoingEvent.value.isNotEmpty
                              ? Column(
                                  children: [
                                    _getGroupSeparator("Ongoing Events"),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      itemCount: eventController
                                          .ongoingEvent.value.length,
                                      itemBuilder: (context, element) {
                                        return listEvent(eventController
                                            .ongoingEvent.value[element]);
                                      },
                                    ),
                                  ],
                                )
                              : Container(),
                          eventController.upcomingEvent.value.isNotEmpty
                              ? Column(
                                  children: [
                                    _getGroupSeparator("Upcoming Events"),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: eventController
                                          .upcomingEvent.value.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      itemBuilder: (context, element) {
                                        return listEvent(eventController
                                            .upcomingEvent.value[element]);
                                      },
                                    ),
                                  ],
                                )
                              : Container(),
                          eventController.pastEvent.value.isNotEmpty
                              ? Column(
                                  children: [
                                    _getGroupSeparator("Past Events"),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: eventController
                                          .pastEvent.value.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      itemBuilder: (context, element) {
                                        return listEvent(eventController
                                            .pastEvent.value[element]);
                                      },
                                    ),
                                  ],
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                ))),
    );
  }

  Widget listEvent(AllEventModel element) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoute.eventDetails,
              arguments: {ArgumentKeys.argumentEventMap: element});
        },
        child: Container(
          height: 82,
          width: 230,
          decoration: BoxDecoration(
              color: AppColor.white,
              border: Border.all(
                color: AppColor.borderColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(AppAssets.eventSubtractIcon),
                  Text(
                    DateFormat.yMd()
                        .format(DateTime.parse(element.eventStartTime))
                        .split("/")[1],
                    style: GoogleFonts.poppins(
                        color: AppColor.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    element.eventTitle!.isNotEmpty
                        ? element.eventTitle.toString()
                        : "null",
                    style: GoogleFonts.poppins(
                        color: AppColor.heavyTextColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${DateFormat.yMd().format(DateTime.parse(element.eventStartTime))} - ${element.eventEndTime!.isNotEmpty ? DateFormat.yMd().format(DateTime.parse(element.eventEndTime.toString())) : "Null"}',
                    style: GoogleFonts.poppins(
                        color: AppColor.mediumTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SvgPicture.asset(
                AppAssets.forwardIcon,
                fit: BoxFit.scaleDown,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getGroupSeparator(String element) {
    return Container(
      height: 40,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColor.profileHeaderBG,
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            element,
            style: GoogleFonts.poppins(
                color: AppColor.heavyTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  void _bottomFilterDateSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        isDismissible: false,
        builder: (ctx) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setter) {
            return Obx(() => Container(
                height: eventController.roleId.value == 4
                    ? MediaQuery.of(context).size.height * 0.6
                    : MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      topLeft: Radius.circular(5)),
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            topLeft: Radius.circular(5)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 54,
                            width: double.maxFinite,
                            decoration: const BoxDecoration(
                                color: AppColor.appPrimary,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  topLeft: Radius.circular(5),
                                )),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Apply filter",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: InkWell(
                                    onTap: () {
                                      eventController.pickStartDate(context);
                                    },
                                    child: Container(
                                      height: 45,
                                      width: double.maxFinite,
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
                                                AppAssets.calenderIcon),
                                          ),
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
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: InkWell(
                                    onTap: () {
                                      eventController.pickEndDate(context);
                                    },
                                    child: Container(
                                      height: 45,
                                      width: double.maxFinite,
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
                                                AppAssets.calenderIcon),
                                          ),
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
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: RoundedButton(
                                      height: 50,
                                      width: 320,
                                      color: AppColor.appPrimary,
                                      onClick: () {
                                        Get.back();
                                        eventController.filteredDate.value =
                                            true;
                                        eventController.filterEvent(
                                            eventController.startEpoch.value,
                                            eventController.endEpoch.value);
                                      },
                                      text: 'Apply',
                                      style: GoogleFonts.poppins(
                                          color: AppColor.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 10,
                      child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset(AppAssets.closeFilterIcon)),
                    )
                  ],
                )));
          });
        });
  }
}

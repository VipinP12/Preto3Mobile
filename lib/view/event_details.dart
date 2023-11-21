import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:preto3/controller/event_details_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';

class EventDetails extends StatelessWidget {
  EventDetails({Key? key}) : super(key: key);

  final eventController = Get.find<EventDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: AppColor.scaffoldBackground,
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool isInnerScroll) {
              return [
                SliverAppBar(
                  expandedHeight: 320,
                  floating: false,
                  pinned: true,
                  title: Text(
                    "Event Details",
                    style: GoogleFonts.poppins(
                        color: AppColor.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: const Image(
                      image: AssetImage(AppAssets.profileBg),
                      fit: BoxFit.fill,
                    ),
                    title: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 90,
                            ),
                            Text(
                              eventController.allEventModel!.eventTitle
                                  .toString(),
                              style: GoogleFonts.poppins(
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                runAlignment: WrapAlignment.start,
                                children: [
                                  Text(
                                    eventController.allEventModel!.description
                                        .toString(),
                                    style: GoogleFonts.poppins(
                                        color: AppColor.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
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
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 140,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: AppColor.borderColor,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Invitee",
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Stack(
                                      children: [
                                        for (int i = 0;
                                            i <
                                                eventController
                                                    .inviteeList.length;
                                            i++)
                                          Positioned(
                                              left: i * 30,
                                              top: 5,
                                              child: Container(
                                                  height: 42,
                                                  width: 42,
                                                  decoration: BoxDecoration(
                                                      color: AppColor.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              42)),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            42),
                                                    child: CachedNetworkImage(
                                                      placeholder:
                                                          (context, url) =>
                                                              const Image(
                                                        height: 65,
                                                        width: 65,
                                                        image: AssetImage(
                                                          AppAssets.placeHolder,
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      height: 65,
                                                      width: 65,
                                                      imageUrl: eventController
                                                          .inviteeList[i],
                                                      fit: BoxFit.cover,
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Image(
                                                        height: 65,
                                                        width: 65,
                                                        image: AssetImage(
                                                          AppAssets.placeHolder,
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ))),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      eventController.inviteeList.length > 6
                                          ? "6+"
                                          : "",
                                      style: GoogleFonts.poppins(
                                          color: AppColor.heavyTextColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Text(
                                    eventController.inviteeList.length > 6
                                        ? "View all"
                                        : "",
                                    style: GoogleFonts.poppins(
                                        color: AppColor.invoiceNumberColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 80,
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: AppColor.appPrimary,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: SvgPicture.asset(
                                AppAssets.dashboardEvent,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: VerticalDivider(
                                thickness: 1,
                                color: AppColor.black,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${DateFormat("MM/dd/yyyy").format(DateTime.parse(eventController.allEventModel!.eventStartTime))} ${eventController.allEventModel!.eventEndTime!.isNotEmpty ? "-" : ""} ${eventController.allEventModel!.eventEndTime!.isNotEmpty ? DateFormat("MM/dd/yyyy").format(DateTime.parse(eventController.allEventModel!.eventEndTime.toString())) : ""}",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "${DateFormat("hh:mm a").format(DateTime.parse(eventController.allEventModel!.eventStartTime))} ${eventController.allEventModel!.eventEndTime!.isNotEmpty ? "-" : ""}  ${eventController.allEventModel!.eventEndTime!.isNotEmpty ? DateFormat("hh:mm a").format(DateTime.parse(eventController.allEventModel!.eventEndTime.toString())) : ""}",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.mediumTextColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 80,
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: AppColor.appPrimary,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: SvgPicture.asset(
                                AppAssets.locationIcon,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: VerticalDivider(
                                thickness: 1,
                                color: AppColor.black,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  eventController
                                      .allEventModel!.eventVenueAddress,
                                  style: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  eventController.schoolName.value,
                                  style: GoogleFonts.poppins(
                                      color: AppColor.mediumTextColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          bottomNavigationBar: eventController.roleId.value == 4
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 80,
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Going for event?",
                            style: GoogleFonts.poppins(
                                color: AppColor.heavyTextColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: eventController.isPastEvent.value
                                ? eventController.eventActionListDisable
                                    .asMap()
                                    .entries
                                    .map(
                                      (element) => Container(
                                        height: 42,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: eventController
                                                        .selectedAction.value ==
                                                    element.key
                                                ? element.value.colors
                                                : element.value.bgColors,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: element.value.colors)),
                                        child: Center(
                                          child: Text(
                                            element.value.name,
                                            style: GoogleFonts.poppins(
                                                color: eventController
                                                            .selectedAction
                                                            .value ==
                                                        element.key
                                                    ? AppColor.white
                                                    : element.value.colors,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList()
                                : eventController.eventActionList
                                    .asMap()
                                    .entries
                                    .map(
                                      (element) => InkWell(
                                        onTap: () {
                                          print(
                                              "ELEMENT SELECTED:${element.value.respondStatus}");
                                          eventController
                                              .setAction(element.key);
                                        },
                                        child: Container(
                                          height: 42,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: eventController
                                                          .selectedAction
                                                          .value ==
                                                      element.key
                                                  ? element.value.colors
                                                  : element.value.bgColors,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: element.value.colors)),
                                          child: Center(
                                            child: Text(
                                              element.value.name,
                                              style: GoogleFonts.poppins(
                                                  color: eventController
                                                              .selectedAction
                                                              .value ==
                                                          element.key
                                                      ? AppColor.white
                                                      : element.value.colors,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ));
  }
}

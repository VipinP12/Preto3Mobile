import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:preto3/controller/Parent/parent_student_details_controller.dart';

import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/view/ParentModule/tab/activity_page.dart';
import 'package:preto3/view/ParentModule/tab/in_out_page.dart';

class ParentStudentDetailsPage extends StatelessWidget {
  ParentStudentDetailsPage({super.key});
  final studentDetailsController = Get.find<ParentStudentDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.scaffoldBackground,
        body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool isInnerScroll) {
              return [
                SliverAppBar(
                  floating: false,
                  pinned: true,
                  expandedHeight: 280,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: const Image(
                      image: AssetImage(AppAssets.profileBg),
                      fit: BoxFit.fill,
                    ),
                    title: SingleChildScrollView(
                      child: SizedBox(
                          height: 200,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 65,
                                  width: 65,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.circular(65)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(65),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: studentDetailsController
                                          .profilePic
                                          .toString(),
                                      errorWidget: (context, url, error) {
                                        return Image.asset(
                                            AppAssets.placeHolder);
                                      },
                                    ),
                                  ),
                                ),
                                Text(
                                  "${studentDetailsController.firstName.value} ${studentDetailsController.lastName.value}",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text("Student ",
                                    style: GoogleFonts.poppins(
                                        color: AppColor.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  "Check in/out Pin: ${studentDetailsController.checkinPin.value}",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ])),
                    ),
                    titlePadding: const EdgeInsetsDirectional.only(
                      top: 100,
                      bottom: 2,
                    ),
                  ),
                  actions: <Widget>[
                    IconButton(
                      iconSize: 110,
                      icon: Stack(
                        children: <Widget>[
                          Text(
                            "View Profile",
                            style: GoogleFonts.poppins(
                                color: AppColor.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      onPressed: () {
                        Get.toNamed(AppRoute.childProfileDetails);
                      },
                    ),
                  ],
                )
              ];
            },
            body: DefaultTabController(
              length: 2,
              child: Column(
                children: <Widget>[
                  Container(
                    constraints: const BoxConstraints.expand(height: 80),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TabBar(labelColor: AppColor.heavyTextColor, tabs: [
                        Tab(
                          icon: SvgPicture.asset(AppAssets.navCheckIn),
                          text: "In/out",
                        ),
                        Tab(
                          icon: SvgPicture.asset(AppAssets.navActivityIcon),
                          text: "Activity",
                        ),
                        // Tab(
                        //   icon: SvgPicture.asset(AppAssets.navScheduleIcon),
                        //   text: "Schedule",
                        // ),
                      ]),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        InOutPage(
                            studentDetailsController.inTime.value != "-"
                                ? DateFormat('hh:mm a').format(DateTime
                                    .fromMillisecondsSinceEpoch(int.parse(
                                        studentDetailsController.inTime.value)))
                                : "-",
                            studentDetailsController.outTime.value != "-"
                                ? DateFormat('hh:mm a').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        int.parse(studentDetailsController
                                            .outTime.value)))
                                : "-",
                            studentDetailsController.totalHours.value),
                        ActivePage(),

                        //SchdulePage()
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}

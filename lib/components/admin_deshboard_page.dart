import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/Admin/admin_deshboard_controller.dart';
import '../network/is_internet_connected.dart';
import '../network/socket_server.dart';
import '../utils/app_routes.dart';
import '../utils/toast.dart';
import 'admin/admin_drawer.dart';

class AdminDashBoardPage extends StatelessWidget {
  AdminDashBoardPage({Key? key}) : super(key: key);
  final parentDashboardController = Get.find<AdminDashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      key: parentDashboardController.scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColor.appPrimary,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              print("hello********");
              parentDashboardController.openDrawer();
            },
            child: SvgPicture.asset(
              AppAssets.navMenuIcon,
              height: 30,
              width: 30,
              fit: BoxFit.scaleDown,
            )),
        centerTitle: false,
        title: Text(
          "Hi ${parentDashboardController.firstName.value}",
          style: GoogleFonts.poppins(
              color: AppColor.white,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.add,size: 30,),
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      Container()
                      // showQRDialog()
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(AppAssets.qrCode),
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     Get.toNamed(AppRoute.scannerPage);
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.only(right: 8.0),
          //     child: SvgPicture.asset(AppAssets.qrScanner),
          //   ),
          // )
        ],
      ),
      drawer: AdminDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 20,horizontal: 20),
              // height: MediaQuery.of(context).size.height/5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: AppColor.borderColor),
                  borderRadius: BorderRadius.circular(10)),
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(AppAssets.totalStudent),
                            const SizedBox(width: 20,),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Total Student",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColor.black
                                  ),),
                                Text("350",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColor.black
                                  ),)
                              ],
                            ),
                          ],
                        ),
                        Container(),
                        Icon(Icons.arrow_forward_ios_outlined)
                      ],),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text("In"),
                            Text("6")
                          ],
                        ),
                        Container(
                          height: 30,
                          width: 0.5,
                          color: Colors.black,
                        ),
                        Column(
                          children: [
                            Text("Out"),
                            Text("0")
                          ],
                        ),
                        Container(
                          height: 30,
                          width: 0.5,
                          color: Colors.black,
                        ),
                        Column(
                          children: [
                            Text("Absent"),
                            Text("0")
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ),
            Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 0,horizontal: 20),
                // height: MediaQuery.of(context).size.height/5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: AppColor.borderColor),
                    borderRadius: BorderRadius.circular(10)),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(AppAssets.totalStudent),
                              const SizedBox(width: 20,),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Total Staff",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: AppColor.black
                                    ),),
                                  Text("14",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: AppColor.black
                                    ),)
                                ],
                              ),
                            ],
                          ),
                          Container(),
                          Icon(Icons.arrow_forward_ios_outlined)
                        ],),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text("In"),
                              Text("6")
                            ],
                          ),
                          Container(
                            height: 30,
                            width: 0.5,
                            color: Colors.black,
                          ),
                          Column(
                            children: [
                              Text("Out"),
                              Text("0")
                            ],
                          ),
                          Container(
                            height: 30,
                            width: 0.5,
                            color: Colors.black,
                          ),
                          Column(
                            children: [
                              Text("Absent"),
                              Text("0")
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
            ),
            Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 20,horizontal: 20),
                // height: MediaQuery.of(context).size.height/5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: AppColor.dashRoomText.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10)),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child:   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.roomsIcon),
                          const SizedBox(width: 20,),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Rooms",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: AppColor.dashRoomText
                                ),),
                              Text("4 Rooms",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColor.dashRoomText
                                ),)
                            ],
                          ),
                        ],
                      ),
                      Container(),
                      const Icon(Icons.arrow_forward_ios_outlined,color: AppColor.dashRoomText,)
                    ],),
                )
            ),
            Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 0,horizontal: 20),
                // height: MediaQuery.of(context).size.height/5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: AppColor.dashCheckInText.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10)),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child:   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.checkInCheckOut),
                          const SizedBox(width: 20,),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Check In/Out",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: AppColor.dashCheckInText
                                ),),
                            ],
                          ),
                        ],
                      ),
                      Container(),
                      const Icon(Icons.arrow_forward_ios_outlined,color: AppColor.dashCheckInText,)
                    ],),
                )
            ),
            Container(
                margin: const EdgeInsets.only(
                    left: 20,right: 20,top: 20,bottom: 10),
                // height: MediaQuery.of(context).size.height/5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: AppColor.dashCommText.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10)),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child:   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.msgIcon),
                          const SizedBox(width: 20,),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Communications",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: AppColor.dashCommText
                                ),),
                            ],
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: AppColor.dashCommText,
                                borderRadius: BorderRadius.circular(50)
                            ),
                            child: Center(child: Text("2",style: TextStyle(color: Colors.white),)),
                          ),
                          SizedBox(width: 15,),
                          const Icon(Icons.arrow_forward_ios_outlined,color: AppColor.dashCommText,),
                        ],
                      )
                    ],),
                )
            ),
            Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 10,horizontal: 20),
                // height: MediaQuery.of(context).size.height/5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: AppColor.dashFeesText.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10)),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child:   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.feeIcon),
                          const SizedBox(width: 20,),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Fee Management",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: AppColor.dashFeesText
                                ),),
                            ],
                          ),
                        ],
                      ),
                      Container(),
                      const Icon(Icons.arrow_forward_ios_outlined,color: AppColor.dashFeesText,)
                    ],),
                )
            ),
            Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 10,horizontal: 20),
                // height: MediaQuery.of(context).size.height/5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: AppColor.dashSchoolSettingText.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10)),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child:   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.schoolIcon),
                          const SizedBox(width: 20,),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("School Settings",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: AppColor.dashSchoolSettingText
                                ),),
                            ],
                          ),
                        ],
                      ),
                      Container(),
                      const Icon(Icons.arrow_forward_ios_outlined,color: AppColor.dashSchoolSettingText,)
                    ],),
                )
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}

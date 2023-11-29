import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/Communication/communication_controller.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/app_string.dart';
import '../../network/socket_server.dart';
import '../../utils/app_keys.dart';
import 'StafCommunicationTabs/groups_screen_tab.dart';
import 'StafCommunicationTabs/staffs_screen_tab.dart';
import 'StafCommunicationTabs/student_screen_tab.dart';

class CommunicationPage extends StatefulWidget {
  const CommunicationPage({super.key});

  @override
  State<CommunicationPage> createState() => _CommunicationPageState();
}

class _CommunicationPageState extends State<CommunicationPage> {
  @override
  void initState() {
    //SocketServer.instance!.socket.close();
    super.initState();
  }

  @override
  void dispose() {
    log("Destroy select  role===============");
    //SocketServer.instance!.socket.close();
    super.dispose();
  }

  final commController = Get.find<CommunicationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          centerTitle: false,
          title: Text(
            AppString.communication,
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          actions: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 24,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: InkWell(
                onTap: () => Get.toNamed(AppRoute.createStaffAdminGroup),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              tabs: commController.myTabs,
              controller: commController.tabController,
              labelColor: AppColor.appPrimary,
              indicatorColor: AppColor.appPrimary,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
                child: TabBarView(
                    controller: commController.tabController,
                    children: const [
                  StudentScreentTabs(),
                  StaffScreenTab(),
                  GroupScreenTab()
                ]))
          ],
        ));
  }

  Widget noStudentGrouStafFround(String textVal) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Text(
          textVal,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              color: AppColor.heavyTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

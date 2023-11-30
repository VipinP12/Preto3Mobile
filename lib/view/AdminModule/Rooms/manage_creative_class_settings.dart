import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/Admin/rooms_controller/manage_creative_class_settings_controller.dart';
import 'package:preto3/model/room/manage_creative_class_settings_model.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_string.dart';
import 'package:preto3/utils/argument_keys.dart';
import 'package:preto3/view/AdminModule/Rooms/manage_creative_class_staff.dart';

class ManageCreativeClassSettings extends StatelessWidget {
  ManageCreativeClassSettings({super.key});
  final manageCreativeClassSettingsController =
      Get.find<ManageCreativeClassSettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
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
          AppString.manageCreativeClass,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Text(
                "Save",
                style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 242, 238, 241),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Room Name",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 39, 37, 39),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 0.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Get.arguments[ArgumentKeys.argumentClassName],
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 39, 37, 39),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0), // Adjust the padding as needed
                child: Container(
                  height: 1,
                  color: Color.fromARGB(255, 226, 225, 225),
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TabBar(
            tabs: manageCreativeClassSettingsController.myTabs,
            controller: manageCreativeClassSettingsController.tabController,
            labelColor: AppColor.appPrimary,
            unselectedLabelColor: const Color.fromARGB(
                255, 118, 111, 117), // Unselected tab color

            indicatorColor: AppColor.appPrimary,
            indicatorSize: TabBarIndicatorSize.tab,
            onTap: (index) {
              // Update the hint text based on the selected tab
              if (index == 0) {
                manageCreativeClassSettingsController.hintText.value =
                    "Search student";
              } else if (index == 1) {
                manageCreativeClassSettingsController.hintText.value =
                    "Search staff";
              }
              manageCreativeClassSettingsController.update();
            },
          ),
          Expanded(
            child: TabBarView(
              controller: manageCreativeClassSettingsController.tabController,
              children:
                  manageCreativeClassSettingsController.myTabs.map((Tab tab) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 224, 216,
                              216), // Set the background color to grey

                          border: Border.all(
                              color: const Color.fromARGB(255, 222, 217, 217)),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                            ),
                            Obx(() => Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText:
                                          manageCreativeClassSettingsController
                                              .hintText.value,
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      border: InputBorder
                                          .none, // Set border to none
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: tab.text == AppString.studentList
                          ? manageCreativeClassSettingsController.isError.isTrue
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(AppAssets.errorIcon),
                                      Text(
                                        AppString.errorTitle,
                                        style: GoogleFonts.poppins(
                                            color: AppColor.heavyTextColor,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        manageCreativeClassSettingsController
                                            .errorMessage.value,
                                        style: GoogleFonts.poppins(
                                          color: AppColor.mediumTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: GetBuilder(
                                    init: manageCreativeClassSettingsController,
                                    builder: ((controller) =>
                                        ListView.separated(
                                          itemCount:
                                              controller.personList.length,
                                          itemBuilder: (context, index) {
                                            ManageCreativeClassSettingsModel
                                                value =
                                                controller.personList[index];
                                            return ListTile(
                                              leading: Stack(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                        value.profilePicture),
                                                  ),
                                                  if (value.inRoom)
                                                    Positioned(
                                                      bottom: 0,
                                                      right: 0,
                                                      child: Container(
                                                        width: 12,
                                                        height: 12,
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .green),
                                                      ),
                                                    )
                                                  else
                                                    Positioned(
                                                      bottom: 0,
                                                      right: 0,
                                                      child: Container(
                                                        width: 12,
                                                        height: 12,
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        180,
                                                                        183,
                                                                        180)),
                                                      ),
                                                    )
                                                ],
                                              ),
                                              title: Text(value.name),
                                              trailing: ElevatedButton.icon(
                                                onPressed: () {
                                                  controller
                                                      .toggleInRoomsStatus(
                                                          index);
                                                },
                                                icon: Icon(
                                                  value.inRoom
                                                      ? Icons.check
                                                      : Icons.add,
                                                  color: value.inRoom
                                                      ? Colors.purple
                                                      : Colors.grey,
                                                ),
                                                label: Text(
                                                  value.inRoom
                                                      ? "In Room"
                                                      : "Add to Room",
                                                  style: TextStyle(
                                                      color: value.inRoom
                                                          ? Colors.purple
                                                          : Colors.grey),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.white,
                                                    onPrimary: Colors.purple,
                                                    side: const BorderSide(
                                                        color: Colors.purple)),
                                              ),
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return const Divider(
                                              color: Colors.grey,
                                              thickness: 0.6,
                                            );
                                          },
                                        )),
                                  ),
                                )
                          : ManageCreativeClassStaff(),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

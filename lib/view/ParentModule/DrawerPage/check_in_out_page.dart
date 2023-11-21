import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../controller/Parent/DrawerController/check_in_out_controller.dart';
import '../../../model/parent/parent_students_model.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_color.dart';
import '../../../utils/toast.dart';

class CheckInOutParentPage extends StatelessWidget {
  CheckInOutParentPage({super.key});
  final checkInOutController = Get.find<CheckInOutController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColor.appPrimary,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back),
        ),
        centerTitle: false,
        title: Text(
          "Check In/Out",
          style: GoogleFonts.poppins(
              color: AppColor.white, fontSize: 18, fontWeight: FontWeight.w400),
        ),
        actions: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                isDismissible: true,
                enableDrag: false,
                builder: (context) {
                  return Wrap(
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        alignment: Alignment.centerRight,
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child:
                                SvgPicture.asset(AppAssets.bottomBarCloseIcon)),
                      ),
                      Container(
                        color: AppColor.white,
                        padding: const EdgeInsets.only(bottom: 70),
                        child: Column(children: [
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            color: AppColor.appPrimary,
                            padding: const EdgeInsets.only(left: 20),
                            alignment: Alignment.centerLeft,
                            child: Text("Apply Filter",
                                style: GoogleFonts.poppins(
                                    color: AppColor.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 40,
                                    margin: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                            onTap: () async {
                                              checkInOutController
                                                  .setStartFilterDate(
                                                      await checkInOutController
                                                          .pickDate(context));
                                            },
                                            child: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 15,
                                                    bottom: 15,
                                                    left: 10,
                                                    right: 30),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.grey.shade200,
                                                ),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .calendar_month_rounded,
                                                      size: 25,
                                                      color: AppColor.black,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Obx(
                                                        () => Text(
                                                          checkInOutController
                                                                  .filterStartDate
                                                                  .value
                                                                  .trim()
                                                                  .isEmpty
                                                              ? "Start date"
                                                              : DateFormat(
                                                                      "MM/dd/yyyy")
                                                                  .format(DateFormat(
                                                                          "yyyy-MM-dd")
                                                                      .parse(checkInOutController
                                                                          .filterStartDate
                                                                          .value)),
                                                          style: GoogleFonts.poppins(
                                                              color: AppColor
                                                                  .lightTextColor,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ))),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 40,
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                            onTap: () async {
                                              checkInOutController
                                                  .setEndFilterDate(
                                                      await checkInOutController
                                                          .pickDate(context));
                                            },
                                            child: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 15,
                                                    bottom: 15,
                                                    left: 10,
                                                    right: 30),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.grey.shade200,
                                                ),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .calendar_month_rounded,
                                                      size: 25,
                                                      color: AppColor.black,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Obx(
                                                        () => Text(
                                                          checkInOutController
                                                                  .filterEndDate
                                                                  .value
                                                                  .trim()
                                                                  .isEmpty
                                                              ? "End date"
                                                              : DateFormat(
                                                                      "MM/dd/yyyy")
                                                                  .format(DateFormat(
                                                                          "yyyy-MM-dd")
                                                                      .parse(checkInOutController
                                                                          .filterEndDate
                                                                          .value)),
                                                          style: GoogleFonts.poppins(
                                                              color: AppColor
                                                                  .lightTextColor,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ))),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              if (checkInOutController.studentId.value == 0) {
                                Navigator.pop(context);
                                messageToastWarning(
                                    context, "First you need to select child.");
                                return;
                              }
                              if (checkInOutController.filterStartDate
                                  .trim()
                                  .isEmpty) {
                                messageToastWarning(
                                    context, "Please select start date.");
                                return;
                              }
                              if (checkInOutController.filterEndDate
                                  .trim()
                                  .isEmpty) {
                                messageToastWarning(
                                    context, "Please select end date.");
                                return;
                              }
                              if (checkInOutController.dateDifference()) {
                                Navigator.pop(context);
                                checkInOutController
                                    .getCheckInOutFilterDetails(true);
                              } else {
                                messageToastWarning(
                                    context, "Date filter is not correct");
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.all(20),
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.appPrimary,
                              ),
                              child: Text("Apply",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                            ),
                          )
                        ]),
                      )
                    ],
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
              child: SvgPicture.asset(AppAssets.hemBurgerMenuIcon),
            ),
          ),
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
              child: Icon(
                Icons.file_download_outlined,
                size: 26,
                color: AppColor.white,
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: allChildDropDown(context),
              ),
              GetBuilder<CheckInOutController>(
                  builder: (controller) => controller.datam.isNotEmpty
                      ? DataTable(
                          showBottomBorder: false,
                          dividerThickness: 0,
                          columnSpacing: 10,
                          horizontalMargin: 0,
                          columns: const [
                            DataColumn(
                                label: Text('Date',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500))),
                            DataColumn(
                                label: Text('In Time',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500))),
                            DataColumn(
                                label: Text('Out Time',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500))),
                            DataColumn(
                                label: Text('Total Hours',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500))),
                          ],
                          rows: controller.datam.reversed.map((obj) {
                            return DataRow(cells: [
                              DataCell(Text(DateFormat("MM/dd/yyyy").format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      obj.date)))),
                              DataCell(Text(obj.checkInTime == 0
                                  ? "-"
                                  : DateFormat("hh:mm a").format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                              obj.checkInTime)
                                          .toUtc()))),
                              DataCell(Text(obj.checkOutTime == 0
                                  ? "-"
                                  : DateFormat("hh:mm a").format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                              obj.checkOutTime)
                                          .toUtc()))),
                              DataCell(Text(obj.hoursPerDay)),
                            ]);
                          }).toList())
                      : Container(
                          margin: const EdgeInsets.only(top: 30),
                          height: 400,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AppAssets.notFoundIcon),
                                const Text("No data found.")
                              ],
                            ),
                          ),
                        )),
              const SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget allChildDropDown(BuildContext context) {
    return GetBuilder<CheckInOutController>(
      builder: (controller) => DropdownButton2(
        isExpanded: true,
        underline: const SizedBox.shrink(),
        hint: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              const Icon(
                Icons.person,
                size: 16,
                color: Colors.black,
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  controller.dropDownInitialValue.value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        items: controller.allChildern
            .map((item) => DropdownMenuItem<ParentStudents>(
                value: item,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 30,
                      child: FittedBox(
                        child: FloatingActionButton(
                          backgroundColor: AppColor.appPrimary,
                          onPressed: () {},
                          child: const Icon(
                            Icons.person,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      item.studentFullName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )))
            .toList(),
        value: controller.allChildValue,
        onChanged: (value) {
          controller.dropDownInitialValue.value =
              value!.studentFullName.toString();
          controller.studentId.value = value.id;
          controller.filterEndDate.value = "";
          controller.filterStartDate.value = "";
          controller.getCheckInOutFilterDetails(false);
          print(value.id);
          controller.update();
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColor.appPrimary,
            ),
            color: Colors.pink.shade50,
          ),
          elevation: 2,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down_outlined,
            size: 30,
          ),
          iconSize: 14,
          iconEnabledColor: Colors.black,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 250,
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.white,
          ),
          elevation: 8,
          //offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 42,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/Parent/fees_controller.dart';
import 'package:preto3/model/parent/childern_fees_invoice_model.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/invoice_staus.dart';

import '../../../utils/argument_keys.dart';

class StudentAcount extends StatelessWidget {
  StudentAcount({super.key});

  final feesController = Get.find<FeesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 40, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //checkOnlinePaymentAllow(context),
                allChildDropDown(context),
                paymentDetails(context),
                feesController.selectAll.value
                    ? loogkingForInviceImage(context)
                    : dateRangeStatusInvoiceDetails(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget allChildDropDown(BuildContext context) {
    return GetBuilder<FeesController>(
      builder: (feesController) => DropdownButton2(
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
                  feesController.dropDownInitialValue.value,
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
        items: feesController.allChildern
            .map((item) => DropdownMenuItem<AllChild>(
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
                      item.studentName,
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
        value: feesController.allChildValue,
        onChanged: (value) {
          feesController.setChild(value!);
          feesController.setStatus(InvoiceStatus(id: 5, value: "All"));
          String url =
              "roleId=${feesController.roleId.value}&schoolId=${feesController.schoolId.value}&studentId=${feesController.allChildValue!.id}&status=${feesController.status}";
          feesController.getChildernFeesDetailsUsingFilter(url);
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
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

  paymentDetails(BuildContext context) {
    return Container(
      height: 180,
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColor.borderColor),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.grey.shade100,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 8, right: 8),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Upcoming Dues",
                    style: GoogleFonts.poppins(
                        color: AppColor.heavyTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "\$${feesController.upcomingDues.toStringAsFixed(2)}",
                    style: GoogleFonts.poppins(
                        color: AppColor.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total Balance Due",
                      style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "\$${feesController.totalBalanceDues.toStringAsFixed(2)}",
                      style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: AppColor.lightTextColor,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Past Dues",
                      style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                    Obx(
                      () => Text(
                        "\$${feesController.pastDues.value.toStringAsFixed(2)}",
                        style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                const VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: AppColor.lightTextColor,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total Paid",
                      style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "\$${feesController.totalpaid.toStringAsFixed(2)}",
                      style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  checkOnlinePaymentAllow(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(254, 137, 52, 0.15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Icon(
              Icons.info,
              color: Colors.yellow.shade900,
              size: 20.0,
            ),
          ),
          const Flexible(
            child: Text(
                "You'll not be able to make payments online because online payments are currently disabled at your school."),
          )
        ],
      ),
    );
  }

  loogkingForInviceImage(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: MediaQuery.of(context).size.width,
          height: 150,
          child: const Image(
            image: AssetImage(AppAssets.invoceLookBox),
          ),
        ),
        Container(
          width: 200,
          margin: const EdgeInsets.only(top: 15),
          child: Text("Looking for Invoices?",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  color: AppColor.heavyTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
        ),
        Container(
          width: 300,
          margin: const EdgeInsets.only(top: 5),
          child: Text("Please select a child to view invoices.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  color: AppColor.heavyTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400)),
        )
      ],
    );
  }

  noInvoiceFlound(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 150,
          child: const Image(
            image: AssetImage(AppAssets.noInvoiceFound),
          ),
        )
      ],
    );
  }

  dateRangeStatusInvoiceDetails(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async => {
            feesController.setStartDate(await feesController.pickDate(context))
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.disableColor,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.black,
                              size: 20.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                feesController.startDate.value == ""
                                    ? 'Start date'
                                    : feesController.startDate.toString(),
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        feesController.startDate.value != ""
                            ? Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: InkWell(
                                  onTap: () =>
                                      {feesController.setStartDate("")},
                                  child: const Icon(
                                    Icons.clear,
                                    color: Colors.black,
                                    size: 20.0,
                                  ),
                                ),
                              )
                            : Container(),
                      ]),
                ),
                feesController.startDateValidation.value
                    ? Text(
                        'Start date must be less then end date',
                        style: GoogleFonts.poppins(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      )
                    : Container()
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () async => {
            feesController.setEndDate(await feesController.pickDate(context))
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.disableColor,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.black,
                              size: 20.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                feesController.endDate.value == ""
                                    ? 'End date'
                                    : feesController.endDate.toString(),
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        feesController.endDate.value != ""
                            ? Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: InkWell(
                                  onTap: () {
                                    feesController.setEndDate("");
                                  },
                                  child: const Icon(
                                    Icons.clear,
                                    color: Colors.black,
                                    size: 20.0,
                                  ),
                                ),
                              )
                            : Container(),
                      ]),
                ),
                feesController.endDateValidation.value
                    ? Text(
                        'End date must be grater then start date',
                        style: GoogleFonts.poppins(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      )
                    : Container()
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: ((context) {
                  return invoiceStatusDialog();
                }));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.disableColor,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      feesController.statusVal.value,
                      style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Colors.black,
                      size: 30.0,
                    ),
                  ),
                ]),
          ),
        ),
        feesController.invoice.isEmpty
            ? noInvoiceFlound(context)
            : GetBuilder<FeesController>(
                builder: ((controller) => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: feesController.invoice.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () => {
                          Get.toNamed(AppRoute.invoiceSortDescription,
                              arguments: {
                                ArgumentKeys.invoiceDetails:
                                    feesController.invoice[index].toJson()
                              })
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.scaffoldBackground,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300, //New
                                  blurRadius: 10.0,
                                  spreadRadius: 0)
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Invoice#',
                                    style: GoogleFonts.poppins(
                                        color: AppColor.heavyTextColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    'Invoice Amount',
                                    style: GoogleFonts.poppins(
                                        color: AppColor.heavyTextColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Text(
                                            controller
                                                .invoice[index].invoiceNumber
                                                .substring(3),
                                            style: GoogleFonts.poppins(
                                                color:
                                                    AppColor.invoiceNumberColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        controller.invoice[index].isRecurring
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: SvgPicture.asset(
                                                    AppAssets.recurring),
                                              )
                                            : Container(),
                                        controller.invoice[index].isAutoPay
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: SvgPicture.asset(
                                                    AppAssets.autopay),
                                              )
                                            : Container()
                                      ],
                                    ),
                                    Text(
                                      "\$${controller.invoice[index].invoiceAmount.toStringAsFixed(2)}",
                                      style: GoogleFonts.poppins(
                                          color: AppColor.heavyTextColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: AppColor.borderColor,
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, bottom: 5, left: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 12.0,
                                          height: 12.0,
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  AppColor.invoiceFilterColor[
                                                      controller.invoice[index]
                                                          .status]),
                                        ),
                                        Text(
                                          controller.invoice[index].status,
                                          style: GoogleFonts.poppins(
                                              color:
                                                  AppColor.invoiceFilterColor[
                                                      controller.invoice[index]
                                                          .status],
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Invoice Amount',
                                          style: GoogleFonts.poppins(
                                              color:
                                                  AppColor.invoiceNumberColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: AppColor.invoiceNumberColor,
                                            size: 25.0,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })))
      ],
    );
  }

  invoiceStatusDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: SizedBox(
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: SizedBox(
                    height: 200,
                    child: SingleChildScrollView(child:
                        GetBuilder<FeesController>(builder: (controller) {
                      return Column(
                        children: feesController.statusList
                            .map((data) => RadioListTile(
                                  title: Text(data.value),
                                  groupValue: data.id,
                                  value: controller.invoiceStatus!.id,
                                  onChanged: (val) {
                                    feesController.setStatus(data);
                                    // radioItemHolder = data.value;
                                    // id = data.id;
                                  },
                                ))
                            .toList(),
                      );
                    })))),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () => {
                      feesController
                          .setStatus(feesController.invoiceStatusDefault!),
                      Get.back()
                    },
                    child: SizedBox(
                      height: 30,
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.poppins(
                            color: Colors.grey.shade500,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => {
                      feesController
                          .setStatusDefault(feesController.invoiceStatus!),
                      Get.back(),
                      feesController.getChildernFeesDetailsUsingFilter(
                          "roleId=${feesController.roleId.value}&schoolId=${feesController.schoolId.value}&studentId=${feesController.allChildValue!.id}&status=${feesController.status}"),
                    },
                    child: SizedBox(
                      height: 30,
                      child: Text(
                        "Ok",
                        style: GoogleFonts.poppins(
                            color: AppColor.appPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

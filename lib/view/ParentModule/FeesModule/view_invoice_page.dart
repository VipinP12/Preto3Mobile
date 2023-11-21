import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/toast.dart';
import 'package:share_plus/share_plus.dart';

import '../../../controller/Parent/view_invoice_controller.dart';
import '../../../service/download_pdf.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/argument_keys.dart';

class ViewInvoicePage extends StatefulWidget {
  const ViewInvoicePage({super.key});

  @override
  State<ViewInvoicePage> createState() => _ViewInvoicePageState();
}

class _ViewInvoicePageState extends State<ViewInvoicePage> {
  final invoiceController = Get.find<ViewInvoiceController>();
  final manager = DounloadPDF();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(
        title: const Text("Invoice Details"),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: InkWell(
              onTap: () async {
                if (invoiceController.invoiceURl.value != "") {
                  if (manager.file == null) {
                    await manager
                        .startDownloading(invoiceController.invoiceURl.value);
                  }
                  messageToastSuccess(context, "Download success",
                      manager.file!.path.toString());
                } else {
                  messageToastWarning(context, "Invoice pdf not found");
                }
              },
              child: const Icon(
                Icons.file_download_outlined,
                size: 22,
                color: AppColor.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 30),
            child: InkWell(
              onTap: () async {
                if (invoiceController.invoiceURl.value != "") {
                  if (manager.file == null) {
                    await manager
                        .startDownloading(invoiceController.invoiceURl.value);
                    await Share.shareXFiles([XFile(manager.file!.path)]);
                  } else {
                    await Share.shareXFiles([XFile(manager.file!.path)]);
                  }
                } else {
                  messageToastWarning(context, "Invoice pdf not found");
                }

                // invoiceController.onShare(
                //     context, invoiceController.invoice!.invoiceNumber);
              },
              child: const Icon(
                Icons.ios_share,
                size: 22,
                color: AppColor.white,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: ValueListenableBuilder<double?>(
                valueListenable: manager.progressNotifier,
                builder: (context, percent, child) {
                  return CircularProgressIndicator(
                    strokeWidth: 2,
                    value: percent,
                  );
                },
              ),
            ),
          ),
          Obx(
            () => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.scaffoldBackground,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 60,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 42,
                                        width: 42,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(75),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: invoiceController
                                                .parentProfileUrl
                                                .toString(),
                                            errorWidget: (context, url, error) {
                                              return Image.asset(
                                                  AppAssets.placeHolder);
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Text(
                                          "${invoiceController.loginParentFirstName} ${invoiceController.loginParentLastName}",
                                          style: GoogleFonts.poppins(
                                              color: AppColor.heavyTextColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: AppColor.borderColor,
                                    thickness: .3,
                                  )
                                ],
                              ),
                            ),
                          ]),
                    ),
                    invoiceController.invoice!.isRecurring
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, bottom: 10),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.disableColor,
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(AppAssets.recurring),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Text(
                                          "Recurring invoice",
                                          style: GoogleFonts.poppins(
                                              color: AppColor.heavyTextColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                          )
                        : Container(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              invoiceController.schoolName.toString(),
                              textAlign: TextAlign.start,
                              style: GoogleFonts.poppins(
                                  color: AppColor.heavyTextColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Invoice#",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  invoiceController.invoiceId.toString(),
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                invoiceController.schoolAddress.value
                                    .toString(),
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 12,
                                    height: 1.4,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "EIN#: ${invoiceController.einNumber.value.toString()}",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        )
                      ],
                    ),
                    const Divider(
                      color: AppColor.borderColor,
                      thickness: 1,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bill to",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.poppins(
                                color: AppColor.heavyTextColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Balance Due",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "\$${invoiceController.dueBalance.toStringAsFixed(2)}",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    color: AppColor.appPrimary,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Parent Name",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "${invoiceController.parentFirstName.toString()} ${invoiceController.parentLastName.toString()}",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Parent Email",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                invoiceController.parentEmail.toString(),
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Text(
                                  "Child Name",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                "${invoiceController.childFirstName.toString()} ${invoiceController.childLastName.toString()}",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SizedBox(
                                height: 55,
                              ),
                              Text(
                                "Date of service:",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "${invoiceController.serviceStartDate} - ${invoiceController.serviceEndDate}",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Issue Date :      ",
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.poppins(
                                          color: AppColor.heavyTextColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      invoiceController.issueDate.toString(),
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.poppins(
                                          color: AppColor.heavyTextColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Due Date: :      ",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.poppins(
                                        color: AppColor.heavyTextColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    invoiceController.dueDate.toString(),
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.poppins(
                                        color: AppColor.heavyTextColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 50,
                      color: const Color.fromRGBO(84, 99, 214, 0.207),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Line Item",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Container(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: const EdgeInsets.only(right: 10),
                              child: Text(
                                "Total Amount",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    paymentInfo(),
                    Container(
                      height: 50,
                      color: const Color.fromRGBO(84, 99, 214, 0.207),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Balance Due:",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    color: AppColor.appPrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Container(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: const EdgeInsets.only(right: 10),
                              child: Text(
                                "\$${invoiceController.dueBalance.toStringAsFixed(2)}",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    color: AppColor.appPrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (chechInvoicePaybleOrUnPayble()) return;
                        Get.toNamed(AppRoute.finalPaymentDetailsPage,
                            arguments: {
                              ArgumentKeys.invoiceDetails:
                                  invoiceController.invoice
                            });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: chechInvoicePaybleOrUnPayble()
                              ? AppColor.disableColor
                              : AppColor.appPrimary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Pay Fee',
                            style: GoogleFonts.poppins(
                                color: chechInvoicePaybleOrUnPayble()
                                    ? AppColor.disableTextColor
                                    : AppColor.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  paymentInfo() {
    return Column(
      children: [
        GetBuilder<ViewInvoiceController>(
            builder: (controller) => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.lineItem.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          controller.lineItem[index].lineItemName,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "\$${controller.lineItem[index].total.toStringAsFixed(2)}",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  );
                })),
        const Divider(
          color: AppColor.borderColor,
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Total Fee",
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    color: AppColor.heavyTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                "\$${invoiceController.totalAmount.toStringAsFixed(2)}",
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    color: AppColor.heavyTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  chechInvoicePaybleOrUnPayble() {
    switch (invoiceController.invoice!.status) {
      case "Unpaid":
        {
          return false;
        }
      case "Declined":
        {
          return false;
        }

      default:
        {
          if (invoiceController.invoice!.isPartial) {
            return false;
          } else {
            return true;
          }
        }
    }
  }
}

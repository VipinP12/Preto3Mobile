import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:preto3/controller/Parent/invoice_details_controller.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';

import '../../../utils/argument_keys.dart';

class InvoiceSortDescription extends StatelessWidget {
  InvoiceSortDescription({super.key});

  final invoiceController = Get.find<InvoiceDetailsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(
        title: Text("Invoice# ${invoiceController.invoice!.invoiceNumber}"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 2,
                    spreadRadius: 2,
                    // offset: Offset(4, 8), // Shadow position
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(84, 99, 214, 0.05),
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 1),
                      child: Text(
                        'Invoice Amount',
                        style: GoogleFonts.poppins(
                            color: AppColor.heavyTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Text(
                      "\$${invoiceController.invoice!.invoiceAmount.toStringAsFixed(2)}",
                      style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 12.0,
                          height: 12.0,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.invoiceFilterColor[
                                  invoiceController.invoice!.status]),
                        ),
                        Text(
                          invoiceController.invoice!.status,
                          style: GoogleFonts.poppins(
                              color: AppColor.invoiceFilterColor[
                                  invoiceController.invoice!.status],
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5, right: 5, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Due Date',
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                invoiceController.invoice!.dueDate == 0
                                    ? "-"
                                    : DateFormat('MM/dd/yyyy').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            invoiceController
                                                .invoice!.dueDate)),
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Payment Date',
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                invoiceController.invoice!.paymentDate == 0
                                    ? "-"
                                    : DateFormat('MM/dd/yyyy').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            invoiceController
                                                .invoice!.paymentDate)),
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5, right: 5, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Balance Due',
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "\$${invoiceController.invoice!.balanceDue.toStringAsFixed(2)}"
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Paid Amount',
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "\$${invoiceController.invoice!.paidAmount.toStringAsFixed(2)}"
                                    .toString(),
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                height: 45,
                child: Row(
                  children: [
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(AppRoute.viewInvoicePage, arguments: {
                            ArgumentKeys.invoiceDetails:
                                invoiceController.invoice
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.appPrimary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'View Invoice',
                            style: GoogleFonts.poppins(
                                color: AppColor.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    )),
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: InkWell(
                        onTap: () {
                          if (chechInvoicePaybleOrUnPayble()) return;
                          Get.toNamed(AppRoute.finalPaymentDetailsPage,
                              arguments: {
                                ArgumentKeys.invoiceDetails:
                                    invoiceController.invoice
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: chechInvoicePaybleOrUnPayble()
                                ? AppColor.disableColor
                                : AppColor.appPrimary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Make payment',
                            style: GoogleFonts.poppins(
                                color: chechInvoicePaybleOrUnPayble()
                                    ? AppColor.disableTextColor
                                    : AppColor.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
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

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/toast.dart';

import '../../../../controller/Bank/bank_card_details_controller.dart';
import '../../../../controller/Parent/view_invoice_controller.dart';
import '../../../../utils/app_routes.dart';

class FinalPaymentDetailsPage extends StatelessWidget {
  FinalPaymentDetailsPage({super.key});

  final bankCardDetailsController = Get.find<BankCardDetailsController>();
  final invoiceController = Get.find<ViewInvoiceController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(
        title: const Text("Payment Details"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Payment Information',
              style: GoogleFonts.poppins(
                  color: AppColor.heavyTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                'Choose a payment option below',
                style: GoogleFonts.poppins(
                    color: AppColor.heavyTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
            GetBuilder<BankCardDetailsController>(
                builder: ((controller) => ListView.builder(
                    padding: const EdgeInsets.only(bottom: 0),
                    itemCount: controller.creditCardList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          controller.setSelectCard(
                              controller.creditCardList[index].creditCardId,
                              controller.creditCardList[index].lastFour,
                              false,
                              controller.creditCardList[index].creditCardName,
                              controller.creditCardList[index].isAutoPay);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: controller
                                          .creditCardList[index].creditCardId ==
                                      controller.selectCard!.id
                                  ? const Color.fromARGB(35, 84, 99, 214)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 0.2,
                                  color: controller.creditCardList[index]
                                              .creditCardId ==
                                          controller.selectCard!.id
                                      ? const Color(0xff5463D6)
                                      : Colors.grey)),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: SvgPicture.asset(
                                    AppAssets.atmCard,
                                    color: AppColor.dashCardIcon,
                                  ),
                                  title: Text(controller
                                      .creditCardList[index].creditCardName),
                                  subtitle: const Text('Credit card'),
                                  contentPadding: const EdgeInsets.all(0),
                                ),
                                Text(
                                  'Card no. **** **** **** ${controller.creditCardList[index].lastFour}',
                                  style: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  'Expire on: ${controller.creditCardList[index].expirationMonth}/${controller.creditCardList[index].expirationYear}',
                                  style: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }))),
            GetBuilder<BankCardDetailsController>(
                builder: ((controller) => ListView.builder(
                    itemCount: controller.paymentBankList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          controller.setSelectCard(
                              controller.paymentBankList[index].paymentBankId,
                              controller.paymentBankList[index].accountLastFour,
                              true,
                              controller.paymentBankList[index].bankName,
                              controller.paymentBankList[index].isAutoPay ??
                                  false);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: controller.paymentBankList[index]
                                          .paymentBankId ==
                                      controller.selectCard!.id
                                  ? const Color.fromARGB(35, 84, 99, 214)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 0.5,
                                  color: controller.paymentBankList[index]
                                              .paymentBankId ==
                                          controller.selectCard!.id
                                      ? const Color.fromARGB(255, 84, 93, 214)
                                      : Colors.grey)),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: SvgPicture.asset(
                                    AppAssets.bankIcon,
                                    color: AppColor.dashCardIcon,
                                  ),
                                  title: Text(controller
                                      .paymentBankList[index].bankName),
                                  // subtitle: Text(''),
                                  contentPadding: const EdgeInsets.all(0),
                                ),
                                Text(
                                  'Account no. ************${controller.paymentBankList[index].accountLastFour}',
                                  style: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }))),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 10, bottom: 40),
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 0.2, color: Colors.grey)),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 42,
                            width: 42,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(75),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: invoiceController.parentProfileUrl
                                    .toString(),
                                errorWidget: (context, url, error) {
                                  return Image.asset(AppAssets.placeHolder);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
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
                    ),
                    paymentInfo(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'You are paying: ',
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          invoiceController.invoice!.balanceDue
                              .toStringAsFixed(2),
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        log("PAYMENT SELECTED CARD ID:${bankCardDetailsController.selectCard!.id}");
                        log("PAYMENT SELECTED TYPE :${bankCardDetailsController.selectCard!.isBank}");
                        if (bankCardDetailsController.selectCard!.id == -1) {
                          messageToastWarning(context,
                              "Before pay, please select or add a card and bank.");
                          return;
                        }
                        if (bankCardDetailsController.selectCard!.isBank) {
                          bankCardDetailsController.makeBankPayment(
                              invoiceController.invoice!.invoiceId,
                              invoiceController.invoice!.balanceDue,
                              invoiceController.invoice!.isAutoPay);
                        } else {
                          bankCardDetailsController.makeCardPayment(
                              invoiceController.invoice!.invoiceId,
                              invoiceController.invoice!.balanceDue,
                              invoiceController.invoice!.isAutoPay);
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: AppColor.appPrimary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Pay Now',
                            style: GoogleFonts.poppins(
                                color: AppColor.white,
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
            InkWell(
              onTap: () async {
                await Get.toNamed(AppRoute.addPaymentMethodOption);
                bankCardDetailsController.onRefreshBankDetails();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: AppColor.appPrimary,
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '+ Add new payment method',
                    style: GoogleFonts.poppins(
                        color: AppColor.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ]),
        ),
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
                padding: const EdgeInsets.only(bottom: 5),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          controller.lineItem[index].lineItemName,
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          controller.lineItem[index].total.toStringAsFixed(2),
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 14,
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
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Total amount:',
                style: GoogleFonts.poppins(
                    color: AppColor.heavyTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              Obx(
                () => Text(
                  invoiceController.totalAmount.toStringAsFixed(2),
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

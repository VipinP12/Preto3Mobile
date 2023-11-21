import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../controller/Bank/bank_card_details_controller.dart';

class PaymentSettings extends StatelessWidget {
  PaymentSettings({super.key});

  final bankCardDetailsController = Get.find<BankCardDetailsController>();

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: bankCardDetailsController.refreshController,
      onRefresh: () {
        bankCardDetailsController.onRefreshBankDetails();
      },
      enablePullDown: true,
      enablePullUp: false,
      header: const WaterDropHeader(
        complete: Icon(
          Icons.done,
          color: AppColor.appPrimary,
        ),
        waterDropColor: AppColor.appPrimary,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Saved Payment Methods',
                style: GoogleFonts.poppins(
                    color: AppColor.heavyTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              GetBuilder<BankCardDetailsController>(
                  builder: ((controller) => ListView.builder(
                      padding: const EdgeInsets.only(bottom: 0),
                      reverse: true,
                      itemCount: controller.creditCardList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      controller.creditCardList[index].isDefault
                                          ? Colors.grey
                                          : AppColor.white,
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 3,
                                )
                              ],
                              border: Border.all(
                                  width: 1, color: AppColor.borderColor)),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: SvgPicture.asset(
                                    AppAssets.atmCard,
                                    color: controller
                                            .creditCardList[index].isDefault
                                        ? AppColor.appPrimary
                                        : AppColor.dashCardIcon,
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
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      defaultSetButton(
                                          controller
                                              .creditCardList[index].isDefault,
                                          controller.creditCardList[index]
                                              .creditCardId),
                                      InkWell(
                                        onTap: () {
                                          controller.creditCardList[index]
                                                  .isDefault
                                              ? showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: ((context) {
                                                    return deleteWarningIfDefault(
                                                        index, false);
                                                  }))
                                              : showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: ((context) {
                                                    return deleteWarning(
                                                        index, false);
                                                  }));
                                        },
                                        child: const Icon(
                                          Icons.delete_outline,
                                          size: 25,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }))),
              GetBuilder<BankCardDetailsController>(
                  builder: ((controller) => ListView.builder(
                      padding: const EdgeInsets.only(bottom: 0),
                      itemCount: controller.paymentBankList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: SvgPicture.asset(AppAssets.bankIcon),
                                  title: Text(controller
                                      .paymentBankList[index].bankName),
                                  subtitle: const Text(''),
                                  contentPadding: const EdgeInsets.all(0),
                                ),
                                Text(
                                  'Account no. ************${controller.paymentBankList[index].accountLastFour}',
                                  style: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  '',
                                  style: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      defaultSetButton(
                                          controller
                                              .paymentBankList[index].isDefault,
                                          controller.paymentBankList[index]
                                              .paymentBankId),
                                      InkWell(
                                        onTap: () {
                                          controller.paymentBankList[index]
                                                  .isDefault
                                              ? showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: ((context) {
                                                    return deleteWarningIfDefault(
                                                        index, false);
                                                  }))
                                              : showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: ((context) {
                                                    return deleteWarning(
                                                        index, true);
                                                  }));
                                        },
                                        child: const Icon(
                                          Icons.delete_outline,
                                          size: 25,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }))),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoute.addPaymentMethodOption);
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
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 5),
                child: Text(
                  'Autopay',
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                'Allows pay invoices automatically',
                style: GoogleFonts.poppins(
                    color: AppColor.heavyTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(84, 99, 214, 0.05),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Autopay allow us to automatically take payment from your default payment method when the invoice is due.',
                    style: GoogleFonts.poppins(
                        color: AppColor.heavyTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              GetBuilder<BankCardDetailsController>(
                  builder: (controller) => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          controller.defaultCard!.id != -1
                              ? ListTile(
                                  leading: controller.defaultCard!.isBank
                                      ? SvgPicture.asset(AppAssets.bankIcon)
                                      : SvgPicture.asset(AppAssets.atmCard),
                                  title: Text(controller.defaultCard!.name),
                                  subtitle: controller.defaultCard!.isBank
                                      ? Text(
                                          'Account no. ********${controller.defaultCard!.accountLastFour}')
                                      : Text(
                                          'Card no. **** **** **** ${controller.defaultCard!.accountLastFour}'),
                                  contentPadding: const EdgeInsets.all(0),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  child: Text(
                                    'First, you need to add or set a default card. Then, you can enable or disable autopay.',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        color: Colors.red.shade500,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(),
                              Text(
                                controller.defaultCard!.isAutoPay
                                    ? 'Autopay Enabled'
                                    : 'Autopay Enable',
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              Switch(
                                activeColor: AppColor.appPrimary,
                                activeTrackColor: Colors.grey.shade400,
                                inactiveThumbColor: AppColor.outColor,
                                inactiveTrackColor: Colors.grey.shade400,
                                splashRadius: 50.0,
                                value: controller.defaultCard!.isAutoPay,
                                onChanged: (value) => {
                                  if (controller.defaultCard!.id != -1)
                                    {
                                      controller.setAutoPayCard(
                                          bankCardDetailsController
                                              .defaultCard!.id,
                                          !controller.defaultCard!.isAutoPay)
                                    }
                                },
                              ),
                            ],
                          ),
                        ],
                      )),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 40),
                child: Text(
                  'Please change the default payment method in order to set up autopay for other payment method.',
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  defaultSetButton(bool isDefault, int paymentMethodId) {
    return isDefault
        ? Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              child: Text(
                'Default',
                style: GoogleFonts.poppins(
                    color: AppColor.appPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ),
          )
        : InkWell(
            onTap: () =>
                {bankCardDetailsController.setDefaultCard(paymentMethodId)},
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.dashCardIcon,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 5, bottom: 5),
                child: Text(
                  'Set to default',
                  style: GoogleFonts.poppins(
                      color: AppColor.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          );
  }

  Widget deleteWarning(int index, bool isBank) {
    return Dialog(
      child: Container(
        height: 180,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                "Warning",
                style: GoogleFonts.poppins(
                    color: AppColor.absentColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
              child: Text(
                "Do you really want to delete it?",
                style: GoogleFonts.poppins(
                    color: AppColor.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      log("PRESSED YES");
                      Get.back();
                      if (isBank) {
                        bankCardDetailsController.deleteCardAndBank(
                            bankCardDetailsController
                                .paymentBankList[index].paymentBankId,
                            true);
                      } else {
                        bankCardDetailsController.deleteCardAndBank(
                            bankCardDetailsController
                                .creditCardList[index].creditCardId,
                            false);
                      }
                    },
                    child: Container(
                      height: 42,
                      width: 120,
                      decoration: BoxDecoration(
                        color: AppColor.appPrimary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "YES",
                          style: GoogleFonts.poppins(
                              color: AppColor.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 42,
                      width: 120,
                      decoration: BoxDecoration(
                        color: AppColor.disableColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "NO",
                          style: GoogleFonts.poppins(
                              color: AppColor.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget deleteWarningIfDefault(int index, bool isBank) {
    return Dialog(
      child: Container(
        height: 230,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                "Warning",
                style: GoogleFonts.poppins(
                    color: AppColor.absentColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
              child: Text(
                "This is selected as default payment method and cannot be deleted. Kindly select another payment method and try deleting later.",
                style: GoogleFonts.poppins(
                    color: AppColor.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 42,
                      width: 120,
                      decoration: BoxDecoration(
                        color: AppColor.disableColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "OK",
                          style: GoogleFonts.poppins(
                              color: AppColor.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

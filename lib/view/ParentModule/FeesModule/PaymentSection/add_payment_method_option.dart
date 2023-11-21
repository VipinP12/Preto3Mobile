import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../components/formatters.dart';
import '../../../../controller/Bank/add_bank_atmcard_controller.dart';
import '../../../../utils/app_assets.dart';
import '../../../WePayBank/web_view_wepay.dart';

class AddPaymentMethodOption extends StatelessWidget {
  AddPaymentMethodOption({super.key});
  final addBankAtmcardController = Get.find<AddBankAtmcardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(
        title: const Text("Add a Payment Method"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          addBankAtmcardController.setIsBankAndCardVisible();
                        },
                        child: Container(
                          height: 120,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: addBankAtmcardController
                                    .isBankAndCardVisible.value
                                ? const Color.fromARGB(35, 84, 99, 214)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 0.2,
                                color: addBankAtmcardController
                                        .isBankAndCardVisible.value
                                    ? const Color(0x785463D6)
                                    : Colors.grey),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(AppAssets.atmCard),
                              ),
                              Text(
                                'Credit Card',
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          addBankAtmcardController.setIsBankAndCardVisible();
                        },
                        child: Container(
                          height: 120,
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: addBankAtmcardController
                                    .isBankAndCardVisible.value
                                ? Colors.white
                                : const Color.fromARGB(35, 84, 99, 214),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 0.2,
                                color: addBankAtmcardController
                                        .isBankAndCardVisible.value
                                    ? Colors.grey
                                    : const Color(0x785463D6)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(AppAssets.bankIcon),
                              ),
                              Text(
                                'Bank account',
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                addBankAtmcardController.isBankAndCardVisible.value
                    ? cardDetailsInfo(context)
                    : bankAcountInfo(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bankAcountInfo(BuildContext context) {
    return InkWell(
      onTap: () {
        log("ADDING BANKING DETAILS");
        //IMPLEMENT PLAID HERE
        Get.to(const WebViewApp());
        //addBankAtmcardController.addBankDetails();
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
            'Add your bank account information',
            style: GoogleFonts.poppins(
                color: AppColor.white,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  cardDetailsInfo(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        cardDetails(context),
        Row(
          children: [
            Checkbox(
              checkColor: Colors.white,
              value: addBankAtmcardController.setDefault.value,
              onChanged: (bool? value) {
                addBankAtmcardController.setDefaultValue();
              },
            ),
            Text(
              'Set to default',
              style: GoogleFonts.poppins(
                  color: AppColor.heavyTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'I authorize PREto3 Software to make current and future payments from this Credit Card.',
            textAlign: TextAlign.start,
            style: GoogleFonts.poppins(
                color: AppColor.heavyTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 60),
          child: SizedBox(
            height: 45,
            child: Row(
              children: [
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.disableColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(
                            color: AppColor.appPrimary,
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
                      addBankAtmcardController.onSubmitAddCreditCard();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.appPrimary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Save',
                        style: GoogleFonts.poppins(
                            color: AppColor.white,
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
    );
  }

  cardDetails(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Text("Card holder’s Name *"))
            ],
          ),
          Form(
            key: addBankAtmcardController.cardHolderNameKey,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 72,
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Card holder’s name',
                    hoverColor: Colors.blue.shade100,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(115, 238, 237, 237),
                        width: .5,
                      ),
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z ]')),
                  ],
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: false,
                  maxLength: 24,
                  controller: addBankAtmcardController.cardHolderNameController,
                  onSaved: (savedValue) {
                    addBankAtmcardController.holderName.value = savedValue!;
                  },
                  validator: (value) => addBankAtmcardController
                      .cardHolderNameValidator(value.toString()),
                  // validator: (dynamic value) => value!.isEmpty
                  //     ? S.of(context).thisFieldCanNotBeBlank
                  //     : null,
                )),
          ),
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.all(6.0), child: Text("Card Number *"))
            ],
          ),
          Form(
            key: addBankAtmcardController.cardNumberNameKey,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 72,
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'xxxx xxxx xxxx xxxx',
                    hoverColor: Colors.blue.shade100,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(115, 238, 237, 237),
                        width: 1,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  controller: addBankAtmcardController.cardNumberNameController,
                  maxLength: 19,
                  inputFormatters: [
                    MaskedTextInputFormatter(
                      mask: 'xxxx xxxx xxxx xxxx',
                      separator: ' ',
                    ),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9 ]')),
                  ],
                  // onSaved: (savedValue) {
                  //   addBankAtmcardController.cardNumber.value =
                  //       savedValue!.replaceAll(" ", "");
                  // },
                  validator: (value) => addBankAtmcardController
                      .validCardNumber(value.toString()),
                )),
          ),
          Row(
            children: const [
              Padding(
                  padding: EdgeInsets.only(right: 6.0, left: 6.0, bottom: 6.0),
                  child: Text('Expiry Date *'))
            ],
          ),
          Form(
            key: addBankAtmcardController.expiryDateNameKey,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 72,
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'MM/YYYY',
                    hoverColor: Colors.blue.shade100,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(115, 238, 237, 237),
                        width: 1,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  controller: addBankAtmcardController.expiryDateNameController,
                  inputFormatters: [
                    MaskedTextInputFormatter(
                      mask: 'xx/xxxx',
                      separator: '/',
                    ),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                  ],
                  maxLength: 7,
                  // onSaved: (savedValue) {
                  //   // addBankAtmcardController.cardNumber.value =
                  //   //     savedValue!.replaceAll(" ", "");
                  //   if (savedValue!.length == 7) {
                  //     addBankAtmcardController.month.value =
                  //         int.parse(savedValue.substring(0, 2));
                  //     addBankAtmcardController.year.value =
                  //         int.parse(savedValue.substring(3));
                  //   }
                  // },
                  validator: (value) => addBankAtmcardController
                      .expiryDateValidator(value.toString()),
                  // validator: (dynamic value) {
                  //   int exp =
                  //       int.parse(value.toString().substring(0, 2));
                  //   bool isValidMonth = exp < 13;
                  //   if (value!.isEmpty || !isValidMonth) {
                  //     return S.of(context).thisFieldCanNotBeBlank;
                  //   }
                  //   return null;
                  // }
                )),
          ),
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(right: 6.0, left: 6.0, bottom: 6.0),
                  child: Text('CVV *'))
            ],
          ),
          Form(
            key: addBankAtmcardController.cVVKey,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 72,
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'CVV',
                    hoverColor: Colors.blue.shade100,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(115, 238, 237, 237),
                        width: 1,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  controller: addBankAtmcardController.cVVController,
                  inputFormatters: [
                    MaskedTextInputFormatter(
                      mask: 'xxx',
                      separator: '',
                    ),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9 ]')),
                  ],
                  maxLength: 3,
                  // onSaved: (savedValue) {
                  //   addBankAtmcardController.cvv.value = savedValue.toString();
                  // },
                  validator: (value) =>
                      addBankAtmcardController.cvvValidator(value.toString()),
                  // validator: (dynamic value) {
                  //   int exp =
                  //       int.parse(value.toString().substring(0, 2));
                  //   bool isValidMonth = exp < 13;
                  //   if (value!.isEmpty || !isValidMonth) {
                  //     return S.of(context).thisFieldCanNotBeBlank;
                  //   }
                  //   return null;
                  // }
                )),
          ),
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(right: 6.0, left: 6.0, bottom: 6.0),
                  child: Text('Postal Code'))
            ],
          ),
          Form(
            key: addBankAtmcardController.postelCodeKey,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 72,
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Postal code',
                    hoverColor: Colors.blue.shade100,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(115, 238, 237, 237),
                        width: 1,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  controller: addBankAtmcardController.postelCodeController,
                  inputFormatters: [
                    // MaskedTextInputFormatter(
                    //   mask: 'xxx',
                    //   separator: '',
                    // ),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  maxLength: 5,
                  // onSaved: (savedValue) {
                  //   addBankAtmcardController.postelCode.value =
                  //       int.parse(savedValue.toString());
                  // },
                  validator: (value) => addBankAtmcardController
                      .postalCodeValidator(value.toString()),
                  // validator: (dynamic value) {
                  //   int exp =
                  //       int.parse(value.toString().substring(0, 2));
                  //   bool isValidMonth = exp < 13;
                  //   if (value!.isEmpty || !isValidMonth) {
                  //     return S.of(context).thisFieldCanNotBeBlank;
                  //   }
                  //   return null;
                  // }
                )),
          ),
        ],
      ),
    );
  }
}

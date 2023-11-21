import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:preto3/model/bank/credit_card_model.dart';
import 'package:preto3/model/bank/payment_bank_model.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/app_string.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../model/parent/default_card.dart';
import '../../network/api_end_points.dart';
import '../../network/base_client.dart';
import '../../utils/app_keys.dart';
import '../base_controller.dart';

class BankCardDetailsController extends GetxController with BaseController {
  final storageBox = GetStorage();
  dynamic argumentData = Get.arguments;

  var userId = 0.obs;
  var schoolId = 0.obs;
  var roleId = 0.obs;
  var paymentBankList = <PaymentBankModel>[].obs;
  var creditCardList = <CreditCardModel>[].obs;
  var creditPaymentCardId = 0.obs;
  DefaultCard? defaultCard;
  DefaultCard? selectCard;
  var refreshController = RefreshController();

  @override
  void onInit() {
    refreshController = RefreshController(initialRefresh: false);
    userId.value = storageBox.read(AppKeys.keyId);
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    defaultCard = setDefaultInitValue(); //set as a default value first time
    selectCard = setDefaultInitValue();
    update();
    super.onInit();
  }

  @override
  void onReady() {
    getBankDetails();
    getCreditCardDetails();
  }

  void onRefreshBankDetails() async {
    getBankDetails();
    getCreditCardDetails();
    await Future.delayed(const Duration(milliseconds: 500));
    refreshController.refreshCompleted();
  }

  void getBankDetails() async {
    dynamic params = {"userId": userId.value, "schoolId": schoolId.value};
    showLoading('Fetching data');
    var response = await BaseClient()
        .post(ApiEndPoints.devBaseUrl, ApiEndPoints.paymentBank, params)
        .catchError(handleError);
    if (response != null) {
      isOnline.value = true;
      paymentBankList.value = [];
      if (response != "") {
        paymentBankList.value = paymentBankModelFromJson(response);
        for (PaymentBankModel paymentBankModel in paymentBankList.value) {
          if (paymentBankModel.isDefault) {
            defaultCard = DefaultCard(
                id: paymentBankModel.paymentBankId,
                accountLastFour: paymentBankModel.accountLastFour,
                isBank: true,
                name: paymentBankModel.bankName,
                statusCardOrBank: '',
                isAutoPay: paymentBankModel.isAutoPay!);
            selectCard = DefaultCard(
                id: paymentBankModel.paymentBankId,
                accountLastFour: paymentBankModel.accountLastFour,
                isBank: true,
                name: paymentBankModel.bankName,
                statusCardOrBank: '',
                isAutoPay: paymentBankModel.isAutoPay!);
          }
        }
      } else {
        paymentBankList.value = [];
      }
    }
    hideLoading();
    update();
  }

  void getCreditCardDetails() async {
    dynamic params = {"userId": userId.value, "schoolId": schoolId.value};
    showLoading('Fetching data');
    var response = await BaseClient()
        .post(ApiEndPoints.devBaseUrl, ApiEndPoints.creditCard, params)
        .catchError(handleError);
    if (response != null) {
      isOnline.value = true;
      creditCardList.value = [];
      if (response != "") {
        creditCardList.value = creditCardModelFromJson(response);
        for (CreditCardModel creditCardModel in creditCardList.value) {
          if (creditCardModel.isDefault) {
            defaultCard = DefaultCard(
                id: creditCardModel.creditCardId,
                accountLastFour: creditCardModel.lastFour,
                isBank: false,
                name: creditCardModel.creditCardName,
                statusCardOrBank: '',
                isAutoPay: creditCardModel.isAutoPay);
            selectCard = DefaultCard(
                id: creditCardModel.creditCardId,
                accountLastFour: creditCardModel.lastFour,
                isBank: false,
                name: creditCardModel.creditCardName,
                statusCardOrBank: '',
                isAutoPay: creditCardModel.isAutoPay);
          }
        }
      } else {
        creditCardList.value = [];
      }
    }
    hideLoading();
    update();
  }

  void setSelectCard(int acountId, String lastFourDigit, bool isBankFlag,
      String cardBankName, bool isAutoPay) {
    selectCard = DefaultCard(
        id: acountId,
        accountLastFour: lastFourDigit,
        isBank: isBankFlag,
        name: cardBankName,
        statusCardOrBank: '',
        isAutoPay: isAutoPay);
    update();
  }

  void deleteCardAndBank(int deleteCardId, bool cardORBank) async {
    dynamic params = {
      "paymentMethodId": deleteCardId,
      "schoolId": schoolId.value
    };
    showLoading('Fetching data');

    var response = await BaseClient()
        .post(ApiEndPoints.devBaseUrl, ApiEndPoints.deleteCreditCard, params)
        .catchError(handleError);
    if (response != null) {
      if (cardORBank) {
        getBankDetails();
      } else {
        getCreditCardDetails();
      }
    }
    update();
    hideLoading();
  }

  void setDefaultCard(int paymentMethodId) async {
    dynamic params = {
      "paymentMethodType": "payment_bank",
      "paymentMethodId": paymentMethodId,
      "isDefault": true,
      "schoolId": schoolId.value
    };
    showLoading('Fetching data');

    var response = await BaseClient()
        .patch(ApiEndPoints.devBaseUrl, ApiEndPoints.updateDefaultPaymentMethod,
            params)
        .catchError(handleError);
    if (response != null) {
      getBankDetails();
      getCreditCardDetails();
    }
    update();
    hideLoading();
  }

  void setAutoPayCard(int paymentMethodId, bool isAutoPay) async {
    dynamic params = {
      "paymentMethodType": "payment_bank",
      "paymentMethodId": paymentMethodId,
      "isAutoPay": isAutoPay,
      "schoolId": schoolId.value
    };
    showLoading('Fetching data');

    var response = await BaseClient()
        .patch(ApiEndPoints.devBaseUrl, ApiEndPoints.updateDefaultPaymentMethod,
            params)
        .catchError(handleError);
    if (response != null) {
      getBankDetails();
      getCreditCardDetails();
    }
    update();
    hideLoading();
  }

  void makeCardPayment(int invoiceId, double amount, bool isAutoPay) async {
    dynamic params = {
      "schoolId": schoolId.value,
      "roleId": roleId.value,
      "invoiceId": invoiceId,
      "description": "payment for invoice",
      "type": AppString.paymentTypeCreditCard,
      "paymentMethodId": selectCard!.id,
      "amount": amount,
      "autoPay": isAutoPay,
    };
    log("MAKING CARD PAYMENT ## $params");

    var response = await BaseClient()
        .post(ApiEndPoints.devBaseUrl, ApiEndPoints.makePayment, params)
        .catchError(handleError);
    if (response != null) {
      log("CARD PAYMENT RESPONSE## $response");
      Get.offAllNamed(AppRoute.dashboardParent);
    }
  }

  void makeBankPayment(int invoiceId, double amount, bool isAutoPay) async {
    showLoading("");
    dynamic params = {
      "schoolId": schoolId.value,
      "roleId": roleId.value,
      "invoiceId": invoiceId,
      "description": "payment for invoice",
      "type": AppString.paymentTypeBank,
      "paymentMethodId": selectCard!.id,
      "amount": amount,
      "autoPay": isAutoPay,
    };

    log("MAKING BANK PAYMENT ## $params");
    var response = await BaseClient()
        .post(ApiEndPoints.devBaseUrl, ApiEndPoints.makePayment, params)
        .catchError(handleError);
    if (response != null) {
      hideLoading();
      log("BANK PAYMENT RESPONSE## $response");
      Get.offAllNamed(AppRoute.dashboardParent);
    }
  }

  DefaultCard? setDefaultInitValue() {
    return DefaultCard(
      accountLastFour: '',
      id: -1,
      isBank: false,
      name: '',
      statusCardOrBank: '',
      isAutoPay: false,
    );
  }
}

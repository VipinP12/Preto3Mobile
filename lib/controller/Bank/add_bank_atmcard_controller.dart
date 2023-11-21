import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:preto3/controller/Bank/bank_card_details_controller.dart';
import 'package:preto3/model/parent/we_pay_model.dart';
import 'package:preto3/model/plaid_token_model.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/app_string.dart';
import '../../network/api_end_points.dart';
import '../../network/base_client.dart';
import '../base_controller.dart';

class AddBankAtmcardController extends GetxController with BaseController {
  late PlaidLink plaidPublicKey;
  final storageBox = GetStorage();
  dynamic argumentData = Get.arguments;

  final cardController = Get.find<BankCardDetailsController>();

  var isBankAndCardVisible = false.obs;

  final cardHolderNameKey = GlobalKey<FormState>();
  final cardNumberNameKey = GlobalKey<FormState>();
  final expiryDateNameKey = GlobalKey<FormState>();
  final cVVKey = GlobalKey<FormState>();
  final postelCodeKey = GlobalKey<FormState>();

  var cardHolderNameController = TextEditingController();
  var cardNumberNameController = TextEditingController();
  var expiryDateNameController = TextEditingController();
  var cVVController = TextEditingController();
  var postelCodeController = TextEditingController();

  var isCardHolderName = false;
  var isCardNumber = false;
  var isExpiryDateName = false;
  var isCvv = false;
  var isPostelCode = false;
  //var token = "".obs;
  //var requestId = "".obs;

  var schoolId = 0.obs;
  var emailId = "".obs;
  var holderName = "".obs;
  var cardNumber = "".obs;
  var month = 0.obs;
  var year = 0.obs;
  var cvv = "".obs;
  var postelCode = 0.obs;
  var setDefault = false.obs;

  LinkConfiguration? configuration;
  //StreamSubscription<LinkEvent>? _streamEvent;
  // StreamSubscription<LinkExit>? _streamExit;
  //StreamSubscription<LinkSuccess>? _streamSuccess;
  LinkObject? _successObject;
  @override
  void onInit() {
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    emailId.value = storageBox.read(AppKeys.keyEmail);
    createLegacyTokenConfiguration();
    //_streamEvent = PlaidLink.onEvent.listen(onEvent);
    //_streamExit = PlaidLink.onExit.listen(onExit);
    // _streamSuccess = PlaidLink.onSuccess.listen(onSuccess);
    //createLinkToken();
    // createLinkTokenConfiguration();
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void dispose() {
    super.dispose();
    cardHolderNameController.dispose();
    cardNumberNameController.dispose();
    expiryDateNameController.dispose();
    cVVController.dispose();
    postelCodeController.dispose();
    //_streamEvent?.cancel();
    // _streamExit?.cancel();
    //_streamSuccess?.cancel();
  }

  void setDefaultValue() {
    setDefault.value = !setDefault.value;
  }

  void setIsBankAndCardVisible() {
    isBankAndCardVisible.value = !isBankAndCardVisible.value;
    update();
  }

  void onSubmitAddCreditCard() {
    isCardHolderName = cardHolderNameKey.currentState!.validate();
    isCardNumber = cardNumberNameKey.currentState!.validate();
    isExpiryDateName = expiryDateNameKey.currentState!.validate();
    isCvv = cVVKey.currentState!.validate();
    isPostelCode = postelCodeKey.currentState!.validate();
    if (isCardHolderName &&
        isCardNumber &&
        isExpiryDateName &&
        isCvv &&
        isPostelCode) {
      addToCardDetails();
    }
  }

  cardHolderNameValidator(String value) {
    if (value.trim().isEmpty) {
      return "Card holder name can't be empty";
    }
    holderName.value = value;
    return null;
  }

  validCardNumber(String value) {
    if (value.trim().isEmpty) {
      return "Card number can't be empty";
    } else if (value.replaceAll(" ", "").length < 16) {
      return "Card number is not correct";
    }
    cardNumber.value = value.replaceAll(" ", "");
    return;
  }

  expiryDateValidator(String value) {
    if (value.trim().isEmpty) {
      return "Expiry date can't be empty";
    } else if (value.trim().length < 7) {
      return "Expiry date is not correct";
    } else if (value.substring(0, 2).contains("/") ||
        int.parse(value.trim().substring(0, 2)) < 1 ||
        int.parse(value.trim().substring(0, 2)) > 12) {
      return "Card month is not correct";
    } else if (value.substring(3).contains("/")) {
      return "Card year is not correct";
    }
    month.value = int.parse(value.substring(0, 2));
    year.value = int.parse(value.substring(3));
    return null;
  }

  cvvValidator(String value) {
    if (value.trim().isEmpty) {
      return "CVV can't be empty";
    } else if (value.trim().length < 3) {
      return "CVV is not correct";
    }
    cvv.value = value;
    return null;
  }

  postalCodeValidator(String value) {
    if (value.trim().isEmpty) {
      return "Postal code can't be empty";
    } else if (value.trim().length < 5) {
      return "Postal code is not correct";
    }
    postelCode.value = int.parse(value);
    return null;
  }

  void createLegacyTokenConfiguration() {
    configuration = LegacyLinkConfiguration(
      clientName: ApiEndPoints.plaidClientUsername,
      publicKey: ApiEndPoints.plaidClientId,
      environment: LinkEnvironment.sandbox,
      products: <LinkProduct>[LinkProduct.transactions, LinkProduct.auth],
      language: "en",
      countryCodes: ['US'],
    );
    update();
  }

  // void createLinkTokenConfiguration() {
  //   configuration = LinkTokenConfiguration(
  //     token: token.value,
  //   );
  //   update();
  // }

  void addToCardDetails() async {
    dynamic params = {
      "client_id": ApiEndPoints.clientId,
      "user_name": holderName.value,
      "cc_number": cardNumber.value,
      "email": emailId.value,
      "cvv": cvv.value,
      "expiration_month": month.value,
      "expiration_year": year.value,
      "address": {"postal_code": postelCode.toString()}
    };
    showLoading('Fetching data');

    log("## CARD PARAM $params ");
    var response = await BaseClient()
        .post(ApiEndPoints.wePayStagingURL, ApiEndPoints.getWePayCreditCard,
            params)
        .catchError(handleError);

    log("WE PAY RESPONSE  $response");
    var wePayResponse = WePayModel.fromJson(jsonDecode(response));
    log("WE PAY CREDIT CARD ID  ${wePayResponse.creditCardId}");
    log("WE PAY STATE  ${wePayResponse.state}");

    dynamic addPayParams = {
      "schoolId": schoolId.value,
      "type": AppString.paymentTypeCreditCard,
      "paymentMethodId": wePayResponse.creditCardId,
    };

    var addResponse = await BaseClient()
        .post(ApiEndPoints.devBaseUrl, ApiEndPoints.addPaymentCreditCard,
            addPayParams)
        .catchError(handleError);
    if (addResponse != null) {
      log("ADDED CREDIT CARD PAYMENT $addResponse");
      cardController.getCreditCardDetails();
    }

    hideLoading();
  }

  // void addBankDetails() {
  //   PlaidLink.open(configuration: configuration!);
  // }

  // void onEvent(LinkEvent event) {
  //   final name = event.name;
  //   final metadata = event.metadata.description();
  //   print("onEvent: $name, metadata: $metadata");
  // }

  // void onSuccess(LinkSuccess event) {
  //   token.value = event.publicToken;
  //   final metadata = event.metadata.description();
  //   print("onSuccess: $token, metadata: $metadata");
  //   _successObject = event;
  //   _successObject?.toJson().toString() ?? "";
  //   print(_successObject!.toJson().toString());
  //   update();
  // }

  // void onExit(LinkExit event) {
  //   final metadata = event.metadata.description();
  //   final error = event.error?.description();
  //   print("onExit metadata: $metadata, error: $error");
  // }

  // void createLinkToken() async {
  //   dynamic params = {
  //     "client_id": ApiEndPoints.plaidClientId,
  //     "secret": ApiEndPoints.plaidSandboxSecretKey,
  //     "client_name": "user_good",
  //     "country_codes": ["US"],
  //     "language": "en",
  //     "user": {"client_user_id": ApiEndPoints.plaidClientId},
  //     "products": ["auth", "transactions"],
  //     "android_package_name": 'xyz.teknol.preto3'
  //   };
  //   print(params);
  //   var response = await BaseClient()
  //       .post(ApiEndPoints.plaidURL, ApiEndPoints.createLinkToken, params)
  //       .catchError(handleError);
  //   if (response != null) {
  //     var plaidResponse =
  //         PlaidTokenModel.fromJson(jsonDecode(response.toString()));
  //     token.value = plaidResponse.linkToken;
  //     requestId.value = plaidResponse.requestId;
  //     print("RESPONSE:$plaidResponse");
  //     if (token.value.isNotEmpty) {
  //       print(token.value);
  //       configuration = LinkTokenConfiguration(
  //         token: token.value,
  //       );
  //     }
  //   }
  // }
}

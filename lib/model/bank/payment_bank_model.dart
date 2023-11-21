// To parse this JSON data, do
//
//     final paymentBankModel = paymentBankModelFromJson(jsonString);

import 'dart:convert';

List<PaymentBankModel> paymentBankModelFromJson(String str) =>
    List<PaymentBankModel>.from(
        json.decode(str).map((x) => PaymentBankModel.fromJson(x)));

String paymentBankModelToJson(List<PaymentBankModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentBankModel {
  PaymentBankModel({
    required this.paymentBankId,
    required this.state,
    required this.bankName,
    required this.accountLastFour,
    this.isAutoPay,
    required this.isDefault,
  });

  int paymentBankId;
  String state;
  String bankName;
  String accountLastFour;
  bool? isAutoPay;
  bool isDefault;

  factory PaymentBankModel.fromJson(Map<String, dynamic> json) =>
      PaymentBankModel(
        paymentBankId: json["paymentBankId"] ?? 0,
        state: json["state"] ?? "",
        bankName: json["bankName"] ?? "",
        accountLastFour: json["accountLastFour"] ?? "",
        isAutoPay: json["isAutoPay"] ?? false,
        isDefault: json["isDefault"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "paymentBankId": paymentBankId,
        "state": state,
        "bankName": bankName,
        "accountLastFour": accountLastFour,
        "isAutoPay": isAutoPay,
        "isDefault": isDefault,
      };
}

// To parse this JSON data, do
//
//     final creditCardModel = creditCardModelFromJson(jsonString);

import 'dart:convert';

List<CreditCardModel> creditCardModelFromJson(String str) =>
    List<CreditCardModel>.from(
        json.decode(str).map((x) => CreditCardModel.fromJson(x)));

String creditCardModelToJson(List<CreditCardModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CreditCardModel {
  CreditCardModel({
    required this.isAutoPay,
    required this.isDefault,
    required this.creditCardId,
    required this.creditCardName,
    required this.inputSource,
    required this.expirationMonth,
    required this.expirationYear,
    required this.lastFour,
  });

  bool isAutoPay;
  bool isDefault;
  int creditCardId;
  String creditCardName;
  String inputSource;
  int expirationMonth;
  int expirationYear;
  String lastFour;

  factory CreditCardModel.fromJson(Map<String, dynamic> json) =>
      CreditCardModel(
        isAutoPay: json["isAutoPay"] ?? false,
        isDefault: json["isDefault"] ?? false,
        creditCardId: json["creditCardId"] ?? 0,
        creditCardName: json["creditCardName"] ?? "khfkdh",
        inputSource: json["inputSource"] ?? "",
        expirationMonth: json["expirationMonth"] ?? 0,
        expirationYear: json["expirationYear"] ?? 0,
        lastFour: json["lastFour"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "isAutoPay": isAutoPay,
        "isDefault": isDefault,
        "creditCardId": creditCardId,
        "creditCardName": creditCardName,
        "inputSource": inputSource,
        "expirationMonth": expirationMonth,
        "expirationYear": expirationYear,
        "lastFour": lastFour,
      };
}

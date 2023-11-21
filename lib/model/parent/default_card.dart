// To parse this JSON data, do
//
//     final defaultCard = defaultCardFromJson(jsonString);

import 'dart:convert';

DefaultCard defaultCardFromJson(String str) =>
    DefaultCard.fromJson(json.decode(str));

String defaultCardToJson(DefaultCard data) => json.encode(data.toJson());

class DefaultCard {
  DefaultCard({
    required this.id,
    required this.statusCardOrBank,
    required this.name,
    required this.accountLastFour,
    required this.isAutoPay,
    required this.isBank,
  });

  int id;
  String statusCardOrBank;
  String name;
  String accountLastFour;
  bool isAutoPay;
  bool isBank;

  factory DefaultCard.fromJson(Map<String, dynamic> json) => DefaultCard(
        id: json["Id"] ?? 0,
        statusCardOrBank: json["statusCardORBank"] ?? "",
        name: json["Name"] ?? "",
        accountLastFour: json["accountLastFour"] ?? "",
        isAutoPay: json["isAutoPay"] ?? false,
        isBank: json["isBank"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "statusCardORBank": statusCardOrBank,
        "Name": name,
        "accountLastFour": accountLastFour,
        "isAutoPay": isAutoPay,
        "isBank": isBank,
      };
}

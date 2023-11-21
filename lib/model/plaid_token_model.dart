// To parse this JSON data, do
//
//     final plaidTokenModel = plaidTokenModelFromJson(jsonString);

import 'dart:convert';

PlaidTokenModel plaidTokenModelFromJson(String str) => PlaidTokenModel.fromJson(json.decode(str));

String plaidTokenModelToJson(PlaidTokenModel data) => json.encode(data.toJson());

class PlaidTokenModel {
  PlaidTokenModel({
    required this.expiration,
    required this.linkToken,
    required this.requestId,
  });

  DateTime expiration;
  String linkToken;
  String requestId;

  factory PlaidTokenModel.fromJson(Map<String, dynamic> json) => PlaidTokenModel(
    expiration: DateTime.parse(json["expiration"]),
    linkToken: json["link_token"],
    requestId: json["request_id"],
  );

  Map<String, dynamic> toJson() => {
    "expiration": expiration.toIso8601String(),
    "link_token": linkToken,
    "request_id": requestId,
  };
}

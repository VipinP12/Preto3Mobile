// To parse this JSON data, do
//
//     final wePayModel = wePayModelFromJson(jsonString);

import 'dart:convert';

WePayModel wePayModelFromJson(String str) => WePayModel.fromJson(json.decode(str));

String wePayModelToJson(WePayModel data) => json.encode(data.toJson());

class WePayModel {
  WePayModel({
    required this.creditCardId,
    required this.state,
  });

  int creditCardId;
  String state;

  factory WePayModel.fromJson(Map<String, dynamic> json) => WePayModel(
    creditCardId: json["credit_card_id"],
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "credit_card_id": creditCardId,
    "state": state,
  };
}

// To parse this JSON data, do
//
//     final socketConnectionModel = socketConnectionModelFromJson(jsonString);

import 'dart:convert';

SocketConnectionModel socketConnectionModelFromJson(String str) => SocketConnectionModel.fromJson(json.decode(str));

String socketConnectionModelToJson(SocketConnectionModel data) => json.encode(data.toJson());

class SocketConnectionModel {
  SocketConnectionModel({
    required this.to,
    required this.messageType,
  });

  String to;
  String messageType;

  factory SocketConnectionModel.fromJson(Map<String, dynamic> json) => SocketConnectionModel(
    to: json["to"],
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "to": to,
    "messageType": messageType,
  };
}

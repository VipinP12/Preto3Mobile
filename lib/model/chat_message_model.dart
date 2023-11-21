// To parse this JSON data, do
//
//     final chatMessageModel = chatMessageModelFromJson(jsonString);

import 'dart:convert';
import 'package:intl/intl.dart';

ChatMessageModel chatMessageModelFromJson(String str) =>
    ChatMessageModel.fromJson(json.decode(str));

String chatMessageModelToJson(ChatMessageModel data) =>
    json.encode(data.toJson());

class ChatMessageModel {
  ChatMessageModel({
    required this.messageResponses,
    required this.messageType,
  });

  List<MessageResponse> messageResponses;
  String messageType;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      ChatMessageModel(
        messageResponses: List<MessageResponse>.from(
            json["messageResponses"].map((x) => MessageResponse.fromJson(x))),
        messageType: json["messageType"],
      );

  Map<String, dynamic> toJson() => {
        "messageResponses":
            List<dynamic>.from(messageResponses.map((x) => x.toJson())),
        "messageType": messageType,
      };
}

class MessageResponse {
  MessageResponse(
      {required this.message,
      required this.userName,
      required this.sender,
      this.messageId,
      this.date,
      this.groupId,
      required this.type});

  String message;
  String userName;
  int sender;
  String? messageId;
  DateTime? date;
  String? groupId;
  String type;
  bool isDownload = false;

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      MessageResponse(
          message: json["message"] ?? "",
          userName: json["userName"],
          sender: json["sender"],
          messageId: json["messageId"],
          date: json["date"] == null || json["date"] == ""
              ? DateTime.fromMicrosecondsSinceEpoch(1647611647000 * 1000)
              : DateTime.fromMicrosecondsSinceEpoch(
                  int.parse(json["date"]) * 1000),
          groupId: json["groupId"] ?? "",
          type: json["fileType"] ?? "");

  Map<String, dynamic> toJson() => {
        "message": message,
        "userName": userName,
        "sender": sender,
        "messageId": messageId,
        "date": date,
        "groupId": groupId,
        "type": type
      };
}

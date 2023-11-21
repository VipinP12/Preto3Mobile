// To parse this JSON data, do
//
//     final commGroupModel = commGroupModelFromJson(jsonString);

import 'dart:convert';

CommGroupModel commGroupModelFromJson(String str) => CommGroupModel.fromJson(json.decode(str));

String commGroupModelToJson(CommGroupModel data) => json.encode(data.toJson());

class CommGroupModel {
  CommGroupModel({
    required this.listContent,
    required this.messageType,
  });

  List<ListContent> listContent;
  String messageType;

  factory CommGroupModel.fromJson(Map<String, dynamic> json) => CommGroupModel(
    listContent: List<ListContent>.from(json["listContent"].map((x) => ListContent.fromJson(x))),
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "listContent": List<dynamic>.from(listContent.map((x) => x.toJson())),
    "messageType": messageType,
  };
}

class ListContent {
  ListContent({
    required this.jid,
    required this.name,
    required this.lastMessage,
  });

  String jid;
  String name;
  LastMessage lastMessage;

  factory ListContent.fromJson(Map<String, dynamic> json) => ListContent(
    jid: json["jid"],
    name: json["name"],
    lastMessage: LastMessage.fromJson(json["lastMessage"]),
  );

  Map<String, dynamic> toJson() => {
    "jid": jid,
    "name": name,
    "lastMessage": lastMessage.toJson(),
  };
}

class LastMessage {
  LastMessage({
    this.messageId,
    required this.message,
    this.date,
    required this.userName,
    required this.sender,
  });

  String? messageId;
  String message;
  String? date;
  String userName;
  int sender;
  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
    messageId: json["messageId"],
    message: json["message"]??"",
    date: json["date"],
    userName: json["userName"]??"",
    sender: json["sender"]??0,
  );

  Map<String, dynamic> toJson() => {
    "messageId": messageId,
    "message": message,
    "date": date,
    "userName": userName,
    "sender": sender,
  };
}

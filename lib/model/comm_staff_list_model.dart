// To parse this JSON data, do
//
//     final commStaffListModel = commStaffListModelFromJson(jsonString);

import 'dart:convert';

CommStaffListModel commStaffListModelFromJson(String str) => CommStaffListModel.fromJson(json.decode(str));

String commStaffListModelToJson(CommStaffListModel data) => json.encode(data.toJson());

class CommStaffListModel {
  CommStaffListModel({
    required this.listContent,
    required this.messageType,
  });

  List<ListContent> listContent;
  String messageType;

  factory CommStaffListModel.fromJson(Map<String, dynamic> json) => CommStaffListModel(
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
  LastMessage();

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
  );

  Map<String, dynamic> toJson() => {
  };
}

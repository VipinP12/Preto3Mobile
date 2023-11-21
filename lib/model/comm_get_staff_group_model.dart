// To parse this JSON data, do
//
//     final commGetStaffGroupModel = commGetStaffGroupModelFromJson(jsonString);

import 'dart:convert';

List<CommGetStaffGroupModel> commGetStaffGroupModelFromJson(String str) =>
    List<CommGetStaffGroupModel>.from(
        json.decode(str).map((x) => CommGetStaffGroupModel.fromJson(x)));

String commGetStaffGroupModelToJson(List<CommGetStaffGroupModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommGetStaffGroupModel {
  CommGetStaffGroupModel({
    required this.roomId,
    required this.roomName,
    this.studentProfilePic,
    required this.userProfilePic,
    this.studentId,
    required this.staffId,
    required this.isBroadcast,
    this.classIds,
    required this.loggedInUserProfilePic,
  });

  String roomId;
  String roomName;
  dynamic studentProfilePic;
  String userProfilePic;
  dynamic studentId;
  int staffId;
  bool isBroadcast;
  dynamic classIds;
  String loggedInUserProfilePic;
  String message = "";
  DateTime date = DateTime.now();

  factory CommGetStaffGroupModel.fromJson(Map<String, dynamic> json) =>
      CommGetStaffGroupModel(
        roomId: json["roomId"],
        roomName: json["roomName"],
        studentProfilePic: json["studentProfilePic"],
        userProfilePic: json["userProfilePic"] ?? "",
        studentId: json["studentId"],
        staffId: json["staffId"],
        isBroadcast: json["isBroadcast"],
        classIds: json["classIds"],
        loggedInUserProfilePic: json["loggedInUserProfilePic"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "roomId": roomId,
        "roomName": roomName,
        "studentProfilePic": studentProfilePic,
        "userProfilePic": userProfilePic,
        "studentId": studentId,
        "staffId": staffId,
        "isBroadcast": isBroadcast,
        "classIds": classIds,
        "loggedInUserProfilePic": loggedInUserProfilePic,
      };
}

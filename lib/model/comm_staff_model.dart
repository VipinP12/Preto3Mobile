// To parse this JSON data, do
//
//     final commStaffModel = commStaffModelFromJson(jsonString);

import 'dart:convert';

List<CommStaffModel> commStaffModelFromJson(String str) =>
    List<CommStaffModel>.from(
        json.decode(str).map((x) => CommStaffModel.fromJson(x)));

String commStaffModelToJson(List<CommStaffModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommStaffModel {
  CommStaffModel({
    required this.staffId,
    required this.firstName,
    required this.lastName,
    required this.userName,
    this.profilePic,
    required this.isSubAdmin,
    required this.isTeacher,
    required this.isPunchMaster,
    required this.isSchoolAdmin,
    required this.emailId,
    required this.joiningDate,
    required this.inActiveDate,
    required this.inActiveReason,
    required this.isSelected,
  });

  int staffId;
  String firstName;
  String lastName;
  String userName;
  dynamic profilePic;
  String isSubAdmin;
  String isTeacher;
  String isPunchMaster;
  String isSchoolAdmin;
  String emailId;
  String joiningDate;
  String inActiveDate;
  String inActiveReason;
  bool isSelected;

  factory CommStaffModel.fromJson(Map<String, dynamic> json) => CommStaffModel(
      staffId: json["staffId"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      userName: json["userName"] ?? "",
      profilePic: json["profilePic"] ?? "",
      isSubAdmin: json["isSubAdmin"],
      isTeacher: json["isTeacher"],
      isPunchMaster: json["isPunchMaster"],
      isSchoolAdmin: json["isSchoolAdmin"],
      emailId: json["emailId"] ?? "",
      joiningDate: json["joiningDate"] ?? "",
      inActiveDate: json["inActiveDate"] ?? "",
      inActiveReason: json["inActiveReason"] ?? "",
      isSelected: false);

  Map<String, dynamic> toJson() => {
        "staffId": staffId,
        "firstName": firstName,
        "lastName": lastName,
        "userName": userName,
        "profilePic": profilePic,
        "isSubAdmin": isSubAdmin,
        "isTeacher": isTeacher,
        "isPunchMaster": isPunchMaster,
        "isSchoolAdmin": isSchoolAdmin,
        "emailId": emailId,
        "joiningDate": joiningDate,
        "inActiveDate": inActiveDate,
        "inActiveReason": inActiveReason,
      };
}

class PositionDetail {
  PositionDetail({
    this.positionName,
    required this.positionId,
  });

  String? positionName;
  int positionId;

  factory PositionDetail.fromJson(Map<String, dynamic> json) => PositionDetail(
        positionName: json["positionName"],
        positionId: json["positionId"],
      );

  Map<String, dynamic> toJson() => {
        "positionName": positionName,
        "positionId": positionId,
      };
}

class Room {
  Room({
    required this.roomName,
    required this.roomId,
  });

  String roomName;
  int roomId;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        roomName: json["RoomName"],
        roomId: json["RoomId"],
      );

  Map<String, dynamic> toJson() => {
        "RoomName": roomName,
        "RoomId": roomId,
      };
}

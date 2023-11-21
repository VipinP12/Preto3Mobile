// To parse this JSON data, do
//
//     final roomSelectedStaffModelDart = roomSelectedStaffModelDartFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<RoomSelectedStaffModelDart?>? roomSelectedStaffModelDartFromJson(String str) => json.decode(str) == null ? [] : List<RoomSelectedStaffModelDart?>.from(json.decode(str)!.map((x) => RoomSelectedStaffModelDart.fromJson(x)));

String roomSelectedStaffModelDartToJson(List<RoomSelectedStaffModelDart?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class RoomSelectedStaffModelDart {
  RoomSelectedStaffModelDart({
    required this.staffId,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.profilePic,
    required this.isSubAdmin,
    required this.isTeacher,
    required this.isPunchMaster,
    required this.isSchoolAdmin,
    required this.rooms,
    required this.emailId,
    required this.joiningDate,
    required this.inActiveDate,
    required this.inActiveReason,
    required this.certificationCount,
    required this.positionDetails,
  });

  int? staffId;
  String? firstName;
  String? lastName;
  String? userName;
  String? profilePic;
  String? isSubAdmin;
  String? isTeacher;
  String? isPunchMaster;
  String? isSchoolAdmin;
  List<Room?>? rooms;
  String? emailId;
  String? joiningDate;
  String? inActiveDate;
  String? inActiveReason;
  int? certificationCount;
  List<PositionDetail?>? positionDetails;

  factory RoomSelectedStaffModelDart.fromJson(Map<String, dynamic> json) => RoomSelectedStaffModelDart(
    staffId: json["staffId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    userName: json["userName"],
    profilePic: json["profilePic"],
    isSubAdmin: json["isSubAdmin"],
    isTeacher: json["isTeacher"],
    isPunchMaster: json["isPunchMaster"],
    isSchoolAdmin: json["isSchoolAdmin"],
    rooms: json["rooms"] == null ? [] : json["rooms"] == null ? [] : List<Room?>.from(json["rooms"]!.map((x) => Room.fromJson(x))),
    emailId: json["emailId"],
    joiningDate: json["joiningDate"],
    inActiveDate: json["inActiveDate"],
    inActiveReason: json["inActiveReason"],
    certificationCount: json["certificationCount"],
    positionDetails: json["positionDetails"] == null ? [] : json["positionDetails"] == null ? [] : List<PositionDetail?>.from(json["positionDetails"]!.map((x) => PositionDetail.fromJson(x))),
  );

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
    "rooms": rooms == null ? [] : rooms == null ? [] : List<dynamic>.from(rooms!.map((x) => x!.toJson())),
    "emailId": emailId,
    "joiningDate": joiningDate,
    "inActiveDate": inActiveDate,
    "inActiveReason": inActiveReason,
    "certificationCount": certificationCount,
    "positionDetails": positionDetails == null ? [] : positionDetails == null ? [] : List<dynamic>.from(positionDetails!.map((x) => x!.toJson())),
  };
}

class PositionDetail {
  PositionDetail({
    required this.positionName,
    required this.positionId,
  });

  String? positionName;
  String? positionId;

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

  String? roomName;
  int? roomId;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    roomName: json["RoomName"],
    roomId: json["RoomId"],
  );

  Map<String, dynamic> toJson() => {
    "RoomName": roomName,
    "RoomId": roomId,
  };
}

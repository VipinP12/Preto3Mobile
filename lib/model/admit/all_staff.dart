// To parse this JSON data, do
//
//     final allStaffList = allStaffListFromJson(jsonString);

import 'dart:convert';

List<AllStaffList> allStaffListFromJson(String str) => List<AllStaffList>.from(json.decode(str).map((x) => AllStaffList.fromJson(x)));

String allStaffListToJson(List<AllStaffList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllStaffList {
  int staffId;
  String firstName;
  String lastName;
  String userName;
  String profilePic;
  String isSubAdmin;
  String isTeacher;
  String isPunchMaster;
  String isSchoolAdmin;
  List<Room> rooms;
  String emailId;
  String joiningDate;
  dynamic inActiveDate;
  dynamic inActiveReason;
  int certificationCount;
  List<dynamic> positionDetails;

  AllStaffList({
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

  factory AllStaffList.fromJson(Map<String, dynamic> json) => AllStaffList(
    staffId: json["staffId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    userName: json["userName"],
    profilePic: json["profilePic"],
    isSubAdmin: json["isSubAdmin"],
    isTeacher: json["isTeacher"],
    isPunchMaster: json["isPunchMaster"],
    isSchoolAdmin: json["isSchoolAdmin"],
    rooms: List<Room>.from(json["rooms"].map((x) => Room.fromJson(x))),
    emailId: json["emailId"],
    joiningDate: json["joiningDate"],
    inActiveDate: json["inActiveDate"],
    inActiveReason: json["inActiveReason"],
    certificationCount: json["certificationCount"],
    positionDetails: List<dynamic>.from(json["positionDetails"].map((x) => x)),
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
    "rooms": List<dynamic>.from(rooms.map((x) => x.toJson())),
    "emailId": emailId,
    "joiningDate": joiningDate,
    "inActiveDate": inActiveDate,
    "inActiveReason": inActiveReason,
    "certificationCount": certificationCount,
    "positionDetails": List<dynamic>.from(positionDetails.map((x) => x)),
  };
}

class Room {
  String roomName;
  int roomId;

  Room({
    required this.roomName,
    required this.roomId,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    roomName: json["RoomName"],
    roomId: json["RoomId"],
  );

  Map<String, dynamic> toJson() => {
    "RoomName": roomName,
    "RoomId": roomId,
  };
}

// To parse this JSON data, do
//
//     final roomSelectedModel = roomSelectedModelFromJson(jsonString);

import 'dart:convert';

List<RoomStudentModel> roomStudentModelFromJson(String str) => List<RoomStudentModel>.from(json.decode(str).map((x) => RoomStudentModel.fromJson(x)));

String roomStudentModelToJson(List<RoomStudentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RoomStudentModel {
  String firstName;
  String lastName;
  int? checkInTime;
  dynamic checkOutTime;
  Status status;
  String? className;
  String? profilePic;
  dynamic checkInRemarks;
  dynamic checkOutRemarks;
  int id;
  int? signInIdCheckInId;
  dynamic signInIdCheckOutId;

  RoomStudentModel({
    required this.firstName,
    required this.lastName,
    required this.checkInTime,
    required this.checkOutTime,
    required this.status,
    required this.className,
    required this.profilePic,
    required this.checkInRemarks,
    required this.checkOutRemarks,
    required this.id,
    required this.signInIdCheckInId,
    required this.signInIdCheckOutId,
  });

  factory RoomStudentModel.fromJson(Map<String, dynamic> json) => RoomStudentModel(
    firstName: json["firstName"],
    lastName: json["lastName"],
    checkInTime: json["checkInTime"]??0,
    checkOutTime: json["checkOutTime"]??"",
    status: statusValues.map[json["status"]]!,
    className: json["className"],
    profilePic: json["profilePic"]??"",
    checkInRemarks: json["checkInRemarks"]??"",
    checkOutRemarks: json["checkOutRemarks"]??"",
    id: json["id"],
    signInIdCheckInId: json["signInIdCheckInId"]??0,
    signInIdCheckOutId: json["signInIdCheckOutId"]??"",
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "checkInTime": checkInTime,
    "checkOutTime": checkOutTime,
    "status": statusValues.reverse[status],
    "className": className,
    "profilePic": profilePic,
    "checkInRemarks": checkInRemarks,
    "checkOutRemarks": checkOutRemarks,
    "id": id,
    "signInIdCheckInId": signInIdCheckInId,
    "signInIdCheckOutId": signInIdCheckOutId,
  };
}

enum Status {
  ABSENT,
  CHECKED_IN,
  CHECKED_OUT
}

final statusValues = EnumValues({
  "Absent": Status.ABSENT,
  "Checked in": Status.CHECKED_IN,
  "Checked out": Status.CHECKED_OUT
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

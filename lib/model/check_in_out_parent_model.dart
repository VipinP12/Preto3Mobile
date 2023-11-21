// To parse this JSON data, do
//
//     final checkInOutParentModel = checkInOutParentModelFromJson(jsonString);

import 'dart:convert';

List<CheckInOutParentModel> checkInOutParentModelFromJson(String str) =>
    List<CheckInOutParentModel>.from(
        json.decode(str).map((x) => CheckInOutParentModel.fromJson(x)));

String checkInOutParentModelToJson(List<CheckInOutParentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CheckInOutParentModel {
  CheckInOutParentModel({
    required this.profilePic,
    required this.hours,
    required this.data,
  });

  String profilePic;
  String hours;
  List<Datum> data;

  factory CheckInOutParentModel.fromJson(Map<String, dynamic> json) =>
      CheckInOutParentModel(
        profilePic: json["profilePic"] ?? "",
        hours: json["hours"] ?? "",
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "profilePic": profilePic,
        "hours": hours,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.date,
    required this.hoursPerDay,
    required this.userId,
    required this.checkInTime,
    required this.checkOutTime,
  });

  int date;
  String hoursPerDay;
  int userId;
  int checkInTime;
  int checkOutTime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: json["date"] ?? 0,
        hoursPerDay: json["hoursPerDay"] ?? "",
        userId: json["userId"] ?? 0,
        checkInTime: json["checkInTime"] ?? 0,
        checkOutTime: json["checkOutTime"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "hoursPerDay": hoursPerDay,
        "userId": userId,
        "checkInTime": checkInTime,
        "checkOutTime": checkOutTime,
      };
}

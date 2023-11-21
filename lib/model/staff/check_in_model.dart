// To parse this JSON data, do
//
//     final checkInModel = checkInModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

List<CheckInModel> checkInModelFromJson(String str) => List<CheckInModel>.from(json.decode(str).map((x) => CheckInModel.fromJson(x)));

String checkInModelToJson(List<CheckInModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CheckInModel {
  CheckInModel({
    required this.firstName,
    required this.lastName,
    this.checkInTime,
    this.checkOutTime,
    required this.status,
    required this.className,
    this.profilePic,
    this.checkInRemarks,
    this.checkOutRemarks,
    required this.id,
    required this.isSelected,
    this.signInIdCheckInId,
    this.signInIdCheckOutId,
  });

  String firstName;
  String lastName;
  dynamic checkInTime;
  dynamic checkOutTime;
  String status;
  String className;
  String? profilePic;
  dynamic checkInRemarks;
  dynamic checkOutRemarks;
  int id;
  bool isSelected;
  int? signInIdCheckInId;
  dynamic signInIdCheckOutId;

  factory CheckInModel.fromJson(Map<String, dynamic> json) => CheckInModel(
    firstName: json["firstName"]??"",
    lastName: json["lastName"]??"",
    checkInTime: json["checkInTime"]!=null? DateFormat('jm').format(DateTime.fromMillisecondsSinceEpoch(json["checkInTime"])).toString(): "--",
    checkOutTime: json["checkOutTime"]!=null? DateFormat('jm').format(DateTime.fromMillisecondsSinceEpoch(json["checkOutTime"])).toString():"--",
    status: json["status"],
    className: json["className"]??"",
    profilePic: json["profilePic"]??"",
    checkInRemarks: json["checkInRemarks"]??"",
    checkOutRemarks: json["checkOutRemarks"]??"",
    id: json["id"],
    isSelected: false,
    signInIdCheckInId: json["signInIdCheckInId"]??0,
    signInIdCheckOutId: json["signInIdCheckOutId"]??0,
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "checkInTime": checkInTime,
    "checkOutTime": checkOutTime,
    "status": status,
    "className": className,
    "profilePic": profilePic,
    "checkInRemarks": checkInRemarks,
    "checkOutRemarks": checkOutRemarks,
    "id": id,
    "signInIdCheckInId": signInIdCheckInId,
    "signInIdCheckOutId": signInIdCheckOutId,
  };
}

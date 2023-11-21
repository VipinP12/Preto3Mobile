// To parse this JSON data, do
//
//     final adminDashboardModel = adminDashboardModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AdminDashboardModel? adminDashboardModelFromJson(String str) => AdminDashboardModel.fromJson(json.decode(str));

String adminDashboardModelToJson(AdminDashboardModel? data) => json.encode(data!.toJson());

class AdminDashboardModel {
  AdminDashboardModel({
    required this.studentRatioResponse,
    required this.staffRatioResponse,
    required this.roomCount,
    required this.birthdayResponse,
  });

  RatioResponse studentRatioResponse;
  RatioResponse staffRatioResponse;
  int roomCount;
  List<BirthdayResponse?> birthdayResponse;

  factory AdminDashboardModel.fromJson(Map<String, dynamic> json) => AdminDashboardModel(
    studentRatioResponse: RatioResponse.fromJson(json["studentRatioResponse"]),
    staffRatioResponse: RatioResponse.fromJson(json["staffRatioResponse"]),
    roomCount: json["roomCount"]??0,
    birthdayResponse: json["birthdayResponse"] == null ? [] : List<BirthdayResponse?>.from(json["birthdayResponse"]!.map((x) => BirthdayResponse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "studentRatioResponse": studentRatioResponse.toJson(),
    "staffRatioResponse": staffRatioResponse.toJson(),
    "roomCount": roomCount,
    "birthdayResponse": birthdayResponse == null ? [] : List<dynamic>.from(birthdayResponse.map((x) => x!.toJson())),
  };
}

class BirthdayResponse {
  BirthdayResponse({
    required this.name,
    required this.profilePic,
    required this.age,
    required this.dob,
  });

  String name;
  dynamic profilePic;
  int age;
  String dob;

  factory BirthdayResponse.fromJson(Map<String, dynamic> json) => BirthdayResponse(
    name: json["name"]??"",
    profilePic: json["profilePic"]??"",
    age: json["age"]??"",
    dob: json["dob"]??"",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "profilePic": profilePic,
    "age": age,
    "dob": dob,
  };
}

class RatioResponse {
  RatioResponse({
    required this.inSideFacilityCount,
    required this.outSideFacilityCount,
    required this.notShowUpCount,
    required this.totalCount,
  });

  int? inSideFacilityCount;
  int? outSideFacilityCount;
  int? notShowUpCount;
  int? totalCount;

  factory RatioResponse.fromJson(Map<String, dynamic> json) => RatioResponse(
    inSideFacilityCount: json["inSideFacilityCount"],
    outSideFacilityCount: json["outSideFacilityCount"],
    notShowUpCount: json["notShowUpCount"],
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "inSideFacilityCount": inSideFacilityCount,
    "outSideFacilityCount": outSideFacilityCount,
    "notShowUpCount": notShowUpCount,
    "totalCount": totalCount,
  };
}

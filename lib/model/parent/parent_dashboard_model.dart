// To parse this JSON data, do
//
//     final parentDashboardModel = parentDashboardModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

ParentDashboardModel parentDashboardModelFromJson(String str) =>
    ParentDashboardModel.fromJson(json.decode(str));

String parentDashboardModelToJson(ParentDashboardModel data) =>
    json.encode(data.toJson());

class ParentDashboardModel {
  ParentDashboardModel(
      {required this.parentFirstName,
      required this.parentLastName,
      required this.profilePic,
      required this.childDetails,
      required this.eventCount,
      required this.checkInOutPin,
      required this.schoolAddress});

  String parentFirstName;
  String parentLastName;
  String profilePic;
  List<ChildDetail> childDetails;
  int eventCount;
  String checkInOutPin;
  String schoolAddress;

  factory ParentDashboardModel.fromJson(Map<String, dynamic> json) =>
      ParentDashboardModel(
          parentFirstName: json["parentFirstName"],
          parentLastName: json["parentLastName"],
          profilePic: json["profilePic"] ?? "",
          childDetails: List<ChildDetail>.from(
              json["childDetails"].map((x) => ChildDetail.fromJson(x))),
          eventCount: json["eventCount"],
          checkInOutPin: json["checkInOutPin"],
          schoolAddress: json["schoolAddress"] ?? "");

  Map<String, dynamic> toJson() => {
        "parentFirstName": parentFirstName,
        "parentLastName": parentLastName,
        "profilePic": profilePic,
        "childDetails": List<dynamic>.from(childDetails.map((x) => x.toJson())),
        "eventCount": eventCount,
        "checkInOutPin": checkInOutPin,
        "schoolAddress": schoolAddress
      };
}

class ChildDetail {
  ChildDetail({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.inTime,
    this.outTime,
    this.totalHours,
    this.profilePic,
  });

  int id;
  String firstName;
  String lastName;
  dynamic inTime;
  dynamic outTime;
  dynamic totalHours;
  String? profilePic;

  factory ChildDetail.fromJson(Map<String, dynamic> json) => ChildDetail(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        inTime: json["inTime"] ?? "-",
        outTime: json["outTime"] ?? "-",
        totalHours: "-",
        profilePic: json["profilePic"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "inTime": inTime,
        "outTime": outTime,
        "profilePic": profilePic,
      };
}

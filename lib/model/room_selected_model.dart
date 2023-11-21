// To parse this JSON data, do
//
//     final roomSelectedModel = roomSelectedModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:preto3/model/comm_student_model.dart';

List<RoomSelectedModel> roomSelectedModelFromJson(String str) => List<RoomSelectedModel>.from(json.decode(str).map((x) => RoomSelectedModel.fromJson(x)));

String roomSelectedModelToJson(List<RoomSelectedModel?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class RoomSelectedModel {
  RoomSelectedModel({
    required this.className,
    required this.profilePic,
    required this.classId,
    required this.id,
    required this.parentDetails,
    required this.studentFullName,
    required this.scheduleDetails,
    required this.isSelected,
  });

  String? className;
  dynamic profilePic;
  int? classId;
  int? id;
  List<String?>? parentDetails;
  String? studentFullName;
  List<ScheduleDetail?>? scheduleDetails;
  bool isSelected;

  factory RoomSelectedModel.fromJson(Map<String, dynamic> json) => RoomSelectedModel(
    className: json["className"],
    profilePic: json["profilePic"]??"",
    classId: json["classId"],
    id: json["id"],
    parentDetails: json["parentDetails"] == null ? [] : List<String?>.from(json["parentDetails"]!.map((x) => x)),
    studentFullName: json["studentFullName"],
    scheduleDetails: json["scheduleDetails"] == null ? [] : List<ScheduleDetail?>.from(json["scheduleDetails"]!.map((x) => ScheduleDetail.fromJson(x))),
    isSelected: false
  );

  Map<String, dynamic> toJson() => {
    "className": className,
    "profilePic": profilePic,
    "classId": classId,
    "id": id,
    "parentDetails": parentDetails == null ? [] : List<dynamic>.from(parentDetails!.map((x) => x)),
    "studentFullName": studentFullName,
    "scheduleDetails": scheduleDetails == null ? [] : List<dynamic>.from(scheduleDetails!.map((x) => x!.toJson())),
  };
}

class ParentDetail {
  ParentDetail({
    required this.parentName,
    required this.userName,
    required this.parentId,
  });

  String? parentName;
  String? userName;
  int? parentId;

  factory ParentDetail.fromJson(Map<String, dynamic> json) => ParentDetail(
    parentName: json["parentName"],
    userName: json["userName"],
    parentId: json["parentId"],
  );

  Map<String, dynamic> toJson() => {
    "parentName": parentName,
    "userName": userName,
    "parentId": parentId,
  };
}

class ScheduleDetail {
  ScheduleDetail({
    required this.day,
    required this.scheduled,
  });

  int? day;
  bool? scheduled;

  factory ScheduleDetail.fromJson(Map<String, dynamic> json) => ScheduleDetail(
    day: json["day"],
    scheduled: json["scheduled"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "scheduled": scheduled,
  };
}

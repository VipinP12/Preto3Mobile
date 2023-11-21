// To parse this JSON data, do
//
//     final roomListModel = roomListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<RoomListModel?>? roomListModelFromJson(String str) => json.decode(str) == null ? [] : List<RoomListModel?>.from(json.decode(str)!.map((x) => RoomListModel.fromJson(x)));

String roomListModelToJson(List<RoomListModel?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class RoomListModel {
  RoomListModel({
    required this.teacherCount,
    required this.studentCount,
    required this.classId,
    required this.className,
    required this.status,
    required this.isDefault,
  });

  int? teacherCount;
  int? studentCount;
  int? classId;
  String? className;
  bool? status;
  bool? isDefault;

  factory RoomListModel.fromJson(Map<String, dynamic> json) => RoomListModel(
    teacherCount: json["teacherCount"],
    studentCount: json["studentCount"],
    classId: json["classId"],
    className: json["className"],
    status: json["status"],
    isDefault: json["isDefault"],
  );

  Map<String, dynamic> toJson() => {
    "teacherCount": teacherCount,
    "studentCount": studentCount,
    "classId": classId,
    "className": className,
    "status": status,
    "isDefault": isDefault,
  };
}

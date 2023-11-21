// To parse this JSON data, do
//
//     final saveActivityModel = saveActivityModelFromJson(jsonString);

import 'dart:convert';

SaveActivityModel saveActivityModelFromJson(String str) => SaveActivityModel.fromJson(json.decode(str));

String saveActivityModelToJson(SaveActivityModel data) => json.encode(data.toJson());

class SaveActivityModel {
  SaveActivityModel({
    required this.classId,
    required this.schoolId,
    required this.roleId,
    required this.studentIds,
    required this.activityDetail,
  });

  int classId;
  int schoolId;
  int roleId;
  List<int> studentIds;
  List<ActivityDetail> activityDetail;

  factory SaveActivityModel.fromJson(Map<String, dynamic> json) => SaveActivityModel(
    classId: json["classId"],
    schoolId: json["schoolId"],
    roleId: json["roleId"],
    studentIds: List<int>.from(json["studentIds"].map((x) => x)),
    activityDetail: List<ActivityDetail>.from(json["activityDetail"].map((x) => ActivityDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "classId": classId,
    "schoolId": schoolId,
    "roleId": roleId,
    "studentIds": List<dynamic>.from(studentIds.map((x) => x)),
    "activityDetail": List<dynamic>.from(activityDetail.map((x) => x.toJson())),
  };
}

class ActivityDetail {
  ActivityDetail({
    required this.startTime,
    required this.endTime,
    required this.activityType,
    required this.description,
    this.encryptId,
    this.selectedStartTime,
    this.selectedEndTime,
    this.activityId,
    this.activityClassMapId,
  });

  int startTime;
  int endTime;
  int activityType;
  String description;
  dynamic encryptId;
  dynamic selectedStartTime;
  dynamic selectedEndTime;
  dynamic activityId;
  dynamic activityClassMapId;

  factory ActivityDetail.fromJson(Map<String, dynamic> json) => ActivityDetail(
    startTime: json["startTime"],
    endTime: json["endTime"],
    activityType: json["activityType"],
    description: json["description"],
    encryptId: json["encryptId"],
    selectedStartTime: null,
    selectedEndTime: null,
    activityId: json["activityId"],
    activityClassMapId: json["activityClassMapId"],
  );

  Map<String, dynamic> toJson() => {
    "startTime": startTime,
    "endTime": endTime,
    "activityType": activityType,
    "description": description,
    "encryptId": encryptId,
    "activityId": activityId,
    "activityClassMapId": activityClassMapId,
  };
}

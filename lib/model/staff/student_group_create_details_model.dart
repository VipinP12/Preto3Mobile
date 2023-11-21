// To parse this JSON data, do
//
//     final studentGroupCreateDetails = studentGroupCreateDetailsFromJson(jsonString);

import 'dart:convert';

StudentGroupCreateDetails studentGroupCreateDetailsFromJson(String str) =>
    StudentGroupCreateDetails.fromJson(json.decode(str));

String studentGroupCreateDetailsToJson(StudentGroupCreateDetails data) =>
    json.encode(data.toJson());

class StudentGroupCreateDetails {
  StudentGroupCreateDetails({
    required this.groupId,
    required this.studentId,
    required this.staffId,
  });

  String groupId;
  String studentId;
  String staffId;

  factory StudentGroupCreateDetails.fromJson(Map<String, dynamic> json) =>
      StudentGroupCreateDetails(
        groupId: json["groupId"],
        studentId: json["studentId"],
        staffId: json["staffId"],
      );

  Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "studentId": studentId,
        "staffId": staffId,
      };
}

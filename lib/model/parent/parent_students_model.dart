// To parse this JSON data, do
//
//     final parentStudents = parentStudentsFromJson(jsonString);

import 'dart:convert';

List<ParentStudents> parentStudentsFromJson(String str) =>
    List<ParentStudents>.from(
        json.decode(str).map((x) => ParentStudents.fromJson(x)));

String parentStudentsToJson(List<ParentStudents> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ParentStudents {
  ParentStudents({
    required this.profilePic,
    required this.id,
    required this.parentDetails,
    required this.studentFullName,
  });

  String profilePic;
  int id;
  List<String> parentDetails;
  String studentFullName;
  bool flag = false;

  factory ParentStudents.fromJson(Map<String, dynamic> json) => ParentStudents(
        profilePic: json["profilePic"] ?? "",
        id: json["id"] ?? 0,
        parentDetails: List<String>.from(json["parentDetails"].map((x) => x)),
        studentFullName: json["studentFullName"],
      );

  Map<String, dynamic> toJson() => {
        "profilePic": profilePic,
        "id": id,
        "parentDetails": List<dynamic>.from(parentDetails.map((x) => x)),
        "studentFullName": studentFullName,
      };
}

// To parse this JSON data, do
//
//     final commStudentModel = commStudentModelFromJson(jsonString);

import 'dart:convert';

List<CommStudentModel> commStudentModelFromJson(String str) =>
    List<CommStudentModel>.from(
        json.decode(str).map((x) => CommStudentModel.fromJson(x)));

String commStudentModelToJson(List<CommStudentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommStudentModel {
  CommStudentModel({
    required this.className,
    required this.classId,
    required this.id,
    this.profilePic,
    required this.parentDetails,
    required this.studentFullName,
    required this.isSelected,
  });

  String className;
  int classId;
  int id;
  dynamic profilePic;
  List<ParentDetail> parentDetails;
  String studentFullName;
  bool isSelected;

  factory CommStudentModel.fromJson(Map<String, dynamic> json) =>
      CommStudentModel(
          className: json["className"] ?? "",
          classId: json["classId"] ?? 0,
          id: json["id"],
          profilePic: json["profilePic"] ?? "",
          parentDetails: List<ParentDetail>.from(
              json["parentDetails"].map((x) => ParentDetail.fromJson(x))),
          studentFullName: json["studentFullName"],
          isSelected: false);

  Map<String, dynamic> toJson() => {
        "className": className,
        "classId": classId,
        "id": id,
        "profilePic": profilePic,
        "parentDetails":
            List<dynamic>.from(parentDetails.map((x) => x.toJson())),
        "studentFullName": studentFullName,
      };
}

class ParentDetail {
  ParentDetail({
    required this.parentName,
    required this.userName,
    required this.parentId,
  });

  String parentName;
  String userName;
  int parentId;

  factory ParentDetail.fromJson(Map<String, dynamic> json) => ParentDetail(
        parentName: json["parentName"] ?? "",
        userName: json["userName"] ?? "",
        parentId: json["parentId"],
      );

  Map<String, dynamic> toJson() => {
        "parentName": parentName,
        "userName": userName,
        "parentId": parentId,
      };
}

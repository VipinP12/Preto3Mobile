// To parse this JSON data, do
//
//     final roomDetailModel = roomDetailModelFromJson(jsonString);

import 'dart:convert';

RoomDetailModel roomDetailModelFromJson(String str) => RoomDetailModel.fromJson(json.decode(str));

String roomDetailModelToJson(RoomDetailModel data) => json.encode(data.toJson());

class RoomDetailModel {
  RoomDetailModel({
    required this.roomName,
    required this.roomId,
    required this.assignedStaff,
    required this.assignedStudents,
  });

  String roomName;
  int roomId;
  List<AssignedStaff> assignedStaff;
  List<AssignedStudent> assignedStudents;

  factory RoomDetailModel.fromJson(Map<String, dynamic> json) => RoomDetailModel(
    roomName: json["roomName"],
    roomId: json["roomId"],
    assignedStaff: List<AssignedStaff>.from(json["assignedStaff"].map((x) => AssignedStaff.fromJson(x))),
    assignedStudents: List<AssignedStudent>.from(json["assignedStudents"].map((x) => AssignedStudent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "roomName": roomName,
    "roomId": roomId,
    "assignedStaff": List<dynamic>.from(assignedStaff.map((x) => x.toJson())),
    "assignedStudents": List<dynamic>.from(assignedStudents.map((x) => x.toJson())),
  };
}

class AssignedStaff {
  AssignedStaff({
    required this.staffName,
    required this.staffId,
  });

  String staffName;
  int staffId;

  factory AssignedStaff.fromJson(Map<String, dynamic> json) => AssignedStaff(
    staffName: json["staffName"],
    staffId: json["staffId"],
  );

  Map<String, dynamic> toJson() => {
    "staffName": staffName,
    "staffId": staffId,
  };
}

class AssignedStudent {
  AssignedStudent({
    required this.studentName,
    required this.studentId,
  });

  String studentName;
  int studentId;

  factory AssignedStudent.fromJson(Map<String, dynamic> json) => AssignedStudent(
    studentName: json["studentName"],
    studentId: json["studentId"],
  );

  Map<String, dynamic> toJson() => {
    "studentName": studentName,
    "studentId": studentId,
  };
}

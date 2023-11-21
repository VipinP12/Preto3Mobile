// To parse this JSON data, do
//
//     final staffDashboardModel = staffDashboardModelFromJson(jsonString);

import 'dart:convert';

StaffDashboardModel staffDashboardModelFromJson(String str) =>
    StaffDashboardModel.fromJson(json.decode(str));

String staffDashboardModelToJson(StaffDashboardModel data) =>
    json.encode(data.toJson());

class StaffDashboardModel {
  StaffDashboardModel({
    required this.staffFirstName,
    required this.staffLastName,
    this.profilePic,
    required this.staffCheckInoutdata,
    required this.roomDetails,
    required this.eventCount,
    required this.checkInOutPin,
  });

  String staffFirstName;
  String staffLastName;
  dynamic profilePic;
  StaffCheckInOutData staffCheckInoutdata;
  List<RoomDetail> roomDetails;
  int eventCount;
  String checkInOutPin;

  factory StaffDashboardModel.fromJson(Map<String, dynamic> json) =>
      StaffDashboardModel(
        staffFirstName: json["firstName"] ?? "",
        staffLastName: json["lastName"] ?? "",
        profilePic: json["profilePic"] ?? "",
        staffCheckInoutdata:
            StaffCheckInOutData.fromJson(json["staffCheckInoutdata"]),
        roomDetails: List<RoomDetail>.from(
            json["roomDetails"].map((x) => RoomDetail.fromJson(x))),
        eventCount: json["eventCount"],
        checkInOutPin: json["checkInOutPin"],
      );

  Map<String, dynamic> toJson() => {
        "staffFirstName": staffFirstName,
        "staffLastName": staffLastName,
        "profilePic": profilePic,
        "staffCheckInoutdata": staffCheckInoutdata.toJson(),
        "roomResponseForStaffDashboard":
            List<dynamic>.from(roomDetails.map((x) => x.toJson())),
        "eventCount": eventCount,
        "checkInOutPin": checkInOutPin,
      };
}

class RoomDetail {
  RoomDetail({
    required this.roomId,
    required this.roomName,
    required this.studentCheckInOutData,
  });

  int roomId;
  String roomName;
  StudentCheckInOutData studentCheckInOutData;

  factory RoomDetail.fromJson(Map<String, dynamic> json) => RoomDetail(
        roomId: json["roomId"],
        roomName: json["roomName"],
        studentCheckInOutData:
            StudentCheckInOutData.fromJson(json["studentCheckInOutData"]),
      );

  Map<String, dynamic> toJson() => {
        "roomId": roomId,
        "roomName": roomName,
        "studentCheckInOutData": studentCheckInOutData.toJson(),
      };
}

class StudentCheckInOutData {
  StudentCheckInOutData({
    required this.totalStudents,
    required this.studentIn,
    required this.studentAbsent,
  });

  int totalStudents;
  int studentIn;
  int studentAbsent;

  factory StudentCheckInOutData.fromJson(Map<String, dynamic> json) =>
      StudentCheckInOutData(
        totalStudents: json["totalStudents"],
        studentIn: json["studentIn"],
        studentAbsent: json["studentAbsent"],
      );

  Map<String, dynamic> toJson() => {
        "totalStudents": totalStudents,
        "studentIn": studentIn,
        "studentAbsent": studentAbsent,
      };
}

class StaffCheckInOutData {
  StaffCheckInOutData({
    this.inTime,
    this.outTime,
    this.totalHour,
  });

  dynamic inTime;
  dynamic outTime;
  dynamic totalHour;

  factory StaffCheckInOutData.fromJson(Map<String, dynamic> json) =>
      StaffCheckInOutData(
        inTime: json["inTime"] ?? "-",
        outTime: json["outTime"] ?? "-",
        totalHour: json["totalHour"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "inTime": inTime,
        "outTime": outTime,
        "totalHour": totalHour,
      };
}

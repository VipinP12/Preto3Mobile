// To parse this JSON data, do
//
//     final punchStudentModel = punchStudentModelFromJson(jsonString);

import 'dart:convert';

PunchStudentModel punchStudentModelFromJson(String str) =>
    PunchStudentModel.fromJson(json.decode(str));

String punchStudentModelToJson(PunchStudentModel data) =>
    json.encode(data.toJson());

class PunchStudentModel {
  PunchStudentModel({
    required this.createdLocalTime,
    required this.total,
    required this.utcTime,
    required this.totalHours,
    required this.studentInfoList,
    required this.punchMasterMultipleRoleList,
    required this.checkInOutActivityDetailsDtoList,
  });

  int createdLocalTime;
  int total;
  int utcTime;
  String totalHours;
  List<StudentInfoList> studentInfoList;
  List<PunchMasterMultipleRoleList> punchMasterMultipleRoleList;
  List<dynamic> checkInOutActivityDetailsDtoList;

  factory PunchStudentModel.fromJson(Map<String, dynamic> json) =>
      PunchStudentModel(
        createdLocalTime: json["createdLocalTime"],
        total: json["total"],
        utcTime: json["utcTime"],
        totalHours: json["totalHours"],
        studentInfoList: List<StudentInfoList>.from(
            json["studentInfoList"].map((x) => StudentInfoList.fromJson(x))),
        punchMasterMultipleRoleList: List<PunchMasterMultipleRoleList>.from(
            json["punchMasterMultipleRoleList"]
                .map((x) => PunchMasterMultipleRoleList.fromJson(x))),
        checkInOutActivityDetailsDtoList: List<dynamic>.from(
            json["checkInOutActivityDetailsDTOList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "createdLocalTime": createdLocalTime,
        "total": total,
        "utcTime": utcTime,
        "totalHours": totalHours,
        "studentInfoList": List<dynamic>.from(studentInfoList.map((x) => x)),
        "punchMasterMultipleRoleList": List<dynamic>.from(
            punchMasterMultipleRoleList.map((x) => x.toJson())),
        "checkInOutActivityDetailsDTOList":
            List<dynamic>.from(checkInOutActivityDetailsDtoList.map((x) => x)),
      };
}

class StudentInfoList {
  StudentInfoList(
      {
      //   this.status,
      required this.profilePic,
      required this.id,
      required this.firstName,
      required this.lastName,
      this.schoolId,
      required this.parentId,
      required this.isSelected,
      required this.checkedInOutStatus});

  // dynamic status;
  String profilePic;
  int id;
  String firstName;
  String lastName;
  dynamic schoolId;
  String parentId;
  bool isSelected;
  String checkedInOutStatus;

  factory StudentInfoList.fromJson(Map<String, dynamic> json) =>
      StudentInfoList(
          // status: json["status"],
          profilePic: json["profilePic"],
          id: json["id"],
          firstName: json["firstName"],
          lastName: json["lastName"],
          schoolId: json["schoolId"],
          parentId: json["parentId"],
          checkedInOutStatus: json["checkedInOutStatus"] ?? "",
          isSelected: false);

  Map<String, dynamic> toJson() => {
        //"status": status,
        "profilePic": profilePic,
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "schoolId": schoolId,
        "parentId": parentId,
        "checkedInOutStatus": checkedInOutStatus
      };
}

class PunchMasterMultipleRoleList {
  PunchMasterMultipleRoleList(
      {required this.userMetaData,
      required this.firstName,
      required this.lastName,
      required this.userProfilePic,
      required this.isSelected,
      required this.checkedInOutStatus,
      required this.schoolId});

  String userMetaData;
  String firstName;
  String lastName;
  String userProfilePic;
  String checkedInOutStatus;
  int schoolId;
  bool isSelected;

  factory PunchMasterMultipleRoleList.fromJson(Map<String, dynamic> json) =>
      PunchMasterMultipleRoleList(
        userMetaData: json["userMetaData"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        userProfilePic: json["userProfilePic"] ?? "",
        checkedInOutStatus: json["checkedInOutStatus"] ?? "",
        schoolId: json["schoolId"] ?? 0,
        isSelected: false,
      );

  Map<String, dynamic> toJson() => {
        "userMetaData": userMetaData,
        "firstName": firstName,
        "lastName": lastName,
        "userProfilePic": userProfilePic,
        "checkedInOutStatus": checkedInOutStatus,
        "schoolId": schoolId
      };
}

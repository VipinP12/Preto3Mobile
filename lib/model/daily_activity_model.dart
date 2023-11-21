// To parse this JSON data, do
//
//     final dailyActivityModel = dailyActivityModelFromJson(jsonString);

import 'dart:convert';

List<DailyActivityModel> dailyActivityModelFromJson(String str) =>
    List<DailyActivityModel>.from(
        json.decode(str).map((x) => DailyActivityModel.fromJson(x)));

String dailyActivityModelToJson(List<DailyActivityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DailyActivityModel {
  DailyActivityModel({
    required this.date,
    required this.student,
  });

  int date;
  List<Student> student;

  factory DailyActivityModel.fromJson(Map<String, dynamic> json) =>
      DailyActivityModel(
        date: json["date"] ?? 0,
        student:
            List<Student>.from(json["student"].map((x) => Student.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "student": List<dynamic>.from(student.map((x) => x.toJson())),
      };
}

class Student {
  Student({
    required this.studentId,
    required this.firstName,
    required this.lastName,
    this.profilePic,
    this.dateOfBirth,
    this.age,
    this.roomName,
    required this.parentDetails,
    required this.activities,
    required this.activityImgUrls,
  });

  int studentId;
  String firstName;
  String lastName;
  dynamic profilePic;
  dynamic dateOfBirth;
  dynamic age;
  dynamic roomName;
  List<dynamic> parentDetails;
  List<Activity> activities;
  List<String> activityImgUrls;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
      studentId: json["studentId"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      profilePic: json["profilePic"] ?? "",
      dateOfBirth: json["dateOfBirth"] ?? "",
      age: json["age"] ?? "",
      roomName: json["roomName"] ?? "",
      parentDetails: List<dynamic>.from(json["parentDetails"].map((x) => x)),
      activities: List<Activity>.from(
          json["activities"].map((x) => Activity.fromJson(x))),
      activityImgUrls: json["activityImgUrls"] == null
          ? []
          : List<String>.from(json["activityImgUrls"].map((x) => x)));

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "firstName": firstName,
        "lastName": lastName,
        "profilePic": profilePic,
        "dateOfBirth": dateOfBirth,
        "age": age,
        "roomName": roomName,
        "parentDetails": List<dynamic>.from(parentDetails.map((x) => x)),
        "activities": List<dynamic>.from(activities.map((x) => x.toJson())),
        "activityImgUrls": List<dynamic>.from(activityImgUrls.map((x) => x)),
      };
}

class Activity {
  Activity({
    required this.activityId,
    required this.activityType,
    required this.activityStartTime,
    required this.activityEndTime,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.createdByFirstName,
    required this.createdByLastName,
    required this.localCreatedTime,
  });

  int activityId;
  int activityType;
  String activityStartTime;
  String activityEndTime;
  int id;
  String name;
  String imageUrl;
  String createdByFirstName;
  String createdByLastName;
  int localCreatedTime;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        activityId: json["activityId"],
        activityType: json["activityType"],
        activityStartTime: json["activityStartTime"],
        activityEndTime: json["activityEndTime"],
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        createdByFirstName: json["createdByFirstName"],
        createdByLastName: json["createdByLastName"],
        localCreatedTime: json["localCreatedTime"],
      );

  Map<String, dynamic> toJson() => {
        "activityId": activityId,
        "activityType": activityType,
        "activityStartTime": activityStartTime,
        "activityEndTime": activityEndTime,
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "createdByFirstName": createdByFirstName,
        "createdByLastName": createdByLastName,
        "localCreatedTime": localCreatedTime,
      };
}

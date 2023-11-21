// To parse this JSON data, do
//
//     final allEventModel = allEventModelFromJson(jsonString);

import 'dart:convert';

List<AllEventModel> allEventModelFromJson(String str) =>
    List<AllEventModel>.from(
        json.decode(str).map((x) => AllEventModel.fromJson(x)));

String allEventModelToJson(List<AllEventModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllEventModel {
  AllEventModel({
    required this.eventId,
    this.eventTitle,
    required this.eventStartTime,
    required this.eventEndTime,
    required this.eventVenueAddress,
    required this.eventLink,
    required this.mapStatus,
    required this.eventStudentMaps,
    required this.eventStaffMaps,
    required this.firstName,
    required this.lastName,
    required this.recurringEvent,
    required this.fullDay,
    required this.announcement,
    required this.description,
    required this.isUpcoming,
  });

  int eventId;
  String? eventTitle;
  String eventStartTime;
  String eventEndTime;
  String eventVenueAddress;
  String eventLink;
  bool mapStatus;
  List<EventStudentMap> eventStudentMaps;
  List<EventStaffMap> eventStaffMaps;
  String firstName;
  String lastName;
  bool recurringEvent;
  bool fullDay;
  bool announcement;
  String description;
  bool isUpcoming;

  factory AllEventModel.fromJson(Map<String, dynamic> json) => AllEventModel(
        eventId: json["eventId"],
        eventTitle: json["eventTitle"] ?? "",
        eventStartTime: json["eventStartTime"] ?? DateTime.now().toString(),
        eventEndTime: json["eventEndTime"] ?? DateTime.now().toString(),
        eventVenueAddress: json["eventVenueAddress"],
        eventLink: json["eventLink"],
        mapStatus: json["mapStatus"],
        eventStudentMaps: List<EventStudentMap>.from(
            json["eventStudentMaps"].map((x) => EventStudentMap.fromJson(x))),
        eventStaffMaps: List<EventStaffMap>.from(
            json["eventStaffMaps"].map((x) => EventStaffMap.fromJson(x))),
        firstName: json["firstName"],
        lastName: json["lastName"],
        recurringEvent: json["recurringEvent"],
        fullDay: json["fullDay"],
        announcement: json["announcement"],
        description: json["description"] ?? "",
        isUpcoming: false,
      );

  Map<String, dynamic> toJson() => {
        "eventId": eventId,
        "eventTitle": eventTitle,
        "eventStartTime": eventStartTime,
        "eventEndTime": eventEndTime,
        "eventVenueAddress": eventVenueAddress,
        "eventLink": eventLink,
        "mapStatus": mapStatus,
        "eventStudentMaps":
            List<dynamic>.from(eventStudentMaps.map((x) => x.toJson())),
        "eventStaffMaps":
            List<dynamic>.from(eventStaffMaps.map((x) => x.toJson())),
        "firstName": firstName,
        "lastName": lastName,
        "recurringEvent": recurringEvent,
        "fullDay": fullDay,
        "announcement": announcement,
        "description": description,
      };
}

class EventStaffMap {
  EventStaffMap({
    required this.eventStaffMapId,
    required this.staffId,
    required this.respondStatus,
    required this.firstName,
    required this.lastName,
    this.profilePic,
  });

  int eventStaffMapId;
  int staffId;
  int respondStatus;
  String firstName;
  String lastName;
  String? profilePic;

  factory EventStaffMap.fromJson(Map<String, dynamic> json) => EventStaffMap(
        eventStaffMapId: json["eventStaffMapId"],
        staffId: json["staffId"],
        respondStatus: json["respondStatus"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilePic: json["profilePic"],
      );

  Map<String, dynamic> toJson() => {
        "eventStaffMapId": eventStaffMapId,
        "staffId": staffId,
        "respondStatus": respondStatus,
        "firstName": firstName,
        "lastName": lastName,
        "profilePic": profilePic,
      };
}

class EventStudentMap {
  EventStudentMap({
    required this.studentId,
    required this.eventStudentParentMaps,
    required this.firstName,
    required this.lastName,
    this.profilePicture,
  });

  int studentId;
  List<EventStudentParentMap> eventStudentParentMaps;
  String firstName;
  String lastName;
  String? profilePicture;

  factory EventStudentMap.fromJson(Map<String, dynamic> json) =>
      EventStudentMap(
        studentId: json["studentId"],
        eventStudentParentMaps: List<EventStudentParentMap>.from(
            json["eventStudentParentMaps"]
                .map((x) => EventStudentParentMap.fromJson(x))),
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilePicture: json["profilePicture"],
      );

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "eventStudentParentMaps":
            List<dynamic>.from(eventStudentParentMaps.map((x) => x.toJson())),
        "firstName": firstName,
        "lastName": lastName,
        "profilePicture": profilePicture,
      };
}

class EventStudentParentMap {
  EventStudentParentMap({
    required this.eventStudentMapId,
    required this.parentId,
    required this.respondStatus,
    required this.firstName,
    required this.lastName,
    this.relationType,
  });

  int eventStudentMapId;
  int parentId;
  int respondStatus;
  String firstName;
  String lastName;
  String? relationType;

  factory EventStudentParentMap.fromJson(Map<String, dynamic> json) =>
      EventStudentParentMap(
        eventStudentMapId: json["eventStudentMapId"],
        parentId: json["parentId"],
        respondStatus: json["respondStatus"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        relationType: json["relationType"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "eventStudentMapId": eventStudentMapId,
        "parentId": parentId,
        "respondStatus": respondStatus,
        "firstName": firstName,
        "lastName": lastName,
        "relationType": relationType,
      };
}

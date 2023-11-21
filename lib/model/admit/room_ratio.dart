// To parse this JSON data, do
//
//     final roomRatioModel = roomRatioModelFromJson(jsonString);

import 'dart:convert';

RoomRatioModel roomRatioModelFromJson(String str) => RoomRatioModel.fromJson(json.decode(str));

String roomRatioModelToJson(RoomRatioModel data) => json.encode(data.toJson());

class RoomRatioModel {
  dynamic studentRatioResponse;
  dynamic staffRatioResponse;
  List<RoomResponse> roomResponse;

  RoomRatioModel({
    required this.studentRatioResponse,
    required this.staffRatioResponse,
    required this.roomResponse,
  });

  factory RoomRatioModel.fromJson(Map<String, dynamic> json) => RoomRatioModel(
    studentRatioResponse: json["studentRatioResponse"],
    staffRatioResponse: json["staffRatioResponse"],
    roomResponse: List<RoomResponse>.from(json["roomResponse"].map((x) => RoomResponse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "studentRatioResponse": studentRatioResponse,
    "staffRatioResponse": staffRatioResponse,
    "roomResponse": List<dynamic>.from(roomResponse.map((x) => x.toJson())),
  };
}

class RoomResponse {
  String name;
  int studentCount;
  int staffCount;

  RoomResponse({
    required this.name,
    required this.studentCount,
    required this.staffCount,
  });

  factory RoomResponse.fromJson(Map<String, dynamic> json) => RoomResponse(
    name: json["name"],
    studentCount: json["studentCount"],
    staffCount: json["staffCount"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "studentCount": studentCount,
    "staffCount": staffCount,
  };
}

// To parse this JSON data, do
//
//     final raceModelDart = raceModelDartFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RaceModelDart? raceModelDartFromJson(String str) => RaceModelDart.fromJson(json.decode(str));

String raceModelDartToJson(RaceModelDart? data) => json.encode(data!.toJson());

class RaceModelDart {
  RaceModelDart({
    required this.raceList,
    required this.ethnicityList,
  });

  List<RaceList?>? raceList;
  List<EthnicityList?>? ethnicityList;

  factory RaceModelDart.fromJson(Map<String, dynamic> json) => RaceModelDart(
    raceList: json["raceList"] == null ? [] : List<RaceList?>.from(json["raceList"]!.map((x) => RaceList.fromJson(x))),
    ethnicityList: json["ethnicityList"] == null ? [] : List<EthnicityList?>.from(json["ethnicityList"]!.map((x) => EthnicityList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "raceList": raceList == null ? [] : List<dynamic>.from(raceList!.map((x) => x!.toJson())),
    "ethnicityList": ethnicityList == null ? [] : List<dynamic>.from(ethnicityList!.map((x) => x!.toJson())),
  };
}

class EthnicityList {
  EthnicityList({
    required this.ethnicityId,
    required this.ethnicityIdDescription,
  });

  int? ethnicityId;
  String? ethnicityIdDescription;

  factory EthnicityList.fromJson(Map<String, dynamic> json) => EthnicityList(
    ethnicityId: json["ethnicityId"],
    ethnicityIdDescription: json["ethnicityIdDescription"],
  );

  Map<String, dynamic> toJson() => {
    "ethnicityId": ethnicityId,
    "ethnicityIdDescription": ethnicityIdDescription,
  };
}

class RaceList {
  RaceList({
    required this.raceId,
    required this.raceDescription,
  });

  int? raceId;
  String? raceDescription;

  factory RaceList.fromJson(Map<String, dynamic> json) => RaceList(
    raceId: json["raceId"],
    raceDescription: json["raceDescription"],
  );

  Map<String, dynamic> toJson() => {
    "raceId": raceId,
    "raceDescription": raceDescription,
  };
}

// To parse this JSON data, do
//
//     final dailyActivityTypeModel = dailyActivityTypeModelFromJson(jsonString);

import 'dart:convert';

List<DailyActivityTypeModel> dailyActivityTypeModelFromJson(String str) => List<DailyActivityTypeModel>.from(json.decode(str).map((x) => DailyActivityTypeModel.fromJson(x)));

String dailyActivityTypeModelToJson(List<DailyActivityTypeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DailyActivityTypeModel {
  DailyActivityTypeModel({
    required this.activityId,
    required this.title,
    required this.imageType,
    required this.isSelected,
  });

  int activityId;
  String title;
  String imageType;
  bool isSelected;

  factory DailyActivityTypeModel.fromJson(Map<String, dynamic> json) => DailyActivityTypeModel(
    activityId: json["activityId"],
    title: json["title"],
    imageType: json["imageType"],
    isSelected: false,
  );

  Map<String, dynamic> toJson() => {
    "activityId": activityId,
    "title": title,
    "imageType": imageType,
  };
}

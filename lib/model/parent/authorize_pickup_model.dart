// To parse this JSON data, do
//
//     final authorizePickupModel = authorizePickupModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

List<AuthorizePickupModel> authorizePickupModelFromJson(String str) =>
    List<AuthorizePickupModel>.from(
        json.decode(str).map((x) => AuthorizePickupModel.fromJson(x)));

String authorizePickupModelToJson(List<AuthorizePickupModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AuthorizePickupModel {
  AuthorizePickupModel({
    required this.studentFirstName,
    required this.studentLastName,
    required this.profilePic,
    required this.authorizedPickUpDetailModelList,
  });

  String studentFirstName;
  String studentLastName;
  String profilePic;
  List<AuthorizedPickUpDetailModelList> authorizedPickUpDetailModelList;

  factory AuthorizePickupModel.fromJson(Map<String, dynamic> json) =>
      AuthorizePickupModel(
        studentFirstName: json["studentFirstName"] ?? "",
        studentLastName: json["studentLastName"] ?? "",
        profilePic: json["profilePic"] ?? "",
        authorizedPickUpDetailModelList:
            List<AuthorizedPickUpDetailModelList>.from(
                json["authorizedPickUpDetailModelList"]
                    .map((x) => AuthorizedPickUpDetailModelList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "studentFirstName": studentFirstName,
        "studentLastName": studentLastName,
        "profilePic": profilePic,
        "authorizedPickUpDetailModelList": List<dynamic>.from(
            authorizedPickUpDetailModelList.map((x) => x.toJson())),
      };
}

class AuthorizedPickUpDetailModelList {
  AuthorizedPickUpDetailModelList({
    required this.authorizedPickUpDetailId,
    required this.pickupByFirstName,
    required this.pickUpByLastName,
    required this.dateFrom,
    required this.dateTo,
    required this.pickUpTime,
    required this.phoneNumber,
    required this.email,
    required this.pickUpAddress,
  });

  int authorizedPickUpDetailId;
  String pickupByFirstName;
  String pickUpByLastName;
  String dateFrom;
  String dateTo;
  String pickUpTime;
  String phoneNumber;
  String email;
  String pickUpAddress;

  factory AuthorizedPickUpDetailModelList.fromJson(Map<String, dynamic> json) =>
      AuthorizedPickUpDetailModelList(
        authorizedPickUpDetailId: json["authorizedPickUpDetailId"],
        pickupByFirstName: json["pickupByFirstName"] ?? "",
        pickUpByLastName: json["pickUpByLastName"] ?? "",
        dateFrom: DateFormat('MM/dd/yyyy')
            .format(DateTime.fromMillisecondsSinceEpoch(json["dateFrom"],
                isUtc: true))
            .toString(),
        dateTo: DateFormat('MM/dd/yyyy')
            .format(DateTime.fromMillisecondsSinceEpoch(json["dateTo"],
                isUtc: true))
            .toString(),
        pickUpTime: json["pickUpTime"] ?? "00:00:00",
        phoneNumber: json["phoneNumber"] ?? "",
        email: json["email"] ?? "",
        pickUpAddress: json["pickUpAddress"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "authorizedPickUpDetailId": authorizedPickUpDetailId,
        "pickupByFirstName": pickupByFirstName,
        "pickUpByLastName": pickUpByLastName,
        "dateFrom": dateFrom,
        "dateTo": dateTo,
        "pickUpTime": pickUpTime,
        "phoneNumber": phoneNumber,
        "email": email,
        "pickUpAddress": pickUpAddress,
      };
}

// To parse this JSON data, do
//
//     final parentProfileModel = parentProfileModelFromJson(jsonString);

import 'dart:convert';

ParentProfileModel parentProfileModelFromJson(String str) =>
    ParentProfileModel.fromJson(json.decode(str));

String parentProfileModelToJson(ParentProfileModel data) =>
    json.encode(data.toJson());

class ParentProfileModel {
  ParentProfileModel({
    required this.id,
    required this.roleId,
    this.studentId,
    required this.schoolId,
    this.parentType,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.country,
    required this.state,
    required this.city,
    required this.checkInOutPin,
    required this.cityId,
    required this.stateId,
    required this.countryId,
    this.zipCode,
    required this.profilePic,
  });

  int id;
  int roleId;
  dynamic studentId;
  int schoolId;
  dynamic parentType;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String address;
  String country;
  String state;
  String city;
  String checkInOutPin;
  int cityId;
  int stateId;
  int countryId;
  dynamic zipCode;
  String profilePic;

  factory ParentProfileModel.fromJson(Map<String, dynamic> json) =>
      ParentProfileModel(
        id: json["id"],
        roleId: json["roleId"],
        studentId: json["studentId"],
        schoolId: json["schoolId"],
        parentType: json["parentType"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"] ?? "",
        address: json["address"] ?? "",
        country: json["country"] ?? "",
        state: json["state"] ?? "",
        city: json["city"] ?? "",
        checkInOutPin: json["checkInOutPin"] ?? "",
        cityId: json["cityId"] ?? 0,
        stateId: json["stateId"] ?? 0,
        countryId: json["countryId"] ?? 0,
        zipCode: json["zipCode"],
        profilePic: json["profilePic"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "roleId": roleId,
        "studentId": studentId,
        "schoolId": schoolId,
        "parentType": parentType,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "address": address,
        "country": country,
        "state": state,
        "city": city,
        "checkInOutPin": checkInOutPin,
        "cityId": cityId,
        "stateId": stateId,
        "countryId": countryId,
        "zipCode": zipCode,
        "profilePic": profilePic,
      };
}

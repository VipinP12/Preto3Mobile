// To parse this JSON data, do
//
//     final adminProfile = adminProfileFromJson(jsonString);

import 'dart:convert';

AdminProfile adminProfileFromJson(String str) => AdminProfile.fromJson(json.decode(str));

String adminProfileToJson(AdminProfile data) => json.encode(data.toJson());

class AdminProfile {
  int id;
  String userFirstName;
  String userLastName;
  String adminBio;
  String userEmail;
  String userPhoneNumber;
  String dateOfBirth;
  String userProfilePic;
  String userRoleDescription;
  // List<int> spokenLanguages;
  String spokenLanguagesStr;
  dynamic userAddress;
  dynamic cityName;
  dynamic cityId;
  dynamic stateName;
  dynamic stateId;
  dynamic countryName;
  dynamic countryId;
  dynamic zipCode;
  String checkInOutPin;
  bool userRegistered;
  bool phoneValidated;
  bool emailValidated;

  AdminProfile({
    required this.id,
    required this.userFirstName,
    required this.userLastName,
    required this.adminBio,
    required this.userEmail,
    required this.userPhoneNumber,
    required this.dateOfBirth,
    required this.userProfilePic,
    required this.userRoleDescription,
    // required this.spokenLanguages,
    required this.spokenLanguagesStr,
    required this.userAddress,
    required this.cityName,
    required this.cityId,
    required this.stateName,
    required this.stateId,
    required this.countryName,
    required this.countryId,
    required this.zipCode,
    required this.checkInOutPin,
    required this.userRegistered,
    required this.phoneValidated,
    required this.emailValidated,
  });

  factory AdminProfile.fromJson(Map<String, dynamic> json) => AdminProfile(
    id: json["id"],
    userFirstName: json["userFirstName"],
    userLastName: json["userLastName"],
    adminBio: json["adminBio"]??"",
    userEmail: json["userEmail"],
    userPhoneNumber: json["userPhoneNumber"],
    dateOfBirth: json["dateOfBirth"],
    userProfilePic: json["userProfilePic"]??"",
    userRoleDescription: json["userRoleDescription"],
    // spokenLanguages: List<int>.from(json["spokenLanguages"].map((x) => x)),
    spokenLanguagesStr: json["spokenLanguagesStr"]??"",
    userAddress: json["userAddress"]??"",
    cityName: json["cityName"]??"",
    cityId: json["cityId"]??"",
    stateName: json["stateName"]??"",
    stateId: json["stateId"]??"",
    countryName: json["countryName"]??"",
    countryId: json["countryId"]??"",
    zipCode: json["zipCode"]??"",
    checkInOutPin: json["checkInOutPin"],
    userRegistered: json["userRegistered"],
    phoneValidated: json["phoneValidated"],
    emailValidated: json["emailValidated"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userFirstName": userFirstName,
    "userLastName": userLastName,
    "adminBio": adminBio,
    "userEmail": userEmail,
    "userPhoneNumber": userPhoneNumber,
    "dateOfBirth": dateOfBirth,
    "userProfilePic": userProfilePic,
    "userRoleDescription": userRoleDescription,
    // "spokenLanguages": List<dynamic>.from(spokenLanguages.map((x) => x)),
    "spokenLanguagesStr": spokenLanguagesStr,
    "userAddress": userAddress,
    "cityName": cityName,
    "cityId": cityId,
    "stateName": stateName,
    "stateId": stateId,
    "countryName": countryName,
    "countryId": countryId,
    "zipCode": zipCode,
    "checkInOutPin": checkInOutPin,
    "userRegistered": userRegistered,
    "phoneValidated": phoneValidated,
    "emailValidated": emailValidated,
  };
}

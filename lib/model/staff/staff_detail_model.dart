// To parse this JSON data, do
//
//     final staffDetailModel = staffDetailModelFromJson(jsonString);

import 'dart:convert';

StaffDetailModel staffDetailModelFromJson(String str) => StaffDetailModel.fromJson(json.decode(str));

String staffDetailModelToJson(StaffDetailModel data) => json.encode(data.toJson());

class StaffDetailModel {
  StaffDetailModel({
    required this.staffPersonalDetails,
    required this.staffContactDetails,
    required this.staffEmploymentDetails,
    required this.staffEmergencyContactDetails,
    required this.staffScheduleDetails,
    required this.staffQualifications,
  });

  StaffPersonalDetails staffPersonalDetails;
  StaffContactDetails staffContactDetails;
  StaffEmploymentDetails staffEmploymentDetails;
  List<StaffEmergencyContactDetail> staffEmergencyContactDetails;
  StaffScheduleDetails staffScheduleDetails;
  List<StaffQualification> staffQualifications;

  factory StaffDetailModel.fromJson(Map<String, dynamic> json) => StaffDetailModel(
    staffPersonalDetails: StaffPersonalDetails.fromJson(json["staffPersonalDetails"]),
    staffContactDetails: StaffContactDetails.fromJson(json["staffContactDetails"]),
    staffEmploymentDetails: StaffEmploymentDetails.fromJson(json["staffEmploymentDetails"]),
    staffEmergencyContactDetails: List<StaffEmergencyContactDetail>.from(json["staffEmergencyContactDetails"].map((x) => StaffEmergencyContactDetail.fromJson(x))),
    staffScheduleDetails: StaffScheduleDetails.fromJson(json["staffScheduleDetails"]),
    staffQualifications: List<StaffQualification>.from(json["staffQualifications"].map((x) => StaffQualification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "staffPersonalDetails": staffPersonalDetails.toJson(),
    "staffContactDetails": staffContactDetails.toJson(),
    "staffEmploymentDetails": staffEmploymentDetails.toJson(),
    "staffEmergencyContactDetails": List<dynamic>.from(staffEmergencyContactDetails.map((x) => x)),
    "staffScheduleDetails": staffScheduleDetails.toJson(),
    "staffQualifications": List<dynamic>.from(staffQualifications.map((x) => x.toJson())),
  };
}

class StaffContactDetails {
  StaffContactDetails({
    this.userId,
    required this.addressLine,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.emailId,
    required this.phoneNumber,
    required this.cityId,
    required this.stateId,
    required this.countryId,
    required this.phoneValidated,
  });

  dynamic userId;
  String addressLine;
  String city;
  String state;
  String country;
  String zipCode;
  String emailId;
  String phoneNumber;
  int cityId;
  int stateId;
  int countryId;
  bool phoneValidated;

  factory StaffContactDetails.fromJson(Map<String, dynamic> json) => StaffContactDetails(
    userId: json["userId"]??0,
    addressLine: json["addressLine"]??"",
    city: json["city"]??"",
    state: json["state"]??"",
    country: json["country"]??"",
    zipCode: json["zipCode"]??"",
    emailId: json["emailId"],
    phoneNumber: json["phoneNumber"],
    cityId: json["cityId"]??0,
    stateId: json["stateId"]??0,
    countryId: json["countryId"]??0,
    phoneValidated: json["phoneValidated"]??false,
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "addressLine": addressLine,
    "city": city,
    "state": state,
    "country": country,
    "zipCode": zipCode,
    "emailId": emailId,
    "phoneNumber": phoneNumber,
    "cityId": cityId,
    "stateId": stateId,
    "countryId": countryId,
    "phoneValidated": phoneValidated,
  };
}
class StaffEmergencyContactDetail {
  StaffEmergencyContactDetail({
    required this.emergencyContactId,
    required this.userId,
    required this.contactPersonFirstName,
    required this.contactPersonLastName,
    required this.emailId,
    required this.contactNumber,
  });

  int emergencyContactId;
  int userId;
  String contactPersonFirstName;
  String contactPersonLastName;
  String emailId;
  String contactNumber;

  factory StaffEmergencyContactDetail.fromJson(Map<String, dynamic> json) => StaffEmergencyContactDetail(
    emergencyContactId: json["emergencyContactId"],
    userId: json["userId"],
    contactPersonFirstName: json["contactPersonFirstName"],
    contactPersonLastName: json["contactPersonLastName"],
    emailId: json["emailId"],
    contactNumber: json["contactNumber"],
  );

  Map<String, dynamic> toJson() => {
    "emergencyContactId": emergencyContactId,
    "userId": userId,
    "contactPersonFirstName": contactPersonFirstName,
    "contactPersonLastName": contactPersonLastName,
    "emailId": emailId,
    "contactNumber": contactNumber,
  };
}

class StaffEmploymentDetails {
  StaffEmploymentDetails({
    required this.userId,
    required this.hireDate,
    required this.endDate,
    required this.status,
    required this.salaried,
    required this.pin,
    required this.roomDetails,
  });

  int userId;
  int hireDate;
  int endDate;
  bool status;
  bool salaried;
  String pin;
  List<ClassRoomDetail> roomDetails;

  factory StaffEmploymentDetails.fromJson(Map<String, dynamic> json) => StaffEmploymentDetails(
    userId: json["userId"],
    hireDate: int.parse((json["hireDate"]==""||json["hireDate"]==null?"0":json["hireDate"].toString()).toString()),
    endDate: json["endDate"]??0,
    status: json["status"],
    salaried: json["salaried"],
    pin: json["pin"],
    roomDetails: List<ClassRoomDetail>.from(json["roomDetails"].map((x) => ClassRoomDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "hireDate": hireDate,
    "endDate": endDate,
    "status": status,
    "salaried": salaried,
    "pin": pin,
    "roomDetails": List<dynamic>.from(roomDetails.map((x) => x.toJson())),
  };
}

class ClassRoomDetail {
  ClassRoomDetail({
    required this.roomName,
    required this.roomId,
  });

  String roomName;
  int roomId;

  factory ClassRoomDetail.fromJson(Map<String, dynamic> json) => ClassRoomDetail(
    roomName: json["RoomName"],
    roomId: json["RoomId"],
  );

  Map<String, dynamic> toJson() => {
    "RoomName": roomName,
    "RoomId": roomId,
  };
}

class StaffPersonalDetails {
  StaffPersonalDetails({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.staffBio,
    this.positionDetails,
    required this.profilePic,
    required this.userStatus,
    required this.languageList,
  });

  int userId;
  String firstName;
  String lastName;
  String birthDate;
  String staffBio;
  dynamic positionDetails;
  String profilePic;
  bool userStatus;
  List<LanguageList> languageList;

  factory StaffPersonalDetails.fromJson(Map<String, dynamic> json) => StaffPersonalDetails(
    userId: json["userId"]??0,
    firstName: json["firstName"],
    lastName: json["lastName"],
    birthDate: json["birthDate"],
    staffBio: json["staffBio"]??"",
    positionDetails: json["positionDetails"],
    profilePic: json["profilePic"]??"",
    userStatus: json["userStatus"],
    languageList:List<LanguageList>.from(json["languageList"].map((x) => LanguageList.fromJson(x)))??[],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "firstName": firstName,
    "lastName": lastName,
    "birthDate": birthDate,
    "staffBio": staffBio,
    "positionDetails": positionDetails,
    "profilePic": profilePic,
    "userStatus": userStatus,
    "languageList": languageList,
  };
}
class LanguageList {
  LanguageList({
    required this.languageId,
    required this.languageName,
  });

  int languageId;
  String languageName;

  factory LanguageList.fromJson(Map<String, dynamic> json) => LanguageList(
    languageId: json["languageId"],
    languageName: json["languageName"],
  );

  Map<String, dynamic> toJson() => {
    "languageId": languageId,
    "languageName": languageName,
  };
}
class StaffQualification {
  StaffQualification({
    required this.qualificationId,
    required this.qualificationName,
    required this.completionDate,
    required this.expirationDate,
    required this.expirationNa,
    this.document,
    required this.certificateExpired,
  });

  int qualificationId;
  String qualificationName;
  int completionDate;
  int expirationDate;
  bool expirationNa;
  dynamic document;
  bool certificateExpired;

  factory StaffQualification.fromJson(Map<String, dynamic> json) => StaffQualification(
    qualificationId: json["qualificationId"],
    qualificationName: json["qualificationName"],
    completionDate: json["completionDate"],
    expirationDate: json["expirationDate"],
    expirationNa: json["expirationNA"],
    document: json["document"],
    certificateExpired: json["certificateExpired"],
  );

  Map<String, dynamic> toJson() => {
    "qualificationId": qualificationId,
    "qualificationName": qualificationName,
    "completionDate": completionDate,
    "expirationDate": expirationDate,
    "expirationNA": expirationNa,
    "document": document,
    "certificateExpired": certificateExpired,
  };
}

class StaffScheduleDetails {
  StaffScheduleDetails({
    required this.studentScheduleDetails,
    required this.studentScheduledDays,
  });

  List<dynamic> studentScheduleDetails;
  List<dynamic> studentScheduledDays;

  factory StaffScheduleDetails.fromJson(Map<String, dynamic> json) => StaffScheduleDetails(
    studentScheduleDetails: List<dynamic>.from(json["studentScheduleDetails"].map((x) => x)),
    studentScheduledDays: List<dynamic>.from(json["studentScheduledDays"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "studentScheduleDetails": List<dynamic>.from(studentScheduleDetails.map((x) => x)),
    "studentScheduledDays": List<dynamic>.from(studentScheduledDays.map((x) => x)),
  };
}

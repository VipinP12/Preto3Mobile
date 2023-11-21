// To parse this JSON data, do
//
//     final studentProfileModelDart = studentProfileModelDartFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

StudentProfileModelDart studentProfileModelDartFromJson(String str) =>
    StudentProfileModelDart.fromJson(json.decode(str));

String studentProfileModelDartToJson(StudentProfileModelDart? data) =>
    json.encode(data!.toJson());

class StudentProfileModelDart {
  StudentProfileModelDart({
    required this.studentPersonalDetails,
    required this.studentEnrollmentDetails,
    required this.inActiveDate,
    required this.inActiveReason,
    required this.notes,
    required this.parents,
    required this.emergencyContacts,
    required this.scheduleDetails,
    this.studentFeePlanDetails,
    required this.fines,
    required this.invoices,
  });

  StudentPersonalDetails studentPersonalDetails;
  StudentEnrollmentDetails studentEnrollmentDetails;
  String? inActiveDate;
  String? inActiveReason;
  List<Note> notes;
  List<Parent> parents;
  List<EmergencyContact> emergencyContacts;
  ScheduleDetails? scheduleDetails;
  StudentFeePlanDetails? studentFeePlanDetails;
  List<Fine> fines;
  Invoices? invoices;

  factory StudentProfileModelDart.fromJson(Map<String, dynamic> json) =>
      StudentProfileModelDart(
        studentPersonalDetails:
            StudentPersonalDetails.fromJson(json["studentPersonalDetails"]),
        studentEnrollmentDetails:
            StudentEnrollmentDetails.fromJson(json["studentEnrollmentDetails"]),
        inActiveDate: json["inActiveDate"],
        inActiveReason: json["inActiveReason"],
        notes: json["notes"] == null
            ? []
            : List<Note>.from(json["notes"].map((x) => Note.fromJson(x))),
        parents: json["parents"] == null
            ? []
            : List<Parent>.from(json["parents"].map((x) => Parent.fromJson(x))),
        emergencyContacts: json["emergencyContacts"] == null
            ? []
            : List<EmergencyContact>.from(json["emergencyContacts"]
                .map((x) => EmergencyContact.fromJson(x))),
        scheduleDetails: ScheduleDetails.fromJson(json["scheduleDetails"]),
        studentFeePlanDetails: json["studentFeePlanDetails"] != null
            ? StudentFeePlanDetails.fromJson(json["studentFeePlanDetails"])
            : null,
        fines: json["fineData"] == null
            ? []
            : List<Fine>.from(json["fines"].map((x) => Fine.fromJson(x))),
        invoices: Invoices.fromJson(json["invoices"]),
      );

  Map<String, dynamic> toJson() => {
        "studentPersonalDetails": studentPersonalDetails.toJson(),
        "studentEnrollmentDetails": studentEnrollmentDetails.toJson(),
        "inActiveDate": inActiveDate,
        "inActiveReason": inActiveReason,
        "notes": notes == null
            ? []
            : List<dynamic>.from(notes.map((x) => x.toJson())),
        "parents": parents == null
            ? []
            : List<dynamic>.from(parents.map((x) => x.toJson())),
        "emergencyContacts": emergencyContacts == null
            ? []
            : List<dynamic>.from(emergencyContacts.map((x) => x.toJson())),
        "scheduleDetails": scheduleDetails!.toJson(),
        "studentFeePlanDetails": studentFeePlanDetails!.toJson(),
        "fineData": fines == null
            ? []
            : List<dynamic>.from(fines.map((x) => x.toJson())),
        "invoices": invoices!.toJson(),
      };
}

class EmergencyContact {
  EmergencyContact({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contactPhone,
    required this.phoneValidate,
  });

  int userId;
  String firstName;
  String lastName;
  String email;
  String contactPhone;
  bool phoneValidate;

  factory EmergencyContact.fromJson(Map<String, dynamic> json) =>
      EmergencyContact(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        contactPhone: json["contactPhone"],
        phoneValidate: json["phoneValidate"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "contactPhone": contactPhone,
        "phoneValidate": phoneValidate,
      };
}

class Fine {
  Fine({
    required this.fineMasterId,
    required this.fineDescription,
    required this.unit,
    required this.totalFine,
  });

  int fineMasterId;
  String fineDescription;
  String unit;
  int totalFine;

  factory Fine.fromJson(Map<String, dynamic> json) => Fine(
        fineMasterId: json["fineMasterId"],
        fineDescription: json["fineDescription"],
        unit: json["unit"],
        totalFine: json["totalFine"],
      );

  Map<String, dynamic> toJson() => {
        "fineMasterId": fineMasterId,
        "fineDescription": fineDescription,
        "unit": unit,
        "totalFine": totalFine,
      };
}

class Invoices {
  Invoices({
    required this.unpaidInvoices,
    required this.totalDue,
    required this.paidInvoices,
    required this.totalPaid,
  });

  List<dynamic>? unpaidInvoices;
  double? totalDue;
  List<dynamic>? paidInvoices;
  double? totalPaid;

  factory Invoices.fromJson(Map<String, dynamic> json) => Invoices(
        unpaidInvoices: json["unpaidInvoices"] == null
            ? []
            : List<dynamic>.from(json["unpaidInvoices"]!.map((x) => x)),
        totalDue: json["totalDue"],
        paidInvoices: json["paidInvoices"] == null
            ? []
            : List<dynamic>.from(json["paidInvoices"]!.map((x) => x)),
        totalPaid: json["totalPaid"],
      );

  Map<String, dynamic> toJson() => {
        "unpaidInvoices": unpaidInvoices == null
            ? []
            : List<dynamic>.from(unpaidInvoices!.map((x) => x)),
        "totalDue": totalDue,
        "paidInvoices": paidInvoices == null
            ? []
            : List<dynamic>.from(paidInvoices!.map((x) => x)),
        "totalPaid": totalPaid,
      };
}

class Note {
  Note({
    required this.notesId,
    required this.notesDescription,
    required this.creator,
    required this.createdOn,
    required this.noteTitle,
  });

  int notesId;
  String notesDescription;
  String creator;
  String createdOn;
  String noteTitle;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        notesId: json["notesId"],
        notesDescription: json["notesDescription"],
        creator: json["creator"],
        createdOn: json["createdOn"],
        noteTitle: json["noteTitle"],
      );

  Map<String, dynamic> toJson() => {
        "notesId": notesId,
        "notesDescription": notesDescription,
        "creator": creator,
        "createdOn": createdOn,
        "noteTitle": noteTitle,
      };
}

class Parent {
  Parent({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.emailId,
    required this.phoneNumber,
    required this.regEmailSent,
    this.studentContactDetails,
    required this.userRegistered,
    required this.phoneValidated,
  });

  int userId;
  String firstName;
  String lastName;
  String emailId;
  String phoneNumber;
  bool regEmailSent;
  dynamic studentContactDetails;
  bool userRegistered;
  bool phoneValidated;

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        emailId: json["emailId"],
        phoneNumber: json["phoneNumber"],
        regEmailSent: json["regEmailSent"],
        studentContactDetails: json["studentContactDetails"],
        userRegistered: json["userRegistered"],
        phoneValidated: json["phoneValidated"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "emailId": emailId,
        "phoneNumber": phoneNumber,
        "regEmailSent": regEmailSent,
        "studentContactDetails": studentContactDetails,
        "userRegistered": userRegistered,
        "phoneValidated": phoneValidated,
      };
}

class ScheduleDetails {
  ScheduleDetails({
    required this.studentScheduleDetails,
    required this.studentScheduledDays,
  });

  List<dynamic>? studentScheduleDetails;
  List<dynamic>? studentScheduledDays;

  factory ScheduleDetails.fromJson(Map<String, dynamic> json) =>
      ScheduleDetails(
        studentScheduleDetails: json["studentScheduleDetails"] == null
            ? []
            : List<dynamic>.from(json["studentScheduleDetails"]!.map((x) => x)),
        studentScheduledDays: json["studentScheduledDays"] == null
            ? []
            : List<dynamic>.from(json["studentScheduledDays"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "studentScheduleDetails": studentScheduleDetails == null
            ? []
            : List<dynamic>.from(studentScheduleDetails!.map((x) => x)),
        "studentScheduledDays": studentScheduledDays == null
            ? []
            : List<dynamic>.from(studentScheduledDays!.map((x) => x)),
      };
}

class StudentEnrollmentDetails {
  StudentEnrollmentDetails({
    required this.programName,
    required this.enrollmentType,
    required this.enrollmentDate,
    required this.className,
    required this.scheduledStartTime,
    required this.scheduledEndTime,
    required this.status,
    required this.reEnrollmentDate,
    required this.reEnrollmentReason,
  });

  String? programName;
  String? enrollmentType;
  String? enrollmentDate;
  dynamic className;
  String? scheduledStartTime;
  String? scheduledEndTime;
  bool? status;
  dynamic reEnrollmentDate;
  dynamic reEnrollmentReason;

  factory StudentEnrollmentDetails.fromJson(Map<String, dynamic> json) =>
      StudentEnrollmentDetails(
        programName: json["programName"],
        enrollmentType: json["enrollmentType"],
        enrollmentDate: json["enrollmentDate"],
        className: json["className"],
        scheduledStartTime: json["scheduledStartTime"],
        scheduledEndTime: json["scheduledEndTime"],
        status: json["status"],
        reEnrollmentDate: json["reEnrollmentDate"],
        reEnrollmentReason: json["reEnrollmentReason"],
      );

  Map<String, dynamic> toJson() => {
        "programName": programName,
        "enrollmentType": enrollmentType,
        "enrollmentDate": enrollmentDate,
        "className": className,
        "scheduledStartTime": scheduledStartTime,
        "scheduledEndTime": scheduledEndTime,
        "status": status,
        "reEnrollmentDate": reEnrollmentDate,
        "reEnrollmentReason": reEnrollmentReason,
      };
}

class StudentFeePlanDetails {
  StudentFeePlanDetails({
    required this.planName,
    required this.feePlanDays,
    required this.paymentFrequency,
    required this.chargeTypes,
  });

  String? planName;
  String? feePlanDays;
  String? paymentFrequency;
  ChargeTypes? chargeTypes;

  factory StudentFeePlanDetails.fromJson(Map<String, dynamic> json) =>
      StudentFeePlanDetails(
        planName: json["planName"],
        feePlanDays: json["feePlanDays"],
        paymentFrequency: json["paymentFrequency"],
        chargeTypes: ChargeTypes.fromJson(json["chargeTypes"]),
      );

  Map<String, dynamic> toJson() => {
        "planName": planName,
        "feePlanDays": feePlanDays,
        "paymentFrequency": paymentFrequency,
        "chargeTypes": chargeTypes!.toJson(),
      };
}

class ChargeTypes {
  ChargeTypes({
    required this.tuitionFee,
    required this.enrollmentFee,
    required this.totalFee,
  });

  double? tuitionFee;
  double? enrollmentFee;
  double? totalFee;

  factory ChargeTypes.fromJson(Map<String, dynamic> json) => ChargeTypes(
        tuitionFee: json["Tuition Fee"],
        enrollmentFee: json["Enrollment Fee"],
        totalFee: json["Total Fee"],
      );

  Map<String, dynamic> toJson() => {
        "Tuition Fee": tuitionFee,
        "Enrollment Fee": enrollmentFee,
        "Total Fee": totalFee,
      };
}

class StudentPersonalDetails {
  StudentPersonalDetails({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.race,
    required this.raceId,
    required this.ethnicity,
    required this.ethnicityId,
    required this.doctorName,
    required this.profilePic,
    required this.studentId,
    required this.allergies,
    required this.medications,
    required this.birthDay,
    required this.doctorPhone,
  });

  String firstName;
  String lastName;
  String age;
  String gender;
  dynamic race;
  dynamic raceId;
  dynamic ethnicity;
  dynamic ethnicityId;
  dynamic doctorName;
  dynamic profilePic;
  int studentId;
  dynamic allergies;
  dynamic medications;
  String? birthDay;
  dynamic doctorPhone;

  factory StudentPersonalDetails.fromJson(Map<String, dynamic> json) =>
      StudentPersonalDetails(
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        age: json["age"] ?? "",
        gender: json["gender"] ?? "",
        race: json["race"],
        raceId: json["raceId"],
        ethnicity: json["ethnicity"],
        ethnicityId: json["ethnicityId"],
        doctorName: json["doctorName"] ?? "",
        profilePic: json["profilePic"] ?? "",
        studentId: json["studentId"],
        allergies: json["allergies"] ?? "",
        medications: json["medications"] ?? "",
        birthDay: json["birthDay"] ?? "",
        doctorPhone: json["doctorPhone"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "age": age,
        "gender": gender,
        "race": race,
        "raceId": raceId,
        "ethnicity": ethnicity,
        "ethnicityId": ethnicityId,
        "doctorName": doctorName,
        "profilePic": profilePic,
        "studentId": studentId,
        "allergies": allergies,
        "medications": medications,
        "birthDay": birthDay,
        "doctorPhone": doctorPhone,
      };
}

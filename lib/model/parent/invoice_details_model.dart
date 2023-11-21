// To parse this JSON data, do
//
//     final invoiceDetailsModel = invoiceDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

InvoiceDetailsModel invoiceDetailsModelFromJson(String str) =>
    InvoiceDetailsModel.fromJson(json.decode(str));

String invoiceDetailsModelToJson(InvoiceDetailsModel data) =>
    json.encode(data.toJson());

class InvoiceDetailsModel {
  InvoiceDetailsModel({
    required this.invoiceNumber,
    required this.dueDate,
    required this.issueDate,
    required this.serviceStartDate,
    required this.serviceEndDate,
    required this.balanceAmount,
    required this.totalAmount,
    required this.schoolName,
    required this.schoolAddress,
    required this.parents,
    required this.studentFirstName,
    required this.studentLastName,
    required this.lineItems,
    required this.einNumber,
    this.feePlanId,
  });

  String invoiceNumber;
  String dueDate;
  String issueDate;
  String serviceStartDate;
  String serviceEndDate;
  double balanceAmount;
  double totalAmount;
  String schoolName;
  String schoolAddress;
  List<Parent> parents;

  String studentFirstName;
  String studentLastName;
  String einNumber;
  List<LineItem> lineItems;
  dynamic feePlanId;

  factory InvoiceDetailsModel.fromJson(Map<String, dynamic> json) =>
      InvoiceDetailsModel(
          invoiceNumber: json["invoiceNumber"],
          dueDate: json["dueDate"] == null
              ? "-"
              : DateFormat('MM/dd/yyyy')
                  .format(DateTime.fromMillisecondsSinceEpoch(json["dueDate"]))
                  .toString(),
          issueDate: json["issueDate"] == null
              ? "-"
              : DateFormat('MM/dd/yyyy')
                  .format(
                      DateTime.fromMillisecondsSinceEpoch(json["issueDate"]))
                  .toString(),
          serviceStartDate: json["serviceStartDate"] == null
              ? "-"
              : DateFormat('MM/dd/yyyy')
                  .format(DateTime.fromMillisecondsSinceEpoch(
                      json["serviceStartDate"]))
                  .toString(),
          serviceEndDate: json["serviceEndDate"] == null
              ? "-"
              : DateFormat('MM/dd/yyyy')
                  .format(DateTime.fromMillisecondsSinceEpoch(
                      json["serviceEndDate"]))
                  .toString(),
          balanceAmount:
              double.parse((json["balanceAmount"] ?? "0.00").toString()),
          totalAmount: double.parse((json["totalAmount"] ?? "0.00").toString()),
          schoolName: json["schoolName"] ?? "",
          schoolAddress: json["schoolAddress"] ?? "",
          parents:
              List<Parent>.from(json["parents"].map((x) => Parent.fromJson(x))),
          studentFirstName: json["studentFirstName"] ?? "",
          studentLastName: json["studentLastName"] ?? "",
          lineItems: List<LineItem>.from(
              json["lineItems"].map((x) => LineItem.fromJson(x))),
          feePlanId: json["feePlanId"],
          einNumber: json["einNumber"] ?? "");

  Map<String, dynamic> toJson() => {
        "invoiceNumber": invoiceNumber,
        "dueDate": dueDate,
        "issueDate": issueDate,
        "serviceStartDate": serviceStartDate,
        "serviceEndDate": serviceEndDate,
        "balanceAmount": balanceAmount,
        "totalAmount": totalAmount,
        "schoolName": schoolName,
        "schoolAddress": schoolAddress,
        "parents": List<dynamic>.from(parents.map((x) => x.toJson())),
        "studentFirstName": studentFirstName,
        "studentLastName": studentLastName,
        "lineItems": List<dynamic>.from(lineItems.map((x) => x.toJson())),
        "feePlanId": feePlanId,
        "einNumber": einNumber
      };
}

class LineItem {
  LineItem({
    required this.lineItemDesc,
    required this.total,
    required this.lineItemName,
    this.transactionType,
  });

  String lineItemDesc;
  double total;
  String lineItemName;
  dynamic transactionType;

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
        lineItemDesc: json["lineItemDesc"] ?? "",
        total: double.parse((json["total"] ?? "0.00").toString()),
        lineItemName: json["lineItemName"] ?? "",
        transactionType: json["transactionType"],
      );

  Map<String, dynamic> toJson() => {
        "lineItemDesc": lineItemDesc,
        "total": total,
        "lineItemName": lineItemName,
        "transactionType": transactionType,
      };
}

class Parent {
  Parent({
    required this.emailid,
    required this.lastname,
    required this.firstname,
  });

  String emailid;
  String lastname;
  String firstname;

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        emailid: json["emailid"] ?? "",
        lastname: json["lastname"] ?? "",
        firstname: json["firstname"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "emailid": emailid,
        "lastname": lastname,
        "firstname": firstname,
      };
}

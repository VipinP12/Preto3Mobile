// To parse this JSON data, do
//
//     final childernFeesInvoiceModel = childernFeesInvoiceModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

ChildernFeesInvoiceModel childernFeesInvoiceModelFromJson(String str) =>
    ChildernFeesInvoiceModel.fromJson(json.decode(str));

String childernFeesInvoiceModelToJson(ChildernFeesInvoiceModel data) =>
    json.encode(data.toJson());

class ChildernFeesInvoiceModel {
  ChildernFeesInvoiceModel({
    required this.totalBalanceDues,
    required this.upcomingDues,
    required this.pastDues,
    required this.totalpaid,
    required this.allChildren,
    required this.invoices,
  });

  double totalBalanceDues;
  double upcomingDues;
  double pastDues;
  double totalpaid;
  List<AllChild> allChildren;
  List<Invoice> invoices;

  factory ChildernFeesInvoiceModel.fromJson(Map<String, dynamic> json) =>
      ChildernFeesInvoiceModel(
        totalBalanceDues:
            double.parse((json["totalBalanceDues"] ?? "0.00").toString()),
        upcomingDues: double.parse((json["upcomingDues"] ?? "0.00").toString()),
        pastDues: double.parse((json["pastDues"] ?? "0.00").toString()),
        totalpaid: double.parse((json["totalpaid"] ?? "0.00").toString()),
        allChildren: List<AllChild>.from(
            json["allChildren"].map((x) => AllChild.fromJson(x))),
        invoices: List<Invoice>.from(
            json["invoices"].map((x) => Invoice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalBalanceDues": totalBalanceDues,
        "upcomingDues": upcomingDues,
        "pastDues": pastDues,
        "totalpaid": totalpaid,
        "allChildren": List<dynamic>.from(allChildren.map((x) => x.toJson())),
        "invoices": List<dynamic>.from(invoices.map((x) => x.toJson())),
      };
}

class AllChild {
  AllChild({
    required this.studentName,
    required this.imageUrl,
    required this.id,
  });

  String studentName;
  String imageUrl;
  int id;

  factory AllChild.fromJson(Map<String, dynamic> json) => AllChild(
        studentName: json["studentName"],
        imageUrl: json["imageUrl"] ?? "-",
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "studentName": studentName,
        "imageUrl": imageUrl,
        "id": id,
      };
}

class Invoice {
  Invoice({
    required this.invoiceNumber,
    required this.invoiceAmount,
    required this.dueDate,
    required this.paidAmount,
    required this.paymentDate,
    required this.balanceDue,
    required this.status,
    required this.invoiceId,
    required this.dueInDays,
    required this.isRecurring,
    required this.isAutoPay,
    required this.isPartial,
  });

  String invoiceNumber;
  double invoiceAmount;
  int dueDate;
  double paidAmount;
  int paymentDate;
  double balanceDue;
  String status;
  int invoiceId;
  String dueInDays;
  bool isRecurring;
  bool isAutoPay;
  bool isPartial;

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
      invoiceNumber: json["invoiceNumber"],
      invoiceAmount: double.parse((json["invoiceAmount"] ?? "0.00").toString()),
      dueDate: json["dueDate"] ?? 0,
      paidAmount: double.parse((json["paidAmount"] ?? "0.00").toString()),
      paymentDate: json["paymentDate"] ?? 0,
      balanceDue: double.parse((json["balanceDue"] ?? "0.00").toString()),
      status: json["status"],
      invoiceId: json["invoiceId"],
      dueInDays: json["dueInDays"] ?? "",
      isRecurring: json["isRecurring"] ?? false,
      isAutoPay: json["isAutoPay"] ?? false,
      isPartial: json["isPartial"] ?? false);

  Map<String, dynamic> toJson() => {
        "invoiceNumber": invoiceNumber,
        "invoiceAmount": invoiceAmount,
        "dueDate": dueDate,
        "paidAmount": paidAmount,
        "paymentDate": paymentDate,
        "balanceDue": balanceDue,
        "status": status,
        "invoiceId": invoiceId,
        "dueInDays": dueInDays,
        "isRecurring": isRecurring,
        "isAutoPay": isAutoPay,
        "isPartial": isPartial,
      };
}

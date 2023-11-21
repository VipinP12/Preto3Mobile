// To parse this JSON data, do
//
//     final qrCodeCode = qrCodeCodeFromJson(jsonString);

import 'dart:convert';

QrCodeCode qrCodeCodeFromJson(String str) => QrCodeCode.fromJson(json.decode(str));

String qrCodeCodeToJson(QrCodeCode data) => json.encode(data.toJson());

class QrCodeCode {
  QrCodeCode({
    required this.schoolName,
    required this.qrCode,
  });

  String schoolName;
  String qrCode;

  factory QrCodeCode.fromJson(Map<String, dynamic> json) => QrCodeCode(
    schoolName: json["schoolName"]??"",
    qrCode: json["qrCode"]??"",
  );

  Map<String, dynamic> toJson() => {
    "schoolName": schoolName,
    "qrCode": qrCode,
  };
}

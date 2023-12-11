// To parse this JSON data, do
//
//     final qrCodeModule = qrCodeModuleFromJson(jsonString);

import 'dart:convert';

QrCodeModule qrCodeModuleFromJson(String str) => QrCodeModule.fromJson(json.decode(str));

String qrCodeModuleToJson(QrCodeModule data) => json.encode(data.toJson());

class QrCodeModule {
  String schoolName;
  String qrCode;

  QrCodeModule({
    required this.schoolName,
    required this.qrCode,
  });

  factory QrCodeModule.fromJson(Map<String, dynamic> json) => QrCodeModule(
    schoolName: json["schoolName"],
    qrCode: json["qrCode"],
  );

  Map<String, dynamic> toJson() => {
    "schoolName": schoolName,
    "qrCode": qrCode,
  };
}

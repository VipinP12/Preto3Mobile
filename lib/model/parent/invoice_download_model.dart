// To parse this JSON data, do
//
//     final invoiceDownloadModel = invoiceDownloadModelFromJson(jsonString);

import 'dart:convert';

InvoiceDownloadModel invoiceDownloadModelFromJson(String str) =>
    InvoiceDownloadModel.fromJson(json.decode(str));

String invoiceDownloadModelToJson(InvoiceDownloadModel data) =>
    json.encode(data.toJson());

class InvoiceDownloadModel {
  InvoiceDownloadModel({
    this.fileName,
    required this.fileDownloadUri,
    required this.fileType,
    required this.size,
  });

  dynamic fileName;
  String fileDownloadUri;
  String fileType;
  int size;

  factory InvoiceDownloadModel.fromJson(Map<String, dynamic> json) =>
      InvoiceDownloadModel(
        fileName: json["fileName"] ?? "",
        fileDownloadUri: json["fileDownloadUri"] ?? "",
        fileType: json["fileType"] ?? "",
        size: json["size"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "fileDownloadUri": fileDownloadUri,
        "fileType": fileType,
        "size": size,
      };
}

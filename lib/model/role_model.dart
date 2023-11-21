// To parse this JSON data, do
//
//     final roleModel = roleModelFromJson(jsonString);

import 'dart:convert';

List<RoleModel?>? roleModelFromJson(String str) => json.decode(str) == null
    ? []
    : List<RoleModel?>.from(
        json.decode(str)!.map((x) => RoleModel.fromJson(x)));

String roleModelToJson(List<RoleModel?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class RoleModel {
  RoleModel({
    required this.schoolId,
    required this.schoolName,
    this.roleId,
    this.roleName,
    this.schoolLogo,
    required this.qrCode,
  });

  int? schoolId;
  String? schoolName;
  int? roleId;
  String? roleName;
  String? schoolLogo;
  String qrCode;

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        schoolId: json["schoolId"],
        schoolName: json["schoolName"],
        roleId: json["roleId"],
        roleName: json["roleName"],
        schoolLogo: json["schoolLogo"],
        qrCode: json["qrCode"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "schoolId": schoolId,
        "schoolName": schoolName,
        "roleId": roleId,
        "roleName": roleName,
        "schoolLogo": schoolLogo,
        "qrCode": qrCode,
      };
}

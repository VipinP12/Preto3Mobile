import 'dart:convert';

LoginModel? loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel? data) => json.encode(data!.toJson());

class LoginModel {
  LoginModel({
    required this.id,
    required this.email,
    required this.mobileNumber,
    required this.firstName,
    required this.lastName,
    required this.profilePic,
    required this.schoolLogo,
    required this.qrCode,
    required this.roles,
    required this.userName,
    required this.emailVerified,
    required this.dateOfBirth,
  });

  int? id;
  String? email;
  String? mobileNumber;
  String? firstName;
  String? lastName;
  String? profilePic;
  dynamic schoolLogo;
  dynamic qrCode;
  List<Role?>? roles;
  String? userName;
  bool? emailVerified;
  dynamic dateOfBirth;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        id: json["id"],
        email: json["email"],
        mobileNumber: json["mobileNumber"] ?? "",
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilePic: json["profilePic"],
        schoolLogo: json["schoolLogo"] ?? "",
        qrCode: json["qrCode"] ?? "",
        roles: json["roles"] == null
            ? []
            : List<Role?>.from(json["roles"]!.map((x) => Role.fromJson(x))),
        userName: json["userName"] ?? "",
        emailVerified: json["emailVerified"],
        dateOfBirth: json["dateOfBirth"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "mobileNumber": mobileNumber,
        "firstName": firstName,
        "lastName": lastName,
        "profilePic": profilePic,
        "schoolLogo": schoolLogo,
        "qrCode": qrCode,
        "roles": roles == null
            ? []
            : List<dynamic>.from(roles!.map((x) => x!.toJson())),
        "userName": userName ?? "",
        "emailVerified": emailVerified,
        "dateOfBirth": dateOfBirth,
      };
}

class Role {
  Role({
    required this.schoolId,
    required this.schoolName,
    required this.roleId,
    required this.roleName,
    this.schoolLogo,
    required this.qrCode,
  });

  int? schoolId;
  String? schoolName;
  int? roleId;
  String? roleName;
  String? schoolLogo;
  String qrCode;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
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

// To parse this JSON data, do
//
//     final relationshipModel = relationshipModelFromJson(jsonString);

import 'dart:convert';

RelationshipModel relationshipModelFromJson(String str) => RelationshipModel.fromJson(json.decode(str));

String relationshipModelToJson(RelationshipModel data) => json.encode(data.toJson());

class RelationshipModel {
  RelationshipModel({
    required this.parent,
    required this.emergencyContact,
  });

  dynamic parent;
  List<Parent> emergencyContact;

  factory RelationshipModel.fromJson(Map<String, dynamic> json) => RelationshipModel(
    parent: json["parent"]!=null?Parent.fromJson(json["parent"]):null,
    emergencyContact: List<Parent>.from(json["emergencyContact"].map((x) => Parent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "parent": parent.toJson(),
    "emergencyContact": List<dynamic>.from(emergencyContact.map((x) => x.toJson())),
  };
}

class Parent {
  Parent({
    required this.name,
    required this.email,
    this.phoneNumber,
    this.profilePic,
    required this.userName,
  });

  String name;
  String email;
  String? phoneNumber;
  dynamic profilePic;
  String userName;

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phoneNumber"]??"",
    profilePic: json["profilePic"]??"",
    userName: json["userName"]??"",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phoneNumber": phoneNumber,
    "profilePic": profilePic,
    "userName": userName,
  };
}

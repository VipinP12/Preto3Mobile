import 'dart:convert';

List<BirthdayModel?>? birthdayModelFromJson(String str) => json.decode(str) == null ? [] : List<BirthdayModel?>.from(json.decode(str)!.map((x) => BirthdayModel.fromJson(x)));

String birthdayModelToJson(List<BirthdayModel?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class BirthdayModel {
  BirthdayModel({
    required this.name,
    required this.profilePic,
    required this.age,
    required this.dob,
  });

  String? name;
  dynamic profilePic;
  int? age;
  String? dob;

  factory BirthdayModel.fromJson(Map<String, dynamic> json) => BirthdayModel(
    name: json["name"],
    profilePic: json["profilePic"]??"",
    age: json["age"],
    dob: json["dob"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "profilePic": profilePic,
    "age": age,
    "dob": dob,
  };
}

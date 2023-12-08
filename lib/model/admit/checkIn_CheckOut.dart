// To parse this JSON data, do
//
//     final checkInCheckOutStaff = checkInCheckOutStaffFromJson(jsonString);

import 'dart:convert';

List<CheckInCheckOutStaff> checkInCheckOutStaffFromJson(String str) => List<CheckInCheckOutStaff>.from(json.decode(str).map((x) => CheckInCheckOutStaff.fromJson(x)));

String checkInCheckOutStaffToJson(List<CheckInCheckOutStaff> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CheckInCheckOutStaff {
  int id;
  String firstName;
  String lastName;
  Status status;
  List<String> rooms;
  String? profilePic;
  bool isSelectedStaff;
  List<StaffCheckInOutModel> staffCheckInOutModel;

  CheckInCheckOutStaff({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.status,
    required this.rooms,
    required this.profilePic,
    required this.isSelectedStaff,
    required this.staffCheckInOutModel,
  });

  factory CheckInCheckOutStaff.fromJson(Map<String, dynamic> json) => CheckInCheckOutStaff(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    status: statusValues.map[json["status"]]!,
    rooms: List<String>.from(json["rooms"].map((x) => x)),
    profilePic: json["profilePic"],
    isSelectedStaff: false,
    staffCheckInOutModel: List<StaffCheckInOutModel>.from(json["staffCheckInOutModel"].map((x) => StaffCheckInOutModel.fromJson(x))),
  );



  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "status": statusValues.reverse[status],
    "rooms": List<dynamic>.from(rooms.map((x) => x)),
    "profilePic": profilePic,
    "staffCheckInOutModel": List<dynamic>.from(staffCheckInOutModel.map((x) => x.toJson())),
  };
}

class StaffCheckInOutModel {
  int checkInTime;
  int checkOutTime;
  Duration duration;
  int durationInMin;
  dynamic remarks;
  int checkInOutActivityId;
  int staffCheckInOutId;

  StaffCheckInOutModel({
    required this.checkInTime,
    required this.checkOutTime,
    required this.duration,
    required this.durationInMin,
    required this.remarks,
    required this.checkInOutActivityId,
    required this.staffCheckInOutId,
  });

  factory StaffCheckInOutModel.fromJson(Map<String, dynamic> json) => StaffCheckInOutModel(
    checkInTime: json["checkInTime"],
    checkOutTime: json["checkOutTime"],
    duration: durationValues.map[json["duration"]]!,
    durationInMin: json["durationInMin"],
    remarks: json["remarks"],
    checkInOutActivityId: json["checkInOutActivityId"],
    staffCheckInOutId: json["staffCheckInOutId"],
  );

  Map<String, dynamic> toJson() => {
    "checkInTime": checkInTime,
    "checkOutTime": checkOutTime,
    "duration": durationValues.reverse[duration],
    "durationInMin": durationInMin,
    "remarks": remarks,
    "checkInOutActivityId": checkInOutActivityId,
    "staffCheckInOutId": staffCheckInOutId,
  };
}

enum Duration {
  THE_00_H_00_M
}

final durationValues = EnumValues({
  "00h:00m": Duration.THE_00_H_00_M
});

enum Status {
  CHECKED_IN
}

final statusValues = EnumValues({
  "Checked In": Status.CHECKED_IN
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

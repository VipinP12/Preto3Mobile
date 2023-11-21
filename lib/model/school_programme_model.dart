import 'dart:convert';

List<SchoolProgrammeModelDart?>? schoolProgrammeModelDartFromJson(String str) => json.decode(str) == null ? [] : List<SchoolProgrammeModelDart?>.from(json.decode(str)!.map((x) => SchoolProgrammeModelDart.fromJson(x)));

String schoolProgrammeModelDartToJson(List<SchoolProgrammeModelDart?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class SchoolProgrammeModelDart {
  SchoolProgrammeModelDart({
    required this.programId,
    required this.programName,
    required this.programDescription,
    required this.minAge,
    required this.maxAge,
    required this.enrollmentFee,
    required this.enrollmentCapacity,
    required this.programScheduleMapList,
  });

  int? programId;
  String? programName;
  String? programDescription;
  double? minAge;
  double? maxAge;
  String? enrollmentFee;
  String? enrollmentCapacity;
  List<ProgramScheduleMapList?>? programScheduleMapList;

  factory SchoolProgrammeModelDart.fromJson(Map<String, dynamic> json) => SchoolProgrammeModelDart(
    programId: json["programId"],
    programName: json["programName"],
    programDescription: json["programDescription"]??"",
    minAge: json["minAge"],
    maxAge: json["maxAge"],
    enrollmentFee: json["enrollmentFee"]??"",
    enrollmentCapacity: json["enrollmentCapacity"]??"",
    programScheduleMapList: json["programScheduleMapList"] == null ? [] : List<ProgramScheduleMapList?>.from(json["programScheduleMapList"]!.map((x) => ProgramScheduleMapList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "programId": programId,
    "programName": programName,
    "programDescription": programDescription,
    "minAge": minAge,
    "maxAge": maxAge,
    "enrollmentFee": enrollmentFee,
    "enrollmentCapacity": enrollmentCapacity,
    "programScheduleMapList": programScheduleMapList == null ? [] : List<dynamic>.from(programScheduleMapList!.map((x) => x!.toJson())),
  };
}

class ProgramScheduleMapList {
  ProgramScheduleMapList({
    required this.programScheduleMapId,
    required this.programDay,
    required this.programStartTime,
    required this.programEndTime,
    required this.programDaySelected,
    required this.daySequence,
  });

  int? programScheduleMapId;
  String? programDay;
  String? programStartTime;
  String? programEndTime;
  bool? programDaySelected;
  int? daySequence;

  factory ProgramScheduleMapList.fromJson(Map<String, dynamic> json) => ProgramScheduleMapList(
    programScheduleMapId: json["programScheduleMapId"],
    programDay: json["programDay"],
    programStartTime: json["programStartTime"],
    programEndTime: json["programEndTime"],
    programDaySelected: json["programDaySelected"],
    daySequence: json["daySequence"],
  );

  Map<String, dynamic> toJson() => {
    "programScheduleMapId": programScheduleMapId,
    "programDay": programDay,
    "programStartTime": programStartTime,
    "programEndTime": programEndTime,
    "programDaySelected": programDaySelected,
    "daySequence": daySequence,
  };
}

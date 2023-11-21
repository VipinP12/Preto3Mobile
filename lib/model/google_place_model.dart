// To parse this JSON data, do
//
//     final googlePlaceModel = googlePlaceModelFromJson(jsonString);

import 'dart:convert';

GooglePlaceModel googlePlaceModelFromJson(String str) => GooglePlaceModel.fromJson(json.decode(str));

String googlePlaceModelToJson(GooglePlaceModel data) => json.encode(data.toJson());

class GooglePlaceModel {
  GooglePlaceModel({
    required this.predictions,
    required this.status,
  });

  List<Prediction> predictions;
  String status;

  factory GooglePlaceModel.fromJson(Map<String, dynamic> json) => GooglePlaceModel(
    predictions: List<Prediction>.from(json["predictions"].map((x) => Prediction.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "predictions": List<dynamic>.from(predictions.map((x) => x.toJson())),
    "status": status,
  };
}

class Prediction {
  Prediction({
    required this.description,
    required this.placeId,
    required this.reference,
  });

  String description;
  String placeId;
  String reference;


  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
    description: json["description"],
    placeId: json["place_id"],
    reference: json["reference"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "place_id": placeId,
    "reference": reference,
  };
}


import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:preto3/controller/Parent/parent_dashboard_controller.dart';
import 'package:preto3/model/google_place_model.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:http/http.dart' as http;

class GooglePlacesController extends GetxController {
  Placemark pickPlaceMark = Placemark();
  Placemark get getPlaceMark => pickPlaceMark;

  var searchPlacesController = TextEditingController();
  final parentController = Get.find<ParentDashboardController>();
  var predictionList = <Prediction>[].obs;
  var placeName = "".obs;
  var state = "".obs;
  var city = "".obs;
  var postalCode = "".obs;
  var country = "".obs;
  @override
  void onInit() {
    var searchPlacesController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    searchPlacesController.dispose();
    super.dispose();
  }

  Future<List<Prediction>> searchPlaces(
      BuildContext context, String queryText) async {
    print("QUERY TEXT:$queryText");
    String type = 'address';
    if (queryText.isNotEmpty) {
      predictionList.clear();
      var response = await http.get(Uri.parse(
          '${ApiEndPoints.googlePlaceUrl}${ApiEndPoints.autoCompleteSearch}input=$queryText&types=$type&key=${ApiEndPoints.googleTimeZoneApiKey}'));
      print("RESPONSE:$response");
      var data = googlePlaceModelFromJson(response.body.toString());
      if (data.status == "OK") {
        print("STATUS ${data.status}");
        predictionList.value = data.predictions;

        update();
      }
    }
    return predictionList;
  }

  void getLatLon(String selectedAddress) async {
    placeName.value = selectedAddress;
    List<Location> locations = await locationFromAddress(selectedAddress);

    List<Placemark> placemarks = await placemarkFromCoordinates(
        locations.first.latitude, locations.first.longitude);
    state.value = placemarks.last.administrativeArea.toString();
    city.value = placemarks.last.locality.toString();
    postalCode.value = placemarks.last.postalCode.toString();
    country.value = placemarks.last.country.toString();
    parentController.addressController.text = placeName.value;
    parentController.cityController.text = city.value;
    parentController.stateController.text = state.value;
    parentController.countryController.text = country.value;
    parentController.postalCode.value = postalCode.value;
    parentController.update();
    print("NAME:${placeName.value}");
    print("POSTAL:${parentController.postalCode.value}");
    update();
  }
}

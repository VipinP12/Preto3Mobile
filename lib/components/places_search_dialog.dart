import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/google_places_controller.dart';
import 'package:preto3/model/google_place_model.dart';
import 'package:preto3/utils/app_color.dart';

class PlacesSearchDialog extends StatelessWidget {
  const PlacesSearchDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollable(
      viewportBuilder: (BuildContext context, ViewportOffset position) =>
          Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(16),
        alignment: Alignment.topCenter,
        child: Dialog(
            alignment: Alignment.topCenter,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: GetBuilder<GooglePlacesController>(
              builder: (controller) => SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: controller.searchPlacesController,
                    textInputAction: TextInputAction.search,
                    autofocus: true,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      hintText: 'search address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(style: BorderStyle.none, width: 0),
                      ),
                      hintStyle: GoogleFonts.poppins(
                          color: AppColor.hintTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                    ),
                    style: GoogleFonts.poppins(
                        color: AppColor.heavyTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  suggestionsCallback: (pattern) async {
                    return await controller.searchPlaces(context, pattern);
                  },
                  itemBuilder: (BuildContext context, Prediction suggestion) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(children: [
                        const Icon(Icons.location_on),
                        Expanded(
                          child: Text(
                            suggestion.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                color: AppColor.heavyTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ]),
                    );
                  },
                  onSuggestionSelected: (Prediction suggestion) {
                    print("My location is ${suggestion.description}");
                    Get.find<GooglePlacesController>()
                        .getLatLon(suggestion.description);
                    Get.find<GooglePlacesController>().update();
                    //Get.find<LocationController>().setLocation(suggestion.placeId!, suggestion.description!, mapController);
                    Get.back();
                  },
                ),
              ),
            )),
      ),
    );
  }
}

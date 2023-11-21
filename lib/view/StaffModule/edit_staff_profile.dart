import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:preto3/controller/Staff/staff_dashboard_controller.dart';
import 'package:preto3/model/google_place_model.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_dimens.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/app_routes.dart';

class EditStaffProfile extends StatelessWidget {
  EditStaffProfile({Key? key}) : super(key: key);

  final staffController = Get.find<StaffDashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool isInnerScroll) {
            return [
              SliverAppBar(
                expandedHeight: 320,
                floating: false,
                pinned: true,
                actions: const [
                  // InkWell(
                  //   onTap: (){
                  //     staffController.updateStaffProfileSession();
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(right: 16.0, top: 16),
                  //     child: Text(
                  //       "Save",
                  //       textAlign: TextAlign.center,
                  //       style: GoogleFonts.poppins(
                  //           color: AppColor.white,
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.w500),
                  //     ),
                  //   ),
                  // )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: const Image(
                    image: AssetImage(AppAssets.profileBg),
                    fit: BoxFit.fill,
                  ),
                  title: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 140,
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 90,
                              width: 90,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(90)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(90),
                                child: Obx(() =>
                                    staffController.selectedImagePath.isEmpty
                                        ? CachedNetworkImage(
                                            placeholder: (context, url) =>
                                                const Image(
                                              height: 75,
                                              width: 75,
                                              image: AssetImage(
                                                AppAssets.placeHolder,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            imageUrl:
                                                '${staffController.storageBox.read(AppKeys.keyProfilePic)}',
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Image(
                                              height: 75,
                                              width: 75,
                                              image: AssetImage(
                                                AppAssets.placeHolder,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Image.file(
                                            File(staffController
                                                .selectedImagePath.value),
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.cover,
                                          )),
                              ),
                            ),
                            Positioned(
                                top: 10,
                                right: 5,
                                child: InkWell(
                                  onTap: () {
                                    _bottomUploadImageSheet(context);
                                  },
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child:
                                        SvgPicture.asset(AppAssets.roundedAdd),
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${staffController.storageBox.read(AppKeys.keyFirstName)} ${staffController.storageBox.read(AppKeys.keyLastName)}",
                          style: GoogleFonts.poppins(
                              color: AppColor.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Teacher",
                          style: GoogleFonts.poppins(
                              color: AppColor.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Check in/out Pin:${staffController.storageBox.read(AppKeys.keyCheckInOutPin)}",
                          style: GoogleFonts.poppins(
                              color: AppColor.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  collapseMode: CollapseMode.parallax,
                ),
              )
            ];
          },
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text(
                "First Name",
                style: GoogleFonts.poppins(
                    color: AppColor.heavyTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              Form(
                key: staffController.firstNameKey,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: AppColor.appPrimary,
                  /*focusNode:profileController.allergiesFocusNode,
                    onTap: (){
                      profileController.focusAllergies(true);
                      profileController.focusMedication(false);
                    },*/
                  style: GoogleFonts.poppins(
                      color: AppColor.hintTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintText: "first name",
                    helperStyle: GoogleFonts.poppins(
                        color: AppColor.heavyTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.borderColor),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.appPrimary),
                    ),
                    contentPadding: const EdgeInsets.all(0),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: staffController.firstNameController,
                  onSaved: (savedValue) {
                    staffController.firstName.value = savedValue!;
                  },
                  validator: (valid) {
                    return staffController.firstNameValidator(valid.toString());
                  },
                ),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text(
                "Last Name",
                style: GoogleFonts.poppins(
                    color: AppColor.heavyTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              Form(
                key: staffController.lastNameKey,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: AppColor.appPrimary,
                  /*focusNode:profileController.allergiesFocusNode,
                    onTap: (){
                      profileController.focusAllergies(true);
                      profileController.focusMedication(false);
                    },*/
                  style: GoogleFonts.poppins(
                      color: AppColor.hintTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintText: "last name",
                    helperStyle: GoogleFonts.poppins(
                        color: AppColor.heavyTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.borderColor),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.appPrimary),
                    ),
                    contentPadding: const EdgeInsets.all(0),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: staffController.lastNameController,
                  onSaved: (savedValue) {
                    staffController.lastName.value = savedValue!;
                  },
                  validator: (valid) {
                    return staffController.lastNameValidator(valid.toString());
                  },
                ),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text(
                "Email",
                style: GoogleFonts.poppins(
                    color: AppColor.heavyTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              Text(staffController.email.value,
                  style: GoogleFonts.poppins(
                      color: AppColor.lightTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
              const SizedBox(
                height: AppDimens.paddingVertical8,
              ),
              const Divider(
                color: AppColor.borderColor,
                height: 1,
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text("Phone Number",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              Form(
                key: staffController.phoneKey,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^[2-9]\d*$'),
                    ),
                  ],
                  maxLength: 10,
                  cursorColor: AppColor.appPrimary,
                  style: GoogleFonts.poppins(
                      color: AppColor.hintTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintText: "phone name",
                    helperStyle: GoogleFonts.poppins(
                        color: AppColor.heavyTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.borderColor),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.appPrimary),
                    ),
                    contentPadding: const EdgeInsets.all(0),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: staffController.phoneController,
                  onSaved: (savedValue) {
                    staffController.phone.value = savedValue!;
                  },
                  validator: (valid) {
                    return staffController.phoneValidator(valid.toString());
                  },
                ),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical10,
              ),
              Text(
                "Date of Birth",
                style: GoogleFonts.poppins(
                    color: AppColor.heavyTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                height: 42,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: AppColor.disableColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SvgPicture.asset(AppAssets.calenderIcon),
                    ),
                    Obx(() => Text(
                          staffController.dob.value,
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text(
                "Spoken Languages",
                style: GoogleFonts.poppins(
                    color: AppColor.heavyTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: AppColor.disableColor,
                    borderRadius: BorderRadius.circular(10)),
                child: GetBuilder<StaffDashboardController>(
                    builder: (controller) => Wrap(
                          children: controller.languageList
                              .map(
                                (element) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      // controller.languageList(
                                      //     controller.languageList[index]!);
                                    },
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: AppColor.allergiesBg,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Wrap(
                                            children: [
                                              Text(
                                                element.languageName.toString(),
                                                style: GoogleFonts.poppins(
                                                    color:
                                                        AppColor.allergiesText,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.0),
                                                child: Icon(
                                                  Icons.close,
                                                  size: 18,
                                                  color: AppColor.allergiesText,
                                                ),
                                              )
                                            ],
                                          )),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        )),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text("Address",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              Form(
                key: staffController.addressKey,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: AppColor.appPrimary,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (buildContext) {
                          return Scrollable(
                            viewportBuilder: (BuildContext context,
                                    ViewportOffset position) =>
                                Container(
                              margin: const EdgeInsets.only(top: 20),
                              padding: const EdgeInsets.all(16),
                              alignment: Alignment.topCenter,
                              child: Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: GetBuilder<StaffDashboardController>(
                                    builder: (controller) => SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: TypeAheadField(
                                        textFieldConfiguration:
                                            TextFieldConfiguration(
                                          controller:
                                              controller.searchPlacesController,
                                          textInputAction:
                                              TextInputAction.search,
                                          autofocus: true,
                                          textCapitalization:
                                              TextCapitalization.words,
                                          keyboardType:
                                              TextInputType.streetAddress,
                                          decoration: InputDecoration(
                                            hintText: 'search address',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  style: BorderStyle.none,
                                                  width: 0),
                                            ),
                                            hintStyle: GoogleFonts.poppins(
                                                color: AppColor.hintTextColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                            filled: true,
                                            fillColor:
                                                Theme.of(context).cardColor,
                                          ),
                                          style: GoogleFonts.poppins(
                                              color: AppColor.heavyTextColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        suggestionsCallback: (pattern) async {
                                          return await controller.searchPlaces(
                                              context, pattern);
                                        },
                                        itemBuilder: (BuildContext context,
                                            Prediction suggestion) {
                                          return Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(children: [
                                              const Icon(Icons.location_on),
                                              Expanded(
                                                child: Text(
                                                  suggestion.description,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      color: AppColor
                                                          .heavyTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ]),
                                          );
                                        },
                                        onSuggestionSelected:
                                            (Prediction suggestion) {
                                          print(
                                              "My location is ${suggestion.description}");
                                          controller.getLatLon(
                                              suggestion.description);
                                          //Get.find<LocationController>().setLocation(suggestion.placeId!, suggestion.description!, mapController);
                                          Get.back();
                                        },
                                      ),
                                    ),
                                  )),
                            ),
                          );
                        });
                  },
                  style: GoogleFonts.poppins(
                      color: AppColor.hintTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  onEditingComplete: () => staffController
                      .getSuggestion(staffController.addressController.text),
                  decoration: InputDecoration(
                    hintText: "address name",
                    helperStyle: GoogleFonts.poppins(
                        color: AppColor.heavyTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.borderColor),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.appPrimary),
                    ),
                    contentPadding: const EdgeInsets.all(0),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: staffController.addressController,
                  onSaved: (savedValue) {
                    staffController.addressController.text = savedValue!;
                    staffController.addressName.value =
                        staffController.addressController.text;
                    staffController.addressController.text =
                        staffController.addressName.value;
                  },
                  validator: (valid) {
                    return staffController.addressValidator(valid.toString());
                  },
                ),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text("Country",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              Form(
                key: staffController.countryKey,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: AppColor.appPrimary,
                  /*focusNode:profileController.allergiesFocusNode,
                    onTap: (){
                      profileController.focusAllergies(true);
                      profileController.focusMedication(false);
                    },*/
                  style: GoogleFonts.poppins(
                      color: AppColor.hintTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintText: "country",
                    helperStyle: GoogleFonts.poppins(
                        color: AppColor.heavyTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.borderColor),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.appPrimary),
                    ),
                    contentPadding: const EdgeInsets.all(0),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: staffController.countryController,
                  onSaved: (savedValue) {
                    staffController.country.value =
                        staffController.countryController.text;
                  },
                  validator: (valid) {
                    return staffController.countryValidator(valid.toString());
                  },
                ),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text("State",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              Form(
                key: staffController.stateKey,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: AppColor.appPrimary,
                  /*focusNode:profileController.allergiesFocusNode,
                    onTap: (){
                      profileController.focusAllergies(true);
                      profileController.focusMedication(false);
                    },*/
                  style: GoogleFonts.poppins(
                      color: AppColor.hintTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintText: "state",
                    helperStyle: GoogleFonts.poppins(
                        color: AppColor.heavyTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.borderColor),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.appPrimary),
                    ),
                    contentPadding: const EdgeInsets.all(0),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: staffController.stateController,
                  onSaved: (savedValue) {
                    staffController.state.value = savedValue!;
                  },
                  validator: (valid) {
                    return staffController.stateValidator(valid.toString());
                  },
                ),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text("City",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              Form(
                key: staffController.cityKey,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: AppColor.appPrimary,
                  /*focusNode:profileController.allergiesFocusNode,
                    onTap: (){
                      profileController.focusAllergies(true);
                      profileController.focusMedication(false);
                    },*/
                  style: GoogleFonts.poppins(
                      color: AppColor.hintTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintText: "city",
                    helperStyle: GoogleFonts.poppins(
                        color: AppColor.heavyTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.borderColor),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.appPrimary),
                    ),
                    contentPadding: const EdgeInsets.all(0),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: staffController.cityController,
                  onSaved: (savedValue) {
                    staffController.city.value = savedValue!;
                  },
                  validator: (valid) {
                    return staffController.cityValidator(valid.toString());
                  },
                ),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Container(
                height: 40,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColor.profileHeaderBG,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Employment Details",
                      style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text("Joining Date",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Obx(() => Text(
                      staffController.joiningDate.value,
                      style: GoogleFonts.poppins(
                          color: AppColor.lightTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    )),
              ),
              const Divider(
                color: AppColor.borderColor,
                height: 1,
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text("Pay Information",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Salaried",
                  style: GoogleFonts.poppins(
                      color: AppColor.lightTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const Divider(
                color: AppColor.borderColor,
                height: 1,
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Text("Status",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Active",
                  style: GoogleFonts.poppins(
                      color: AppColor.lightTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const Divider(
                color: AppColor.borderColor,
                height: 1,
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Container(
                height: 40,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColor.profileHeaderBG,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "My Rooms",
                      style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              GetBuilder<StaffDashboardController>(
                  builder: (controller) => ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => const Divider(
                          color: AppColor.borderColor,
                          height: 1,
                        ),
                        itemCount: controller.classRoomList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(
                              height: 40,
                              width: double.maxFinite,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: AppDimens.containerHeight,
                                        width: AppDimens.containerHeight,
                                        decoration: BoxDecoration(
                                            color: AppColor.appPrimary,
                                            borderRadius: BorderRadius.circular(
                                                AppDimens.containerHeight)),
                                        child: Center(
                                          child: Text(
                                            controller.classRoomList[index]
                                                .roomName[0],
                                            style: GoogleFonts.poppins(
                                                color: AppColor.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          controller
                                              .classRoomList[index].roomName,
                                          style: GoogleFonts.poppins(
                                              color: AppColor.heavyTextColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child:
                                        SvgPicture.asset(AppAssets.forwardIcon),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              Container(
                height: 40,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColor.profileHeaderBG,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Emergency Contacts",
                      style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: AppDimens.paddingVertical16,
              ),
              GetBuilder<StaffDashboardController>(
                  builder: (controller) => controller
                          .emergencyContactList.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.emergencyContactList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                height: 95,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: AppColor.borderColor, width: 1)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Center(
                                          child: Text(
                                            controller
                                                .emergencyContactList[index]
                                                .contactPersonFirstName[0],
                                            style: GoogleFonts.poppins(
                                                color: AppColor.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${controller.emergencyContactList[index].contactPersonFirstName} ${controller.emergencyContactList[index].contactPersonLastName}',
                                            style: GoogleFonts.poppins(
                                                color: AppColor.heavyTextColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SvgPicture.asset(
                                                  AppAssets.mailIcon),
                                              Text(
                                                controller
                                                    .emergencyContactList[index]
                                                    .emailId,
                                                style: GoogleFonts.poppins(
                                                    color:
                                                        AppColor.heavyTextColor,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SvgPicture.asset(
                                                  AppAssets.callIcon),
                                              Text(
                                                controller
                                                    .emergencyContactList[index]
                                                    .contactNumber,
                                                style: GoogleFonts.poppins(
                                                    color:
                                                        AppColor.heavyTextColor,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      InkWell(
                                          onTap: () {
                                            Get.toNamed(AppRoute.addEmergency);
                                          },
                                          child: SvgPicture.asset(
                                            AppAssets.editIcon,
                                            height: 18,
                                            width: 18,
                                          )),
                                      InkWell(
                                          onTap: () {
                                            staffController
                                                .deleteEmergencyContact(
                                                    controller
                                                        .emergencyContactList[
                                                            index]
                                                        .userId,
                                                    controller
                                                        .emergencyContactList[
                                                            index]
                                                        .emergencyContactId,
                                                    controller.roleId.value);
                                          },
                                          child: SvgPicture.asset(
                                            AppAssets.deleteIcon,
                                            height: 18,
                                            width: 18,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: InkWell(
                            onTap: () {
                              Get.to(AppRoute.addEmergency);
                            },
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: AppColor.appPrimary,
                                ),
                                Center(
                                  child: Text(
                                    "No emergency contact found\n Add a emergency contact",
                                    style: GoogleFonts.poppins(
                                        color: AppColor.heavyTextColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
            ],
          )),
    );
  }

  void _bottomUploadImageSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        isDismissible: false,
        builder: (ctx) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setter) {
            return Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                  color: AppColor.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              staffController.getImage(ImageSource.camera);
                              Get.back();
                            },
                            child: Container(
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(4, 4),
                                        blurRadius: 10,
                                        spreadRadius: 1),
                                    BoxShadow(
                                        color: Colors.white12,
                                        offset: Offset(-4, -4),
                                        blurRadius: 10,
                                        spreadRadius: 1),
                                  ]),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.camera_alt,
                                      color: AppColor.appPrimary,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Camera",
                                      style: TextStyle(
                                          color: AppColor.appPrimary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              staffController.getImage(ImageSource.gallery);
                              Get.back();
                            },
                            child: Container(
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(4, 4),
                                        blurRadius: 10,
                                        spreadRadius: 1),
                                    BoxShadow(
                                        color: Colors.white12,
                                        offset: Offset(-4, -4),
                                        blurRadius: 10,
                                        spreadRadius: 1),
                                  ]),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.image_outlined,
                                      color: AppColor.appPrimary,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Gallery",
                                      style: TextStyle(
                                          color: AppColor.appPrimary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ));
          });
        });
  }
}

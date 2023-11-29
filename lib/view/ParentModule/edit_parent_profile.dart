import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/components/places_search_dialog.dart';
import 'package:preto3/components/rounded_button.dart';
import 'package:preto3/controller/Parent/parent_dashboard_controller.dart';
import 'package:preto3/controller/google_places_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_dimens.dart';
import 'package:preto3/utils/app_keys.dart';

class EditParentProfile extends StatelessWidget {
  EditParentProfile({Key? key}) : super(key: key);

  final parentController = Get.find<ParentDashboardController>();
  final googlePlacesController = Get.put(GooglePlacesController);

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
                actions: [
                  InkWell(
                    onTap: () {
                      parentController.showLoading();
                      parentController.updateParentSession();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0, top: 16),
                      child: Text(
                        "Save",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: AppColor.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
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
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(90)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(90),
                            child: CachedNetworkImage(
                              placeholder: (context, url) => const Image(
                                height: 75,
                                width: 75,
                                image: AssetImage(
                                  AppAssets.placeHolder,
                                ),
                                fit: BoxFit.cover,
                              ),
                              imageUrl:
                                  '${parentController.storageBox.read(AppKeys.keyProfilePic)}',
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => const Image(
                                height: 75,
                                width: 75,
                                image: AssetImage(
                                  AppAssets.placeHolder,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${parentController.storageBox.read(AppKeys.keyFirstName)} ${parentController.storageBox.read(AppKeys.keyLastName)}",
                          style: GoogleFonts.poppins(
                              color: AppColor.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Parent",
                          style: GoogleFonts.poppins(
                              color: AppColor.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Check in/out Pin:${parentController.storageBox.read(AppKeys.keyCheckInOutPin)}",
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
          body: Obx(() => ListView(
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
                    key: parentController.firstNameKey,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColor.appPrimary,
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
                      enabled: false,
                      controller: parentController.firstNameController,
                      onSaved: (savedValue) {
                        parentController.firstName.value = savedValue!;
                      },
                      validator: (valid) {
                        return parentController
                            .firstNameValidator(valid.toString());
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
                    key: parentController.lastNameKey,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColor.appPrimary,
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
                      enabled: false,
                      controller: parentController.lastNameController,
                      onSaved: (savedValue) {
                        parentController.lastName.value = savedValue!;
                      },
                      validator: (valid) {
                        return parentController
                            .lastNameValidator(valid.toString());
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
                  Obx(
                    () => Text(parentController.email.value,
                        style: GoogleFonts.poppins(
                            color: AppColor.lightTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                  ),
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
                    key: parentController.phoneKey,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColor.appPrimary,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^[2-9]\d*$'),
                        ),
                      ],
                      maxLength: 10,
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
                      enabled: false,
                      controller: parentController.phoneController,
                      onChanged: (change) {
                        parentController.getSuggestion(change);
                      },
                      onSaved: (savedValue) {
                        parentController.phone.value = savedValue!;
                      },
                      validator: (valid) {
                        return parentController
                            .phoneValidator(valid.toString());
                      },
                    ),
                  ),
                  const SizedBox(
                    height: AppDimens.paddingVertical10,
                  ),
                  Text("Address",
                      style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400)),
                  Form(
                    key: parentController.addressKey,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColor.appPrimary,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (buildContext) {
                              return const PlacesSearchDialog();
                            });
                      },
                      style: GoogleFonts.poppins(
                          color: AppColor.hintTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      onEditingComplete: () => parentController.getSuggestion(
                          parentController.addressController.text),
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
                      enabled: false,
                      controller: parentController.addressController,
                      onSaved: (savedValue) {
                        parentController.addressController.text = savedValue!;
                        parentController.addressController.text =
                            parentController.addressName.value;
                      },
                      validator: (valid) {
                        return parentController
                            .addressValidator(valid.toString());
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
                    key: parentController.countryKey,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColor.appPrimary,
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
                      enabled: false,
                      controller: parentController.countryController,
                      onSaved: (savedValue) {
                        parentController.country.value = savedValue!;
                      },
                      validator: (valid) {
                        return parentController
                            .countryValidator(valid.toString());
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
                    key: parentController.stateKey,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColor.appPrimary,
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
                      enabled: false,
                      controller: parentController.stateController,
                      onSaved: (savedValue) {
                        parentController.state.value = savedValue!;
                      },
                      validator: (valid) {
                        return parentController
                            .stateValidator(valid.toString());
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
                    key: parentController.cityKey,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColor.appPrimary,
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
                      enabled: false,
                      controller: parentController.cityController,
                      onSaved: (savedValue) {
                        parentController.city.value = savedValue!;
                      },
                      validator: (valid) {
                        return parentController.cityValidator(valid.toString());
                      },
                    ),
                  ),
                  const SizedBox(
                    height: AppDimens.paddingVertical16,
                  ),
                  parentController.parentName.value.isNotEmpty
                      ? Container(
                          height: 40,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: AppColor.profileHeaderBG,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                "Relationship",
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  parentController.parentName.value.isNotEmpty
                      ? const SizedBox(
                          height: AppDimens.paddingVertical16,
                        )
                      : const SizedBox.shrink(),
                  parentController.parentName.value.isNotEmpty
                      ? Container(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Center(
                                        child: Text(
                                          parentController.parentName.value[0],
                                          style: GoogleFonts.poppins(
                                              color: AppColor.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: Text(
                                              parentController.parentName.value,
                                              style: GoogleFonts.poppins(
                                                  color:
                                                      AppColor.heavyTextColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                  AppAssets.mailIcon),
                                              Text(
                                                parentController
                                                    .parentEmail.value,
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
                                                CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                  AppAssets.callIcon),
                                              Text(
                                                parentController
                                                    .parentNumber.value,
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
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "Parent",
                                    style: GoogleFonts.poppins(
                                        color: AppColor.appPrimary,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  parentController.parentName.value.isNotEmpty
                      ? const SizedBox(
                          height: AppDimens.paddingVertical16,
                        )
                      : const SizedBox.shrink(),
                  parentController.emergencyContactList.isNotEmpty
                      ? Container(
                          height: 40,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: AppColor.profileHeaderBG,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                "Emergency Contact",
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  GetBuilder<ParentDashboardController>(
                    builder: (controller) => ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.emergencyContactList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              height: 110,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: AppColor.borderColor, width: 1)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                                      .emergencyContactList[
                                                          index]
                                                      .name[0],
                                                  style: GoogleFonts.poppins(
                                                      color: AppColor.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4.0),
                                                  child: Text(
                                                    controller
                                                        .emergencyContactList[
                                                            index]
                                                        .name,
                                                    style: GoogleFonts.poppins(
                                                        color: AppColor
                                                            .heavyTextColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                        AppAssets.mailIcon),
                                                    Text(
                                                      controller
                                                          .emergencyContactList[
                                                              index]
                                                          .email,
                                                      style: GoogleFonts.poppins(
                                                          color: AppColor
                                                              .heavyTextColor,
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
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                        AppAssets.callIcon),
                                                    Text(
                                                      controller
                                                          .emergencyContactList[
                                                              index]
                                                          .phoneNumber
                                                          .toString(),
                                                      style: GoogleFonts.poppins(
                                                          color: AppColor
                                                              .heavyTextColor,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Flexible(
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          "Emergency contact",
                                          style: GoogleFonts.poppins(
                                            color: AppColor.appPrimary,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
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
                          "Change Password",
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Password",
                      style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Form(
                    key: parentController.passwordKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      cursorColor: AppColor.appPrimary,
                      focusNode: parentController.passwordFocusNode,
                      onTap: () {
                        parentController.focusPasswordIcons(true);
                        parentController.focusNewPasswordIcons(false);
                        parentController.focusCPasswordIcons(false);
                      },
                      style: GoogleFonts.poppins(
                          color: AppColor.hintTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      onEditingComplete: () => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        hintText: "Enter your current password",
                        helperStyle: GoogleFonts.poppins(
                            color: AppColor.hintTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              const BorderSide(color: AppColor.borderColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              const BorderSide(color: AppColor.appPrimary),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      controller: parentController.passwordController,
                      onSaved: (savedValue) {
                        parentController.currentPassword.value = savedValue!;
                      },
                      validator: (valid) {
                        return parentController
                            .passwordValidator(valid.toString());
                      },
                    ),
                  ),
                  const SizedBox(
                    height: AppDimens.paddingVertical16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "New Password",
                      style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Form(
                    key: parentController.newPasswordKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      cursorColor: AppColor.appPrimary,
                      focusNode: parentController.newPasswordFocusNode,
                      onTap: () {
                        parentController.focusPasswordIcons(false);
                        parentController.focusNewPasswordIcons(true);
                        parentController.focusCPasswordIcons(false);
                      },
                      style: GoogleFonts.poppins(
                          color: AppColor.hintTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      onEditingComplete: () => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        hintText: "Enter new password",
                        helperStyle: GoogleFonts.poppins(
                            color: AppColor.hintTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              const BorderSide(color: AppColor.borderColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              const BorderSide(color: AppColor.appPrimary),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      controller: parentController.newPasswordController,
                      onSaved: (savedValue) {
                        parentController.newPassword.value = savedValue!;
                      },
                      validator: (valid) {
                        return parentController
                            .passwordValidator(valid.toString());
                      },
                    ),
                  ),
                  const SizedBox(
                    height: AppDimens.paddingVertical16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Confirm Password",
                      style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Form(
                    key: parentController.cPasswordKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      cursorColor: AppColor.appPrimary,
                      focusNode: parentController.cPasswordFocusNode,
                      onTap: () {
                        parentController.focusPasswordIcons(false);
                        parentController.focusNewPasswordIcons(false);
                        parentController.focusCPasswordIcons(true);
                      },
                      style: GoogleFonts.poppins(
                          color: AppColor.hintTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      onEditingComplete: () => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        hintText: "Enter confirm password",
                        helperStyle: GoogleFonts.poppins(
                            color: AppColor.hintTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              const BorderSide(color: AppColor.borderColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              const BorderSide(color: AppColor.appPrimary),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      controller: parentController.cPasswordController,
                      onSaved: (savedValue) {
                        parentController.newPassword.value = savedValue!;
                      },
                      validator: (valid) {
                        return parentController
                            .cPasswordValidator(valid.toString());
                      },
                    ),
                  ),
                  const SizedBox(
                    height: AppDimens.paddingVertical16,
                  ),
                  RoundedButton(
                    height: 50,
                    width: 120,
                    color: AppColor.appPrimary,
                    onClick: () {
                      parentController.changePasswordSession(context);
                    },
                    text: 'Change Password',
                    style: GoogleFonts.poppins(
                        color: AppColor.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                ],
              ))),
    );
  }
}

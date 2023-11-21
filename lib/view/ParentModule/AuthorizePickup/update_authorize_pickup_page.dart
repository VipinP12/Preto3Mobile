import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/Parent/AuthorizePickup/update_authorize_pickup_controller.dart';
import 'package:preto3/model/parent/parent_students_model.dart';
import 'package:preto3/utils/app_assets.dart';

import '../../../components/places_search_dialog.dart';
import '../../../controller/Parent/AuthorizePickup/authorize_pickup_create_controller.dart';
import '../../../controller/google_places_controller.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_dimens.dart';
import '../../../utils/toast.dart';

class UpdateAuthorizePickupPage extends StatelessWidget {
  UpdateAuthorizePickupPage({super.key});

  final authorizePikupCreaateController =
      Get.find<UpdateAuthorizePikupCreateController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColor.appPrimary,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Get.back(result: false);
          },
          child: const Icon(Icons.arrow_back),
        ),
        centerTitle: false,
        title: Text(
          "Update Authorize Pickup",
          style: GoogleFonts.poppins(
              color: AppColor.white, fontSize: 15, fontWeight: FontWeight.w600),
        ),
        actions: [
          InkWell(
            onTap: () async {
              if (authorizePikupCreaateController
                      .firstNamePickupPersionKey.currentState!
                      .validate() &&
                  authorizePikupCreaateController
                      .lastNamePickupPersionKey.currentState!
                      .validate() &&
                  authorizePikupCreaateController.pickupPersionEmailKey.currentState!
                      .validate() &&
                  authorizePikupCreaateController
                      .pickupPersionPhoneKey.currentState!
                      .validate() &&
                  authorizePikupCreaateController.pickupAddressKey.currentState!
                      .validate() &&
                  authorizePikupCreaateController.pickupFlag.value) {
                if (authorizePikupCreaateController
                        .dropDownInitialValue.value ==
                    "Select child") {
                  messageToastWarning(context, "Please select child");
                } else if (authorizePikupCreaateController.pickupTime
                    .trim()
                    .isEmpty) {
                  messageToastWarning(context, "Please enter the pickup time.");
                } else {
                  if (authorizePikupCreaateController.authorizePeriod.value &&
                      !authorizePikupCreaateController
                          .startDateValidation.value &&
                      !authorizePikupCreaateController
                          .endDateValidation.value) {
                    if (!authorizePikupCreaateController.dateDifference()) {
                      messageToastWarning(
                          context, "Start date must be before the end date.");
                      return;
                    } else if (!authorizePikupCreaateController
                        .dateDiffrenceForUpdate(
                            authorizePikupCreaateController.startDate.value)) {
                      messageToastWarning(context,
                          "Start date can't be less then current date");
                      return;
                    }
                  }
                  if (!authorizePikupCreaateController.authorizePeriod.value) {
                    if (authorizePikupCreaateController
                        .selectPickDate.value.isEmpty) {
                      messageToastWarning(context, "Please select date(s)");
                      return;
                    }
                  }

                  if (await authorizePikupCreaateController
                      .updateAuthorizePickup()) {
                    messageToastSuccess(context, "",
                        "Authorized Pickup has been updated successfully.");
                    Future.delayed(const Duration(seconds: 2), () {
                      Get.back();
                      Get.back(result: true);
                    });
                  }
                }
              } else {
                authorizePikupCreaateController
                    .firstNamePickupPersionKey.currentState!
                    .validate();
                authorizePikupCreaateController
                    .lastNamePickupPersionKey.currentState!
                    .validate();
                authorizePikupCreaateController
                    .pickupPersionEmailKey.currentState!
                    .validate();
                authorizePikupCreaateController
                    .pickupPersionPhoneKey.currentState!
                    .validate();
                authorizePikupCreaateController.pickupAddressKey.currentState!
                    .validate();
                messageToastWarning(
                    context, " Please fill all necessary details");
              }
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Save",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: AppColor.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.only(bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      authorizePikupCreaateController.getFromGallery();
                    },
                    child: GetBuilder<UpdateAuthorizePikupCreateController>(
                      builder: (controller) => Container(
                        height: 127,
                        width: 127,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(150),
                          color: Colors.grey.shade600,
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 25),
                        child: controller.imageFile == null
                            ? const Icon(
                                Icons.camera_alt,
                                size: 46,
                                color: AppColor.white,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(150),
                                child: Image(
                                  image: AssetImage(
                                    controller.imageFile!.path,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColor.disableColor,
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20),
                  margin: const EdgeInsets.only(bottom: 20, top: 20),
                  child: Text(authorizePikupCreaateController
                      .dropDownInitialValue.value)),
              Obx(() => authorizePikupCreaateController
                          .dropDownInitialValue.value !=
                      "Select child"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "First Name of Pickup person",
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        Form(
                          key: authorizePikupCreaateController
                              .firstNamePickupPersionKey,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            cursorColor: AppColor.appPrimary,
                            /*focusNode:profileController.allergiesFocusNode,
                        onTap: (){
                          profileController.focusAllergies(true);
                          profileController.focusMedication(false);
                        },*/
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(80),
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[A-Za-z ]')),
                            ],
                            style: GoogleFonts.poppins(
                                color: AppColor.hintTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            onEditingComplete: () =>
                                FocusScope.of(context).unfocus(),
                            decoration: InputDecoration(
                              hintText: "",
                              helperStyle: GoogleFonts.poppins(
                                  color: AppColor.heavyTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.borderColor),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.appPrimary),
                              ),
                              contentPadding: const EdgeInsets.all(0),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            onChanged: (value) {
                              authorizePikupCreaateController
                                  .firstNamePickupPersionKey.currentState!
                                  .validate();
                            },
                            controller: authorizePikupCreaateController
                                .firstNamePickupPersionController,
                            onSaved: (savedValue) {
                              authorizePikupCreaateController.firstName.value =
                                  savedValue!;
                            },
                            validator: (valid) {
                              return authorizePikupCreaateController
                                  .firstNamePickupPersionValidator(
                                      valid.toString());
                            },
                          ),
                        ),
                        const SizedBox(
                          height: AppDimens.paddingVertical16,
                        ),
                        Text(
                          "Last Name of Pickup person",
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        Form(
                          key: authorizePikupCreaateController
                              .lastNamePickupPersionKey,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            cursorColor: AppColor.appPrimary,
                            /*focusNode:profileController.allergiesFocusNode,
                        onTap: (){
                          profileController.focusAllergies(true);
                          profileController.focusMedication(false);
                        },*/
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(80),
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[A-Za-z]')),
                            ],
                            style: GoogleFonts.poppins(
                                color: AppColor.hintTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            onEditingComplete: () =>
                                FocusScope.of(context).unfocus(),
                            decoration: InputDecoration(
                              hintText: "",
                              helperStyle: GoogleFonts.poppins(
                                  color: AppColor.heavyTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.borderColor),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.appPrimary),
                              ),
                              contentPadding: const EdgeInsets.all(0),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            onChanged: (value) {
                              authorizePikupCreaateController
                                  .lastNamePickupPersionKey.currentState!
                                  .validate();
                            },
                            controller: authorizePikupCreaateController
                                .lastNamePickupPersionController,
                            onSaved: (savedValue) {
                              authorizePikupCreaateController.firstName.value =
                                  savedValue!;
                            },
                            validator: (valid) {
                              return authorizePikupCreaateController
                                  .lastNamePickupPersionValidator(
                                      valid.toString());
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
                        Form(
                          key: authorizePikupCreaateController
                              .pickupPersionEmailKey,
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
                            onEditingComplete: () =>
                                FocusScope.of(context).unfocus(),
                            decoration: InputDecoration(
                              hintText: "",
                              helperStyle: GoogleFonts.poppins(
                                  color: AppColor.heavyTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.borderColor),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.appPrimary),
                              ),
                              contentPadding: const EdgeInsets.all(0),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            onChanged: (value) {
                              authorizePikupCreaateController
                                  .pickupPersionEmailKey.currentState!
                                  .validate();
                            },
                            controller: authorizePikupCreaateController
                                .pickupPersionEmailController,
                            onSaved: (savedValue) {
                              authorizePikupCreaateController.firstName.value =
                                  savedValue!;
                            },
                            validator: (valid) {
                              return authorizePikupCreaateController
                                  .pickupPersionEmailValidator(
                                      valid.toString());
                            },
                          ),
                        ),
                        const SizedBox(
                          height: AppDimens.paddingVertical16,
                        ),
                        Text(
                          "Phone Number",
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        Form(
                          key: authorizePikupCreaateController
                              .pickupPersionPhoneKey,
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            cursorColor: AppColor.appPrimary,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^[2-9]\d*$')),
                            ],
                            style: GoogleFonts.poppins(
                                color: AppColor.hintTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            onEditingComplete: () =>
                                FocusScope.of(context).unfocus(),
                            decoration: InputDecoration(
                              hintText: "",
                              helperStyle: GoogleFonts.poppins(
                                  color: AppColor.heavyTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.borderColor),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.appPrimary),
                              ),
                              contentPadding: const EdgeInsets.all(0),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            onChanged: (value) {
                              authorizePikupCreaateController
                                  .pickupPersionPhoneKey.currentState!
                                  .validate();
                            },
                            controller: authorizePikupCreaateController
                                .pickupPersionPhoneController,
                            onSaved: (savedValue) {
                              authorizePikupCreaateController.firstName.value =
                                  savedValue!;
                            },
                            validator: (valid) {
                              return authorizePikupCreaateController
                                  .pickupPersionPhoneValidator(
                                      valid.toString());
                            },
                          ),
                        ),
                        const SizedBox(
                          height: AppDimens.paddingVertical16,
                        ),
                        Obx(() => authorizePikupCreaateController
                                .authorizePeriod.value
                            ? authorizePeriodPick(context)
                            : authorizeDatePick(context)),
                        pickupTime(context),
                        Text(
                          "Pickup Address",
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        GetBuilder<GooglePlacesController>(
                          builder: (controller) => Form(
                            key: authorizePikupCreaateController
                                .pickupAddressKey,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              cursorColor: AppColor.appPrimary,
                              /*focusNode:profileController.allergiesFocusNode,
                          onTap: (){
                            profileController.focusAllergies(true);
                            profileController.focusMedication(false);
                          },*/
                              onTap: () async {
                                await showDialog(
                                    context: context,
                                    builder: (buildContext) {
                                      return PlacesSearchDialog();
                                    });
                                authorizePikupCreaateController
                                    .pickupAddressController
                                    .text = controller.placeName.value;
                              },
                              maxLines: 6,
                              minLines: 1,
                              style: GoogleFonts.poppins(
                                  color: AppColor.hintTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              onEditingComplete: () =>
                                  FocusScope.of(context).unfocus(),
                              decoration: InputDecoration(
                                hintText: "",
                                helperStyle: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.borderColor),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.appPrimary),
                                ),
                                contentPadding: const EdgeInsets.all(0),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              controller: authorizePikupCreaateController
                                  .pickupAddressController,
                              onSaved: (savedValue) {
                                authorizePikupCreaateController
                                    .pickupPersionAddress.value = savedValue!;
                              },
                              validator: (valid) {
                                return authorizePikupCreaateController
                                    .pickupAddressValidator(valid.toString());
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: AppDimens.paddingVertical16,
                        ),
                      ],
                    )
                  : Container())
            ],
          ),
        ),
      ),
    );
  }

  Widget allChildDropDown(BuildContext context) {
    return GetBuilder<AuthorizePikupCreateController>(
      builder: (childerController) => DropdownButton2(
        isExpanded: true,
        underline: const SizedBox.shrink(),
        hint: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              const Icon(
                Icons.person,
                size: 16,
                color: Colors.black,
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  childerController.dropDownInitialValue.value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        items: childerController.allChildern
            .map((item) => DropdownMenuItem<ParentStudents>(
                value: item,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 30,
                      child: FittedBox(
                        child: FloatingActionButton(
                          backgroundColor: AppColor.appPrimary,
                          onPressed: () {},
                          child: const Icon(
                            Icons.person,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      item.studentFullName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )))
            .toList(),
        value: childerController.allChildValue,
        onChanged: (value) {
          print(value);
          childerController.dropDownInitialValue.value =
              value!.studentFullName.toString();
          childerController.allChildValue = value;
          childerController.update();
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.grey.shade200,
          ),
          elevation: 0,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down_outlined,
            size: 30,
          ),
          iconSize: 14,
          iconEnabledColor: Colors.black,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 250,
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.white,
          ),
          elevation: 8,
          //offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 42,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }

  authorizePeriodPick(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Start Date",
                      style: GoogleFonts.poppins(
                          color: AppColor.mediumTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400)),
                  Container(
                    margin:
                        const EdgeInsets.only(right: 10, bottom: 20, top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                            authorizePikupCreaateController.setPickStartDate(
                                await authorizePikupCreaateController
                                    .pickDate(context));
                          },
                          child: Container(
                              padding: const EdgeInsets.only(
                                  top: 6, bottom: 6, left: 10, right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey.shade200,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month_rounded,
                                    size: 25,
                                    color: AppColor.black,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Obx(
                                      () => Text(
                                        authorizePikupCreaateController
                                                .startDate
                                                .trim()
                                                .isEmpty
                                            ? "Start date"
                                            : authorizePikupCreaateController
                                                .startDate.value,
                                        style: GoogleFonts.poppins(
                                            color: AppColor.lightTextColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                        authorizePikupCreaateController
                                .startDateValidation.value
                            ? Text("Start date can't be empty",
                                style: GoogleFonts.poppins(
                                    color: Colors.red,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400))
                            : Container()
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Flexible(
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("End Date",
                      style: GoogleFonts.poppins(
                          color: AppColor.mediumTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400)),
                  Container(
                    margin:
                        const EdgeInsets.only(right: 10, bottom: 20, top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                            authorizePikupCreaateController.setPickEndDate(
                                await authorizePikupCreaateController
                                    .pickDate(context));
                          },
                          child: Container(
                              padding: const EdgeInsets.only(
                                  top: 6, bottom: 6, left: 10, right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey.shade200,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month_rounded,
                                    size: 25,
                                    color: AppColor.black,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Obx(
                                      () => Text(
                                        authorizePikupCreaateController.endDate
                                                .trim()
                                                .isEmpty
                                            ? "End date"
                                            : authorizePikupCreaateController
                                                .endDate.value,
                                        style: GoogleFonts.poppins(
                                            color: AppColor.lightTextColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                        authorizePikupCreaateController.endDateValidation.value
                            ? Text("End date can't be empty",
                                style: GoogleFonts.poppins(
                                    color: Colors.red,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400))
                            : Container()
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  authorizeDatePick(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GetBuilder<AuthorizePikupCreateController>(
          builder: (controller) => Wrap(
            alignment: WrapAlignment.start,
            children: controller.selectPickDate.value
                .map(
                  (i) => Container(
                    width: 100,
                    padding: const EdgeInsets.all(6),
                    margin: const EdgeInsets.only(bottom: 15, right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColor.allergiesBg,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(i,
                            style: GoogleFonts.poppins(
                                color: AppColor.allergiesText,
                                fontSize: 11,
                                fontWeight: FontWeight.w400)),
                        InkWell(
                          onTap: () {
                            controller.selectPickDate.value.remove(i);
                            controller.update();
                          },
                          child: Text(" X ",
                              style: GoogleFonts.poppins(
                                  color: AppColor.allergiesText,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400)),
                        )
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: InkWell(
                onTap: () async {
                  authorizePikupCreaateController.setSelectDate(
                      await authorizePikupCreaateController.pickDate(context));
                },
                child: Container(
                    padding: const EdgeInsets.only(
                        top: 6, bottom: 6, left: 10, right: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.shade200,
                    ),
                    margin:
                        const EdgeInsets.only(right: 10, bottom: 20, top: 5),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_rounded,
                          size: 25,
                          color: AppColor.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Obx(
                            () => Text(
                              authorizePikupCreaateController.selectDate
                                      .trim()
                                      .isEmpty
                                  ? "Select Date"
                                  : authorizePikupCreaateController
                                      .selectDate.value,
                              style: GoogleFonts.poppins(
                                  color: AppColor.lightTextColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
            InkWell(
              onTap: () {
                if (authorizePikupCreaateController
                    .selectDate.value.isNotEmpty) {
                  authorizePikupCreaateController.selectPickDate.add(
                      authorizePikupCreaateController.selectDate.value
                          .toString());
                  authorizePikupCreaateController.selectDate.value = "";
                  authorizePikupCreaateController.update();
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: SvgPicture.asset(AppAssets.roundedAdd),
              ),
            )
          ],
        )
      ],
    );
  }

  pickupTime(BuildContext context) {
    return InkWell(
      onTap: () async {
        authorizePikupCreaateController.setPickTimeSet(
            await authorizePikupCreaateController.pickTime(context));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10, bottom: 20, top: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 10, right: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey.shade200,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.watch_later_outlined,
                      size: 25,
                      color: AppColor.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Obx(
                        () => Text(
                          authorizePikupCreaateController.pickupTime
                                  .trim()
                                  .isEmpty
                              ? "Pickup Time"
                              : authorizePikupCreaateController
                                  .pickupTime.value,
                          style: GoogleFonts.poppins(
                              color: AppColor.lightTextColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  ],
                )),
            Obx(() => authorizePikupCreaateController.pickupFlag.value
                ? Container()
                : Text(authorizePikupCreaateController.pickupError.value,
                    style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontSize: 10,
                        fontWeight: FontWeight.w400)))
          ],
        ),
      ),
    );
  }
}

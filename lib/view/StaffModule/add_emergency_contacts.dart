import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/Staff/add_emergency_controller.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_dimens.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/app_string.dart';

class AddEmergencyContacts extends StatelessWidget {
  AddEmergencyContacts({Key? key}) : super(key: key);

  final addEmergencyController = Get.find<AddEmergencyController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColor.appPrimary,
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
        ),
        title: Text(
          AppString.addEmergency,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          InkWell(
            onTap: () {
              addEmergencyController.saveEmergencySession(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Center(
                child: Text(
                  "Save",
                  style: GoogleFonts.poppins(
                      color: AppColor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                key: addEmergencyController.firstNameKey,
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
                  controller: addEmergencyController.firstNameController,
                  onSaved: (savedValue) {
                    addEmergencyController.firstName.value = savedValue!;
                  },
                  validator: (valid) {
                    return addEmergencyController
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
                key: addEmergencyController.lastNameKey,
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
                  controller: addEmergencyController.lastNameController,
                  onSaved: (savedValue) {
                    addEmergencyController.lastName.value = savedValue!;
                  },
                  validator: (valid) {
                    return addEmergencyController
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
              Form(
                key: addEmergencyController.emailKey,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
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
                    hintText: "email",
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
                  controller: addEmergencyController.emailController,
                  onSaved: (savedValue) {
                    addEmergencyController.email.value = savedValue!;
                  },
                  validator: (valid) {
                    return addEmergencyController
                        .emailValidator(valid.toString());
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
                key: addEmergencyController.phoneKey,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  cursorColor: AppColor.appPrimary,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.deny(RegExp("[0-1]")),
                  ],
                  maxLength: 10,
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
                    hintText: "phone",
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
                  controller: addEmergencyController.phoneController,
                  onSaved: (savedValue) {
                    addEmergencyController.phone.value = savedValue!;
                  },
                  validator: (valid) {
                    return addEmergencyController
                        .phoneValidator(valid.toString());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

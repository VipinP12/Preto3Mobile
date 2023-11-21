import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/components/rounded_button.dart';
import 'package:preto3/controller/sign_up_controller.dart';
import 'package:preto3/model/school_type_model.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';

class SignUpSchoolPage extends StatelessWidget {
  SignUpSchoolPage({Key? key}) : super(key: key);

  final signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(()=>Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () => Get.back(),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Register your school with PREto3",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  height: 45,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: AppColor.disableColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: GetBuilder<SignUpController>(
                    builder: (controller) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: DropdownButton<SchoolTypeModel>(
                        //elevation: 5,
                        hint: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Select School Type',
                            style: GoogleFonts.poppins(
                                color: AppColor.lightTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        isExpanded: true,
                        icon: Visibility(
                            visible: true,
                            child: SvgPicture.asset(AppAssets.dropdownIcon)),
                        dropdownColor: AppColor.white,
                        borderRadius: BorderRadius.circular(10),
                        iconEnabledColor: AppColor.appPrimary,
                        underline: Container(),
                        alignment: Alignment.topCenter,
                        items: controller.schoolTypeList
                            .map((SchoolTypeModel schoolTypeModel) =>
                            DropdownMenuItem<SchoolTypeModel>(
                                value: schoolTypeModel,
                                child: Text(
                                  schoolTypeModel.schoolTypeName,
                                  style: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )))
                            .toList(),
                        onChanged: (changed) {
                          controller.setSchoolType(changed!);
                          log("My School Type:${controller.selectedSchoolType}");
                        },
                        value: controller.mySchoolType,
                      ),
                    ),
                  )),
              signUpController.isSchoolTypeValid.isFalse
                  ? Text(
                signUpController.selectSchoolType.value,
                style: GoogleFonts.poppins(
                    color: AppColor.absentColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              )
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: signUpController.signUpSchoolNameKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
                  ],
                  cursorColor: AppColor.appPrimary,
                  style: GoogleFonts.poppins(
                      color: AppColor.hintTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintText: "School name",
                    helperStyle: GoogleFonts.poppins(
                        color: AppColor.hintTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.hintTextColor),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.appPrimary),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: signUpController.schoolNameController,
                  onSaved: (savedValue) {
                    signUpController.schoolName.value = savedValue!;
                  },
                  validator: (valid) {
                    return signUpController
                        .schoolNameValidator(valid.toString());
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
              ),
              RoundedButton(
                height: 50,
                width: double.maxFinite,
                color: AppColor.appPrimary,
                text: 'Next',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                onClick: () => signUpController.signSchoolSession(),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () => Get.toNamed(AppRoute.login),
                child: Center(
                  child: RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                          text: 'Already a user ? ',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: 'Log In',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w500),
                        ),
                      ])),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),)
        ),
      ),
    );
  }
}

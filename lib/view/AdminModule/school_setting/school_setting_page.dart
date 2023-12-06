import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/comman_textStyle.dart';
import 'package:preto3/utils/comman_textfield.dart';

import '../../../controller/Admin/school_management/school_setting_controller.dart';

class SchoolSettingPage extends StatelessWidget {
  SchoolSettingPage({super.key});

  final schoolSettingController = Get.find<SchoolSettingController>( );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SchoolSettingController>(
      init: SchoolSettingController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColor.scaffoldBackground,
          appBar: AppBar(leading: InkWell(
              onTap: () => Get.back(),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
            title: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("School Settings",
                  style:  TextStyles.textStyleFW500(AppColor.white, 18)
                      ),
                      InkWell(
                        onTap:schoolSettingController.saveSettingDetails,
                        child: Text("Save",
                                style: TextStyles.textStyleFW500(AppColor.white, 18)
                                    ),
                      ),
              ],
            ),
                  ),
          body:SingleChildScrollView(
             padding: const EdgeInsets.only(left:25, top:15, right:25,bottom:30),
              child: Form(
                key: schoolSettingController.formKey,
                 autovalidateMode: AutovalidateMode.always,
                child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                 Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.totalColor,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            width: MediaQuery.sizeOf(context).width*0.25,
                            height: MediaQuery.sizeOf(context).height*0.10,
                            child: Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                Text("Rooms",style: TextStyles.textStyleFW400(AppColor.white, 14)),Text("0",style: TextStyles.textStyleFW400(AppColor.white, 24))
                              ],),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color:AppColor.inColor,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            width: MediaQuery.sizeOf(context).width*0.25,
                            height: MediaQuery.sizeOf(context).height*0.10,
                           child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
                             child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                Text("Students",style: TextStyles.textStyleFW400(AppColor.white, 14),),Text("0",style: TextStyles.textStyleFW400(AppColor.white, 24))
                              ],),
                           ), 
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color:AppColor.outColor,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            width: MediaQuery.sizeOf(context).width*0.25,
                            height: MediaQuery.sizeOf(context).height*0.10,
                           child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                             child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                Text("Staff",style:TextStyles.textStyleFW400(AppColor.white, 14)),Text("0",style: TextStyles.textStyleFW400(AppColor.white, 24),)
                              ],),
                           ),
                          )
                        ],
                      ),
                   const SizedBox(height: 15),
                    Column(
                      children: [
                   Container(
                     margin: const EdgeInsets.symmetric(vertical: 10),
                             padding: const EdgeInsets.all(10),
                             width: MediaQuery.sizeOf(context).width,
                             height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color:AppColor.profileHeaderBG
                            ),
                            child: Text("School Details",style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14)),
                          ),
                        Column(
                          children: [
                         CommonTextField(
                                    title: "School Name",
                                    hintText: "Enter school name",
                                    controller: schoolSettingController.schoolNameController,
                                    validator: (value)=>schoolSettingController.validateSchoolName(value),
                                    onSaved: (value) {
                                    },
                                  ),
                                  CommonTextField(
                                    title: "School Type",
                                    hintText: "Enter school type",
                                    controller: schoolSettingController.schoolTypeController,
                                     validator: (value)=>schoolSettingController.validateSchoolType(value),
                                    onSaved: (value) {
                                    },
                                  ),
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      "Operating Start Time",
       style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),

    ),
    const SizedBox(height: 5),
        GestureDetector(

      onTap: () async {
        await schoolSettingController.selectStartTime(context);
      },
    child: CommonTextField(
        hintText: "Select Time",
        controller: schoolSettingController.selectedStartTimeController,
        enabled: false,
        prefixIcon: Icon(
          Icons.access_time,
    color: AppColor.heavyTextColor,
       size: 18,
        ),

        contentPadding: EdgeInsets.symmetric(vertical: 11, horizontal: 8),
         border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                             borderSide: BorderSide.none),
                                        fillColor:AppColor.disableColor,
      ),
    ),
  ],
),
                        Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                              Text(
                                  "Operating End Time",
                                  style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),
                                  textAlign: TextAlign.left,
                                ),

                              const SizedBox(height: 5),
                              GestureDetector(
                                      onTap: () async {
                                 await schoolSettingController.selectEndTime(context);
                                },
                                child: CommonTextField(
        hintText: "Select Time",
        controller: schoolSettingController.selectedEndTimeController,
        enabled: false,
        prefixIcon: Icon(
          Icons.access_time,
    color: AppColor.heavyTextColor,
       size: 18,
        ),

        contentPadding: EdgeInsets.symmetric(vertical: 11, horizontal: 8),
         border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                             borderSide: BorderSide.none),
                                        fillColor:AppColor.disableColor,


      ),
                              ),

                        ],
                        ),
                                  CommonTextField(
                                    title: "EIN/SSN#",
                                    hintText: "Enter EIN/SSN#",
                                    keyboardType: TextInputType.number,
                                    controller: schoolSettingController.ssnEinController,
                                  validator: (value)=>schoolSettingController.validateSsnEin(value),
                                    onSaved: (value) {
                                    },
                                  ),
                                  CommonTextField(
                                    title: "Facility#",
                                    hintText: "Enter facility number",
                                    controller: schoolSettingController.facilityController,
                                    validator: (value)=>schoolSettingController.validateFacility(value),
                                    onSaved: (value) {
                                    },
                                  ),
                                  CommonTextField(
                                    keyboardType: TextInputType.number,
                                    title: "Enrollment Capacity",
                                    hintText: "Enter enrollment capacity",
                                    controller: schoolSettingController.enrollmentController,
                                    validator: (value)=>schoolSettingController.validateEnrollment(value),
                                    onSaved: (value) {
                                    },
                                  ),



                        CommonTextField(
                        title: "School Address",
                        hintText: "School Address",
                        controller: schoolSettingController.addressController,
                        validator: (value)=>schoolSettingController.validateAddress(value),
                        onSaved: (value) {
                        },

                        ),
                        CommonTextField(
                        title: "Country",
                        hintText: "Country",
                        controller: schoolSettingController.countryController,
                        validator: (value)=>schoolSettingController.validateCountry(value),
                        onSaved: (value) {

                        },

                        ),

                        CommonTextField(
                        title: "State",
                        hintText: "State",
                        controller: schoolSettingController.stateController,
                        validator: (value)=>schoolSettingController.validateState(value),
                        onSaved: (value) {
                        },

                        ),
                        CommonTextField(
                        title: "City",
                        hintText: "City",
                        controller: schoolSettingController.cityController,
                        validator: (value)=>schoolSettingController.validateCity(value),
                        onSaved: (value) {

                        },
                        ),
                        CommonTextField(
                        title: "School Email",
                        hintText: "School Email",
                        controller: schoolSettingController.emailController,
                        validator: (value)=>schoolSettingController.validateEmail(value),
                        onSaved: (value) {

                        },
                        ),
                        CommonTextField(
                        title: "School Website",
                        hintText: "School Website",
                        controller: schoolSettingController.websiteController,
                        validator: (value)=>schoolSettingController.validateAddress(value),
                        onSaved: (value) {

                        },

                        ),

                        CommonTextField(
                         keyboardType: TextInputType.phone,
                        title: "School Phone Number",
                        hintText: "School Phone Number",
                        controller: schoolSettingController.phoneNumberController,
                        validator: (value)=>schoolSettingController.validatePhoneNumber(value),
                        onSaved: (value) {

                        },

                        ),

                        CommonTextField(
                        title: "Time Zone",
                        hintText: "Time Zone",
                        controller: schoolSettingController.timeZoneController,
                        validator: (value)=>schoolSettingController.validateTimeZone(value),
                        onSaved: (value) {

                        },

                        ),
                           const SizedBox(height: 15),
                            Container(
                                padding: const EdgeInsets.all(15),
                            width: MediaQuery.sizeOf(context).width,
                                decoration: BoxDecoration(
                                  borderRadius:BorderRadius.circular(10),
                                  border: Border.all(width: 0.5,color:AppColor.borderColor),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Text("Transaction Rates- Credit card (%)", style: TextStyles.textStyleFW400(AppColor.heavyTextColor, 14),),
                                          Text("3.00%", style: TextStyles.textStyleFW600(AppColor.heavyTextColor, 24),)
                                ]),
                              ),
                          const  SizedBox(height: 15),
                           Container(
                                width: MediaQuery.sizeOf(context).width,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius:BorderRadius.circular(10),
                                  border: Border.all(width: 0.5,color:AppColor.borderColor)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Text("Transaction Rates- ACH (\$)", style: TextStyles.textStyleFW400(AppColor.heavyTextColor, 14),),
                                          Text("1.0", style: TextStyles.textStyleFW600(AppColor.heavyTextColor, 24),)
                                ]),
                              ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),      
        );
      }
    );
  }
}



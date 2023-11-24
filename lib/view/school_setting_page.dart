import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:preto3/components/formatters.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/comman_textStyle.dart';
import 'package:preto3/utils/comman_textfield.dart';
import '../controller/school_setting_controller.dart';

class SchoolSettingPage extends StatelessWidget {
  
final SchoolSettingController schoolSettingController = SchoolSettingController();
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
                            width: 100,
                            height: 70,
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
                            width: 100,
                            height: 70,
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
                            width: 100,
                            height: 70,
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
                             padding: const EdgeInsets.all(10),
                            width: double.maxFinite,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color:AppColor.profileHeaderBG
                            ),
                            child: Text("School Details",style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14)),
                          ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Column(
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
                                    
                                                     const SizedBox(height: 10),
                                              Column(
                          children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Operating Start Time",
                                    style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                  const SizedBox(height: 5),
                                GestureDetector(
                                  onTap: () async {
                                    TimeOfDay? newTime = await showTimePicker(
                                      context: context,
                                      initialTime: controller.selectedStartTime.value,
                                    );
                                    if (newTime != null) {
                                      
                                        controller.selectedStartTime.value = newTime;
                                      
                               
                                    }
                                  },
                                  child: TextFormField(
                                    controller: schoolSettingController.selectedStartTimeController,
                                    enabled: false,
                                    style: TextStyles.textStyleFW400(AppColor.heavyTextColor, 14),
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.access_time,
                                        color: AppColor.heavyTextColor,
                                        size: 18,
                                      ),
                                       filled: true,
                                      fillColor: AppColor.disableColor, 
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10), 
                                        borderSide: BorderSide.none),
                                       contentPadding: EdgeInsets.symmetric(vertical: 11, horizontal: 8),
                                    ),
                                  ),
                                ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Operating End Time",
                                    style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                GestureDetector(
                                        onTap: () async {
                                    TimeOfDay? newTime = await showTimePicker(
                                      context: context,
                                      initialTime: controller.selectedEndTime.value,
                                    );
                                    if (newTime != null) {
                                    
                                        controller.selectedEndTime.value = newTime;
                                      
                                    
                                    }
                                  },
                                  child: TextFormField(
                                    controller: schoolSettingController.selectedEndTimeController,
                                    enabled: false,
                                    style:  TextStyles.textStyleFW400(AppColor.heavyTextColor, 14),
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.access_time,
                                        color: AppColor.heavyTextColor,
                                        size: 18,
                                      ),
                                       filled: true,
                                      fillColor: AppColor.disableColor, 
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10), 
                                        borderSide: BorderSide.none ),
                                          contentPadding: EdgeInsets.symmetric(vertical: 11, horizontal: 8),
                                      ),
                                    ),
                                ),
                        
                          ],
                        ),
                        SizedBox(height: 10),
                                    CommonTextField(
                                      title: "EIN/SSN#",
                                      hintText: "Enter EIN/SSN#",
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
                                  width: double.maxFinite,
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
                                  width: double.maxFinite,
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
                          ),
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



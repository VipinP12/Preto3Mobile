import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:preto3/components/rounded_button.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import '../../../controller/Admin/drawer_controller/admin_profile_controller.dart';
import '../../../utils/app_keys.dart';
import '../../../utils/comman_textStyle.dart';
import '../../../utils/comman_textfield.dart';

class EditAdminProfile extends StatefulWidget {
    const EditAdminProfile({Key? key}) : super(key: key);

  @override
  State<EditAdminProfile> createState() => _EditAdminProfileState();
}

class _EditAdminProfileState extends State<EditAdminProfile> {

  final adminProfileController = Get.find<AdminProfileController>( );


    void selectDatePicker()async{
      DateTime? datepicker = await showDatePicker(
          context: context,
          initialDate: adminProfileController.selectedDate ?? DateTime.now(),
          firstDate: DateTime(1999),
          lastDate:  DateTime(2028));
      if(datepicker!=null && datepicker !=adminProfileController.selectedDate){
        setState(() {
          adminProfileController.selectedDate = datepicker;
        });
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool isInnerScroll) {
            return [
              SliverAppBar(
                title: Text("Profile",
                  style: GoogleFonts.poppins(
                      color: AppColor.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                expandedHeight: 320,
                floating: false,
                pinned: true,
                actions: [
                  InkWell(
                    onTap:
                    adminProfileController.onSavePressed,
                    //     () {
                    //   print("edit profile");
                    //   adminProfileController.onSavePressed();
                    // },
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
                      child:  Obx(()=>Column(
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
                                '${adminProfileController.profilePic}',
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
                            "${adminProfileController.firstName.value} ${adminProfileController.lastName.value}",
                            // "${adminProfileController.storageBox.read(AppKeys.keyFirstName)} ${adminProfileController.storageBox.read(AppKeys.keyLastName)}",
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
                            "Check in/out Pin: ${adminProfileController.checkInCheckOut.value}",
                            style: GoogleFonts.poppins(
                                color: AppColor.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),)
                  ),
                  collapseMode: CollapseMode.parallax,
                ),
              )
            ];
          },
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
            child: SingleChildScrollView(
              child: Form(
                key: adminProfileController.adminProfileKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextField(
                      hintText: 'First Name',
                      title: 'First Name',
                      controller: adminProfileController.firstNameController,
                    ),
                    CommonTextField(
                      controller: adminProfileController.lastNameController,
                      hintText: 'Last Name',title: "Last Name",),
                    CommonTextField(
                      controller: adminProfileController.emailController,
                      hintText: 'Email', isEmailVerified: true,title: "example@1gmail.com",),
                    CommonTextField(
                      controller: adminProfileController.phoneNumberController,
                      hintText: '1234567890',title: "Phone Number",),
                    const Text("Date Of Birth",style: TextStyles.fontSize12),
                    const SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColor.disableColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:   Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                        child: InkWell(
                          onTap: (){
                            selectDatePicker();
                            log(adminProfileController.selectedDate != null
                                ? DateFormat('dd/MM/yyyy').format(adminProfileController.selectedDate!)
                                : "Enter date");
                          },
                          child:  Row(
                            children: [
                              const Icon(Icons.calendar_month_sharp),
                              const SizedBox(width: 10,),
                              Text(
                                adminProfileController.selectedDate != null
                                    ? DateFormat('dd/MM/yyyy').format(adminProfileController.selectedDate!)
                                    : adminProfileController.dateOfBirthController.text,
                                // "Enter date",
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    const Text("Spoken Languages",style: TextStyles.fontSize12),
                    const SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.disableColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButton<String>(
                              value: adminProfileController.selectedValue,
                              items: <String>['Hindi', 'English',]
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(value),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  adminProfileController.selectedValue = newValue!;
                                });
                              },
                              isExpanded: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CommonTextField(
                      controller: adminProfileController.bioController,
                      hintText: '---',title: "Bio",),
                    CommonTextField(
                      controller: adminProfileController.addressController,
                      hintText: 'Address',title: "Address",),
                    CommonTextField(
                      controller: adminProfileController.countryController,
                      hintText: 'Country',title: "Country",),
                    CommonTextField(
                        controller: adminProfileController.stateController,
                        hintText: 'State',title: "State"),
                    CommonTextField(
                      controller: adminProfileController.cityController,
                      hintText: 'City',title: "City",),
                    const SizedBox(height: 20,),
                    ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(horizontal: 10),
                      title: const Text("Change Password", style: TextStyles.fontSize12),
                      // leading: Icon(Icons.arrow_drop_down),
                      children: [
                        const SizedBox(height: 20),
                        CommonTextField(
                          controller: adminProfileController.oldChangeController,
                          hintText: 'Old Password',
                          title: 'Change Password',
                        ),
                        CommonTextField(
                          controller: adminProfileController.newChangeController,
                          hintText: 'New Password',
                          title: 'New Password',
                        ),
                        CommonTextField(
                          controller: adminProfileController.confirmChangeController,
                          hintText: 'Confirm Password',
                          title: 'Confirm Password',
                        ),
                        RoundedButton(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          color: AppColor.appPrimary,
                          onClick: () {
                            // parentController.changePasswordSession(context);
                          },
                          text: 'Change Password',
                          style: GoogleFonts.poppins(
                              color: AppColor.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50,),
                  ],
                ),
              ),
            ),
          )
      )
    );
  }
}

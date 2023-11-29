import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:intl/intl.dart';
import 'package:preto3/components/rounded_button.dart';
import 'package:preto3/model/language_model.dart';
import 'package:preto3/model/language_model.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import '../../controller/Admin/drawer_controller/admin_profile_controller.dart';
import '../../utils/app_keys.dart';
import '../../utils/comman_textStyle.dart';
import '../../utils/comman_textfield.dart';

class EditAdminProfile extends StatefulWidget {
    const EditAdminProfile({Key? key}) : super(key: key);

  @override
  State<EditAdminProfile> createState() => _EditAdminProfileState();
}

class _EditAdminProfileState extends State<EditAdminProfile> {
  final adminProfileController = Get.put(AdminProfileController());


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
                    onTap: () {
                     // log("edit");
                     adminProfileController.validateProfile();
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
                            adminProfileController.selectDatePicker(context);
                             log(adminProfileController.selectedDate != null
                                ?  adminProfileController.selectedDate.value
                                : "Enter date");
                          },
                          child:  Row(
                            children: [
                              const Icon(Icons.calendar_month_sharp),
                              const SizedBox(width: 10,),
                              Obx(() => Text(
                                adminProfileController.selectedDate.value,
                                // "Enter date",
                                style: const TextStyle(color: Colors.black),
                              ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    const Text("Spoken Languages",style: TextStyles.fontSize12),
                    const SizedBox(height: 10,),
                    adminProfileController.setLangList.isEmpty
                        ? Container()
                        : SizedBox(
                      height: 48,
                      width: double.maxFinite,
                      child: GetBuilder<AdminProfileController>(
                        builder: (controller) => ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                            controller.setLangList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    // controller.removeAllergies(
                                    //     controller
                                    //         .allergiesList[index]!);
                                  },
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: AppColor.allergiesBg,
                                        borderRadius:
                                        BorderRadius.circular(
                                            5)),
                                    child: Padding(
                                        padding: const EdgeInsets
                                            .symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .center,
                                          children: [
                                            Text(
                                              controller
                                                  .setLangList[
                                              index].name
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  color: AppColor
                                                      .allergiesText,
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight
                                                      .w400),
                                            ),
                                            const Padding(
                                              padding:
                                              EdgeInsets.only(
                                                  left: 8.0),
                                              child: Icon(
                                                Icons.close,
                                                size: 18,
                                                color: AppColor
                                                    .allergiesText,
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.disableColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Obx(()=>DropdownButton<LanguageModel>(
                            value: adminProfileController.selectedValue,
                            items: adminProfileController.allLanguageList
                                .map((LanguageModel? lang) {
                              return DropdownMenuItem<LanguageModel>(
                                value: lang,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(lang!.name),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              adminProfileController.setLanguage(newValue!);
                            },
                            isExpanded: true,
                          )),
                        ),
                      ],
                     ),
                  ),
                      CommonTextField(
                      controller: adminProfileController.bioController,
                      hintText: '---',title: "Bio",),
                    GooglePlaceAutoCompleteTextField(
                      textEditingController: adminProfileController.addressController,
                      boxDecoration: const BoxDecoration(
                        border: Border.fromBorderSide(BorderSide.none)
                      ),
                      googleAPIKey: ApiEndPoints.googleTimeZoneApiKey,
                      inputDecoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.borderColor)
                        ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColor.borderColor)
                          )
                      ),
                      debounceTime: 400,
                      countries: const ["in", "us"],
                      isLatLngRequired: false,
                      getPlaceDetailWithLatLng: (Prediction prediction) {
                        print("placeDetails ${prediction.lat}");
                      },

                      itemClick: (Prediction prediction) {
                        log("ADDRESS SELECTED:${prediction.description}");
                        log("COUNTRY SELECTED:${prediction.description}");
                        log("COUNTRY ID:${prediction.id}");
                        log("PLACE ID:${prediction.placeId}");
                        adminProfileController.addressController.text = prediction.description ?? "";
                        adminProfileController.addressController.selection = TextSelection.fromPosition(
                            TextPosition(offset: prediction.description?.length ?? 0));
                        final predictedParts = prediction.description!.split(",");

                        if (predictedParts.length >= 3) {
                          int startIndex = predictedParts.length - 3;
                          adminProfileController.cityController.text = predictedParts[startIndex].trim();
                          adminProfileController.stateController.text = predictedParts[startIndex+1].trim();
                          adminProfileController.countryController.text = predictedParts[startIndex+2].trim();
                          adminProfileController.addressController.text=prediction.description!.toString();
                          log("COUNTRY:${adminProfileController.countryController.text}");
                          log("STATE:${adminProfileController.stateController.text}");
                          log("CITY:${ adminProfileController.cityController.text}");
                        }
                      },
                      seperatedBuilder: const Divider(),
                      // OPTIONAL// If you want to customize list view item builder
                      itemBuilder: (context, index, Prediction prediction) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on),
                              const SizedBox(
                                width: 7,
                              ),
                              Expanded(child: Text(prediction.description??""))
                            ],
                          ),
                        );
                      },

                      isCrossBtnShown: false,

                      // default 600 ms ,
                    ),
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

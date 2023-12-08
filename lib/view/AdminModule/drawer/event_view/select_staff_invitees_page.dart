import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/components/rounded_button.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_dimens.dart';

class SelectStaffInvitees extends StatelessWidget {
  const SelectStaffInvitees({super.key});

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
        centerTitle: false,
        title: Text(
          "Select Staff Invitees",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: Column(
              children: [
                Container(
                  height: 45,
                    width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    color: AppColor.disableColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: DropdownButton<String>(
                      hint: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Select Room",
                          style: GoogleFonts.poppins(
                            color: AppColor.lightTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      isExpanded: true,
                      icon: Visibility(
                        visible: true,
                        child: SvgPicture.asset(AppAssets.dropdownIcon),
                      ),
                      dropdownColor: AppColor.white,
                      borderRadius: BorderRadius.circular(10),
                      iconEnabledColor: AppColor.appPrimary,
                      underline: Container(),
                      items: ["Room 1",]
                          .map(
                            (String room) => DropdownMenuItem<String>(
                              value:"",
                              child: Text(
                                room,
                                style: GoogleFonts.poppins(
                                  color: AppColor.heavyTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (changed) {
                      },
                    ),
                  ),
                ),
const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Checkbox(
                value: false, 
                checkColor: AppColor.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                onChanged: (changed) {
               
                },
              ),
              const Text("Select All"),
            ],
          ),
          const SizedBox(
            height: AppDimens.paddingVertical16,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  GridView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2 /2,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: 6, 
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8),
                        child: InkWell(
                          onTap: () {
                         
                          },
                          child: Container(
                            height: 120,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage:  AssetImage(AppAssets.profile)
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Name",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  
                ],
              ),
            ),
          ),
 const SizedBox(height: 20),
             RoundedButton(
                 height: 42,
                 width: MediaQuery.sizeOf(context).width,
                 color: AppColor.appPrimary,
                 onClick: () {
                 },
                 text: 'Add',
                 style: GoogleFonts.poppins(
                     color: AppColor.white,
                     fontWeight: FontWeight.w400,
                     fontSize: 16)),
              ],
            ),
          ),
    );
  }
}


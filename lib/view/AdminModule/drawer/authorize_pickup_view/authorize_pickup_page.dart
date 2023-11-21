import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controller/Admin/authorize_pickup_controller.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_routes.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/comman_textStyle.dart';

class AdminAuthorizePickUp extends StatelessWidget {
    AdminAuthorizePickUp({super.key});

  final adminAuthorizePickupController = Get.find<AdminAuthorizePickUpController>();

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
          AppString.authorizedPickUp,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: InkWell(
              onTap: () {
                // _bottomFilterDateSheet(context);
              },
              child: SvgPicture.asset(
                AppAssets.filterIcon,
                height: 24,
                width: 24,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount:  adminAuthorizePickupController.authorizePickUPList.length,
          itemBuilder: (context, index) {
            return  InkWell(
              onTap: (){
                print(adminAuthorizePickupController.authorizePickUPList[index].title);
                Get.toNamed(AppRoute.adminAuthorizePickupDetail);
              },
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 20),
                leading: CircleAvatar(
                  // maxRadius: 38,
                  child: Image.asset(AppAssets.placeHolder),
                ),
                title: Text(adminAuthorizePickupController.authorizePickUPList[index].title,
                style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 18.0,),),
                trailing: Container(
                  alignment: Alignment.center,
                  width: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(thickness: 0.5,); // Customize the Divider as needed
          },
        ),
      ),
    );
  }
}

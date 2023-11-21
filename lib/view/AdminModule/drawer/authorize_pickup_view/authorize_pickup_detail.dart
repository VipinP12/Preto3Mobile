import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/app_assets.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/comman_textStyle.dart';

class AuthorizePickUpDetail extends StatelessWidget {
  const AuthorizePickUpDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body:  Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Image.asset(AppAssets.placeHolder),
                ),
                SizedBox(width: 20,),
                Text("UserName",
                  style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 18.0,),),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            Container(
               margin: EdgeInsets.symmetric(vertical: 20),
              width: MediaQuery.of(context).size.width,
              height: 45,
              decoration: BoxDecoration(
                color: AppColor.dashRoomBg,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("06/09/2023  - ",
                      style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14.0,),),
                  ),
                  Text(" 07/01/2025",
                    style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14.0,),)
                ],
              ),
            ),
            CircleAvatar(
              maxRadius: 50,
              child: Image.asset(AppAssets.placeHolder),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.person_outline_outlined,size: 30,),
                SizedBox(width: 10,),
                Text("username",
                  style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14.0,),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Icon(Icons.email_outlined,size: 25,),
                  SizedBox(width: 10,),
                  Text("example@gmail.com",
                    style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14.0,),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Icon(Icons.phone,size: 25,),
                SizedBox(width: 10,),
                Text("1234567890",
                  style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14.0,),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Icon(Icons.access_time,size: 26,),
                  SizedBox(width: 10,),
                  Text("05:00PM",
                    style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14.0,),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Container(
                    height: 30,
                      width: 30,
                      child: SvgPicture.asset(AppAssets.authorizeIcon)),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Text(
                      "Wonderland Avenue Elementary School, Los Angeles, California, USA",
                      style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14.0,),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';

import '../view/daily_activities_page.dart';

class CustomDialog extends StatelessWidget {
  final String message;
  final int? roleId;
  const CustomDialog({Key? key, required this.message, this.roleId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        height: 170,
        width: 300,
        decoration: BoxDecoration(
            color: AppColor.white, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: SvgPicture.asset(AppAssets.successIcon)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Flexible(
                  child: Text(
                    message,
                    style: GoogleFonts.poppins(
                        color: AppColor.heavyTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (roleId == 4) {
                    Get.offAllNamed(AppRoute.dashboardParent);
                  } else if (roleId == 3) {
                    Get.close(4);
                  } else {
                    Get.offAllNamed(AppRoute.dashboard);
                  }
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'OK',
                    style: GoogleFonts.poppins(
                        color: AppColor.appPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

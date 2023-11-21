import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/app_assets.dart';
import '../utils/app_color.dart';

class UpdateAlert {
  static void updateAlertBox() {
    print("Update alert box");
    try {
      final newVersion = NewVersionPlus(
        iOSId: 'xyz.teknol.preto3',
        androidId: 'xyz.teknol.preto3',
      );
      //const simpleBehavior = false;

      // if (simpleBehavior) {
      //   basicStatusCheck(newVersion);
      // } else {
      advancedStatusCheck(newVersion);
      // }
    } catch (e) {
      print(e);
    }
  }

// basicStatusCheck(NewVersionPlus newVersion) {
//   newVersion.showAlertIfNecessary(context: context);
// }

  static advancedStatusCheck(NewVersionPlus newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null && status.canUpdate == true) {
      log(status.releaseNotes.toString());
      log(status.appStoreLink);
      log(status.localVersion);
      log(status.storeVersion);
      log(status.canUpdate.toString());
      Get.dialog(
          barrierDismissible: false,
          UpdateDialoge(
            link: status.appStoreLink,
          ));
      // ignore: use_build_context_synchronously
      // newVersion.showUpdateDialog(
      //     context: context,
      //     versionStatus: status,
      //     allowDismissal: false,
      //     dismissButtonText: 'Cancel',
      //     dismissAction: () {
      //       SystemNavigator.pop();
      //     },
      //     dialogText: "Dear user! Your PreTo3 is out of date please update!",
      //     launchMode: LaunchMode.externalApplication);
    }
  }
}

class UpdateDialoge extends StatelessWidget {
  String link;
  UpdateDialoge({super.key, required this.link});

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
              Text(
                "Update Alert",
                style: GoogleFonts.poppins(
                    color: AppColor.heavyTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w800),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "Dear user! Your PreTo3 is out of date please update!",
                  style: GoogleFonts.poppins(
                      color: AppColor.heavyTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(
                            color: AppColor.appPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (!await launchUrl(Uri.parse(link))) {
                        throw Exception('Could not launch $link');
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
            ],
          ),
        ),
      ),
    );
  }
}

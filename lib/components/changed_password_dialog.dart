import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/Parent/parent_dashboard_controller.dart';
import 'package:preto3/controller/Staff/staff_dashboard_controller.dart';
import 'package:preto3/network/is_internet_connected.dart';
import 'package:preto3/network/socket_server.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_dialog.dart';
import 'package:preto3/utils/app_routes.dart';

import '../utils/app_keys.dart';

class ChangedPasswordDialog extends StatelessWidget {
  final String message;
  const ChangedPasswordDialog({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                if (await InternetConnection.checkIsInternetConnected()) {
                  if (GetStorage().read(AppKeys.keyRoleId) == 4) {
                    Get.find<ParentDashboardController>().storageBox.erase();
                  } else {
                    Get.find<StaffDashboardController>().storageBox.erase();
                  }

                  SocketServer.instance!.socket.close();
                  Get.offAllNamed(AppRoute.login);
                } else {
                  AppDialog.snackBarDialog(
                      title: "Network Error",
                      message: "You are not connected to the internet.");
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
    );
  }
}

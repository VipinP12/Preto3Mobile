import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import '../network/is_internet_connected.dart';
import '../network/socket_server.dart';
import '../utils/app_routes.dart';
import '../utils/toast.dart';

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({Key? key}) : super(key: key);

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
        actions: [
          Container(
            height: 35,
            width: 35,
            margin: const EdgeInsets.only(right: 30, top: 10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: InkWell(
                onTap: () async {
                  if (await InternetConnection.checkIsInternetConnected()) {
                    GetStorage().erase();
                    SocketServer.instance!.socket.close();
                    Get.offAllNamed(AppRoute.login);
                  } else {
                    // ignore: use_build_context_synchronously
                    messageToastWarning(
                        context, "You are not connected to the internet.");
                  }
                },
                child: SvgPicture.asset(AppAssets.logoutIcon),
              ),
            ),
          )
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Center(child: Lottie.asset(AppAssets.comingSonn))),
          ],
        ),
      ),
    );
  }
}

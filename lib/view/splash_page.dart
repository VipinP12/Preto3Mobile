import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preto3/controller/splash_controller.dart';
import 'package:preto3/utils/app_color.dart';
import '../utils/app_assets.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  final splashController = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.appPrimary,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.maxFinite,
          child: const Center(
            child: Image(
              image: AssetImage(
                AppAssets.appLogo,
              ),
              fit: BoxFit.contain,
            ),
          ),
        ));
  }
}

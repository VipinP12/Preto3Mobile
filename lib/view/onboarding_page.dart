import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/onboarding_controller.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../utils/app_assets.dart';

class OnBoardingPage extends StatelessWidget {
  OnBoardingPage({Key? key}) : super(key: key);

  final onBoardingController = Get.find<OnBoardingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              top: 80,
              left: 16,
              right: 16,
              child: Image(
                image: AssetImage(AppAssets.appName),
                height: 30,
              ),
            ),
            Positioned(
              top: 120,
              left: 16,
              right: 16,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.maxFinite,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: PageView.builder(
                  controller: onBoardingController.pageController,
                  onPageChanged: onBoardingController.currentIndex,
                  itemCount: onBoardingController.onBoardingList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Image(
                          image: AssetImage(onBoardingController
                              .onBoardingList[index].imageAsset),
                          height: MediaQuery.of(context).size.height * 0.45,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                            height: 60,
                            width: double.maxFinite,
                            child: Center(
                              child: Text(
                                onBoardingController.onBoardingList[index].desc,
                                style: GoogleFonts.poppins(
                                    color: AppColor.heavyTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ],
                    );
                  },
                ),
              ),
            ),
            Positioned(
                bottom: MediaQuery.of(context).size.height * 0.25,
                left: 16,
                right: 16,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: onBoardingController.pageController,
                    count: 4,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 6,
                      dotWidth: 12,
                      dotColor: AppColor.disableColor,
                      activeDotColor: AppColor.mediumTextColor,
                      expansionFactor: 2,
                    ),
                  ),
                )),
            Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Column(
                  children: [
                    InkWell(
                      splashColor: AppColor.white,
                      onTap: () {
                        Get.toNamed(AppRoute.login);
                      },
                      child: Container(
                        height: 50,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: AppColor.appPrimary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Log in",
                            style: GoogleFonts.poppins(
                                color: AppColor.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      splashColor: AppColor.white,
                      onTap: () {
                        Get.toNamed(AppRoute.signUp);
                      },
                      child: Container(
                        height: 50,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: AppColor.disableColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.poppins(
                                color: AppColor.appPrimary,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

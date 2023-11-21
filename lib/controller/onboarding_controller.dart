import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preto3/model/onboarding_model.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_routes.dart';

import '../components/update_alertbox.dart';

class OnBoardingController extends GetxController {
  var pageController = PageController();
  var currentIndex = 0.obs;
  static const pageDuration = Duration(milliseconds: 300);
  static const pageCurve = Curves.easeIn;

  /*void setCurrentIndex(int index){
    currentIndex.value=index;
    update();
  }*/

  bool get isLastPage => currentIndex.value == onBoardingList.length - 1;

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
    UpdateAlert.updateAlertBox();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  /*nextFunction(){
    print("CURRENT INDEX:${currentIndex.value}");
    if(isLastPage){
      //to login page
      Get.offAndToNamed(AppRoute.login);
    }else{
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.easeIn);
      update();
    }
  }*/

  List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(AppAssets.onBoard1, AppAssets.appName,
        "One platform for all your needs!"),
    OnBoardingModel(AppAssets.onBoard2, AppAssets.appName,
        "An innovative app for daycare management!"),
    OnBoardingModel(AppAssets.onBoard3, AppAssets.appName,
        "Focus on the kids while still growing your business!"),
    OnBoardingModel(AppAssets.onBoard4, AppAssets.appName,
        "Spend less time on paperwork and more time with kids!"),
  ];
}

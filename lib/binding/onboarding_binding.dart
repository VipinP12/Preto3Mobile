import 'package:get/get.dart';

import '../controller/Admin/admin_deshboard_controller.dart';
import '../controller/Admin/drawer_controller/admin_profile_controller.dart';
import '../controller/onboarding_controller.dart';

class OnBoardingBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(OnBoardingController());

  }

}
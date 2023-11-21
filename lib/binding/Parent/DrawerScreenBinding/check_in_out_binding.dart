import 'package:get/get.dart';

import '../../../controller/Parent/DrawerController/check_in_out_controller.dart';

class CheckInOutBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CheckInOutController());
  }
}

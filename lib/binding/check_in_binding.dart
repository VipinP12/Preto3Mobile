import 'package:get/get.dart';
import 'package:preto3/controller/checkin_controller.dart';

import '../controller/Staff/staff_dashboard_controller.dart';

class CheckInBinding extends Bindings{

  @override
  void dependencies() {
    Get.put(CheckInController());
    // Get.put(StaffDashboardController());
  }

}
import 'package:get/get.dart';

import '../../controller/Admin/dashboard_staff_controller.dart';

class AdminDashboardStaffBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AdminStaffController());

  }

}
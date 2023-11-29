import 'package:get/get.dart';

import '../../../controller/Admin/staff_management/dashboard_staff_controller.dart';

class AdminDashboardStaffBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AdminStaffController());

  }

}
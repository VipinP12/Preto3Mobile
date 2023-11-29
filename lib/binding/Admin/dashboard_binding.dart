import 'package:get/get.dart';
import 'package:preto3/controller/Admin/dashboard_controller.dart';
import 'package:preto3/controller/Admin/room_management/room_controller.dart';

import '../../controller/Admin/drawer_controller/admin_profile_controller.dart';

class DashboardBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(DashboardController());
    // Get.put(AdminDashboardController());
    Get.put(AdminProfileController());
    Get.put(RoomController());
  }

}
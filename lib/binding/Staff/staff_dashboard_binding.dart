import 'package:get/get.dart';
import 'package:preto3/controller/Admin/dashboard_controller.dart';
import 'package:preto3/controller/Staff/staff_dashboard_controller.dart';
import 'package:preto3/controller/google_places_controller.dart';

class StaffDashboardBinding extends Bindings{

  @override
  void dependencies() {
    Get.put(StaffDashboardController());
  }

}
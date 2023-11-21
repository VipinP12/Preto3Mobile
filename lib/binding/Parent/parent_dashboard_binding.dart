import 'package:get/get.dart';
import 'package:preto3/controller/Communication/communication_controller.dart';
import 'package:preto3/controller/Parent/parent_dashboard_controller.dart';
import 'package:preto3/controller/daily_activity_controller.dart';
import 'package:preto3/controller/google_places_controller.dart';

class ParentDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CommunicationController());
    Get.put(ParentDashboardController());
    Get.put(GooglePlacesController());
    Get.put(DailyActivityController());
  }
}

import 'package:get/get.dart';
import '../../../controller/Admin/checkin_checkout_management/admin_checkin_checkout_controller.dart';

class AdminCheckInCheckOutBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CheckInCheckOutController());
  }

}
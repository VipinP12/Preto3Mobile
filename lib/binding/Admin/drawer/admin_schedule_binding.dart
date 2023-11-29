import 'package:get/get.dart';
import '../../../controller/Admin/admin_schedule_controller.dart';

class  AdminScheduleBinding extends Bindings {

  @override
  void dependencies() {
    Get.put(AdminScheduleController());
  }

}
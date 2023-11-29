import 'package:get/get.dart';
import '../../../controller/Admin/staff_management/add_new_staff_controller.dart';

class AddNewStaffBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ProfileAddStaffController());
  }
}
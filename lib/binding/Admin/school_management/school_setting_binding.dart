import 'package:get/get.dart';
import 'package:preto3/controller/Admin/school_management/school_setting_controller.dart';

class SchoolSettingBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SchoolSettingController());
  }

}
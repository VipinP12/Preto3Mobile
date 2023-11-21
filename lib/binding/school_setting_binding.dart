import 'package:get/get.dart';
import 'package:preto3/controller/school_setting_controller.dart';

class SchoolSettingBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SchoolSettingController());
  }

}
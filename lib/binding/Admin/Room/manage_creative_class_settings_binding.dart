import 'package:get/get.dart';
import 'package:preto3/controller/Admin/rooms_controller/manage_creative_class_settings_controller.dart';


class ManageCreativeClassSettingsBinding extends Bindings{
  @override
  void dependencies() {
     Get.put(ManageCreativeClassSettingsController());

  }

}
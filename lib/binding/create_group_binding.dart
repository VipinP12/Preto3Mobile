import 'package:get/get.dart';
import 'package:preto3/controller/Communication/create_group_controller.dart';

class CreateGroupBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CreateGroupController());
  }

}
import 'package:get/get.dart';
import 'package:preto3/controller/select_role_controller.dart';

class SelectRoleBinding extends Bindings{

  @override
  void dependencies() {
   Get.put(SelectRoleController());

  }

}
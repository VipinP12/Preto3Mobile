import 'package:get/get.dart';
import 'package:preto3/controller/reset_password_controller.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ResetPasswordController());
  }
}

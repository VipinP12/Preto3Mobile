import 'package:get/get.dart';
import 'package:preto3/controller/forgot_password_controller.dart';

class ForgotPasswordBinding extends Bindings{

  @override
  void dependencies() {
    Get.put(ForgotPasswordController());
  }

}
import 'package:get/get.dart';
import 'package:preto3/controller/sign_up_controller.dart';

class SignUpBinding extends Bindings{
  @override
  void dependencies() {
   Get.put(SignUpController());
  }

}
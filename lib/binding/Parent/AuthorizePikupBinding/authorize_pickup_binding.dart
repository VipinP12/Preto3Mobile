import 'package:get/get.dart';
import 'package:preto3/controller/Parent/AuthorizePickup/authorize_pickup_controller.dart';

class AuthorizePikupBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthorizePikupController());
  }
}

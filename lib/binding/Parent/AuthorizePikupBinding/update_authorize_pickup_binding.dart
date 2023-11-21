import 'package:get/get.dart';
import 'package:preto3/controller/Parent/AuthorizePickup/update_authorize_pickup_controller.dart';

class UpdateAuthorizePikupBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UpdateAuthorizePikupCreateController());
  }
}

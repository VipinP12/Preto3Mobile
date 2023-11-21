import 'package:get/get.dart';

import '../../../controller/Parent/AuthorizePickup/authorize_pickup_create_controller.dart';

class AuthorizePikupCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthorizePikupCreateController());
  }
}

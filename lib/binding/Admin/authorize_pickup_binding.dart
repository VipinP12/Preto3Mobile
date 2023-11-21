import 'package:get/get.dart';

import '../../controller/Admin/authorize_pickup_controller.dart';

class AuthorizePickUPBinding extends Bindings {

  @override
  void dependencies() {
    Get.put(AdminAuthorizePickUpController());
  }

}
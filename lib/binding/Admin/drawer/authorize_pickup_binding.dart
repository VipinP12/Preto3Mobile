import 'package:get/get.dart';

import '../../../controller/Admin/drawer_controller/authorize_pickup_controller.dart';

class AuthorizePickUPBinding extends Bindings {

  @override
  void dependencies() {
    Get.put(AdminAuthorizePickUpController());
  }

}
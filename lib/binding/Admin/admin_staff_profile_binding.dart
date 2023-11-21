import 'package:get/get.dart';

import '../../controller/Admin/admin_staff_profile.dart';

class  AdminStaffProfileBinding extends Bindings {

  @override
  void dependencies() {
    Get.put(AdminStaffProfileController());
  }

}